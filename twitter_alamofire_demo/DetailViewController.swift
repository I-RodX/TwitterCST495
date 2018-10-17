//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Isaac on 10/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailHandle: UILabel!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var detailCreatedAt: UILabel!
    @IBOutlet weak var detailRetweet: UIButton!
    @IBOutlet weak var detailRetweetCount: UILabel!
    @IBOutlet weak var detailFavorite: UIButton!
    @IBOutlet weak var detailFavoriteCount: UILabel!
    
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if(tweet.retweeted == false){
            tweet.retweeted = true
            tweet.retweetCount += 1
            refreshData()
            APIManager.shared.retweet(with: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error Retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully Retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else{
            tweet.retweeted = false
            tweet.retweetCount -= 1
            refreshData()
            APIManager.shared.unretweet(with: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error Unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully Unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if(tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount += 1
            refreshData()
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else{
            tweet.favorited = false
            tweet.favoriteCount -= 1
            refreshData()
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
                
            }
        }
    }
    
    func refreshData(){
    
        detailName.text = tweet.user?.name
        detailHandle.text = "@" + (tweet.user?.screenName)!
        detailText.text = tweet.text
        detailCreatedAt.text = tweet.createdAtString
        detailRetweetCount.text = String(tweet.retweetCount)
        detailFavoriteCount.text = String(tweet.favoriteCount)
        
        if(tweet.favorited)!{
            detailFavorite.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }
        if(tweet.favorited == false){
            detailFavorite.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        if(tweet.retweeted){
            detailRetweet.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }
        if(tweet.retweeted==false){
            detailRetweet.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        
        let profileImage = NSURL(string: tweet.user!.profilePhoto!)
        detailImage.setImageWith(profileImage! as URL)
        
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
