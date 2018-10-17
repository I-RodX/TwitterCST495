//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Isaac on 10/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileHandle: UILabel!
    @IBOutlet weak var profileTweets: UILabel!
    @IBOutlet weak var profileFollows: UILabel!
    @IBOutlet weak var profileFollowers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profImage = URL(string: (User.current?.profilePhoto)!)
        profileImage.af_setImage(withURL: profImage!)
        profileName.text = User.current?.name
        profileHandle.text = "@" + (User.current?.screenName)!
        profileFollowers.text = String((User.current?.followersCount)!)
        profileFollows.text = String((User.current?.friendCount)!)
        profileTweets.text = String((User.current?.postCount)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
