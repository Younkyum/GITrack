//
//  UserViewController.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/25.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var todayCommitLabel: UILabel!
    @IBOutlet weak var userFollowingLabel: UILabel!
    @IBOutlet weak var userFollowerLabel: UILabel!
    @IBOutlet weak var userCreatedAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDownload(url: URL(string: userInfo.avatarURL)!)
        
        changeDate()
        
        userIdLabel.text = userInfo.userID
        userNameLabel.text = userInfo.userName
        userFollowingLabel.text = String(userInfo.followings)
        userFollowerLabel.text = String(userInfo.followers)
        userCreatedAtLabel.text = userInfo.createdAt
        
    }
    
    func changeDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        print(userInfo.createdAt)
        let a = formatter.date(from: userInfo.createdAt)!
        formatter.dateFormat = "yyyy-MM-dd"
        userInfo.createdAt = formatter.string(from: Date(timeInterval: 32400, since: a))
        
        
    }
    
    func imageDownload(url: URL) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("Download image fail : \(url)")
                    return
            }

            DispatchQueue.main.async() {[weak self] in
                print("Download image success \(url)")

                self?.userAvatarImage.image = image
            }
        }.resume()
    }

    
}
