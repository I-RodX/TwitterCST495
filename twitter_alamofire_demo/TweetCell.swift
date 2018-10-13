//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Isaac on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AFNetworking


class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetUsernameLabel: UILabel!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetCreatedAtLabel: UILabel!
    @IBOutlet weak var tweetRetweetButton: UIButton!
    @IBOutlet weak var tweetRetweetedLabel: UILabel!
    @IBOutlet weak var tweetFavoriteButton: UIButton!
    @IBOutlet weak var tweetFavoritedLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            refreshData()
            
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func refreshData(){
        tweetTextLabel.text = tweet.text
        tweetUsernameLabel.text = tweet.user?.name
        tweetScreenNameLabel.text = "@"+(tweet.user?.screenName)!
        tweetCreatedAtLabel.text = tweet.createdAtString
        tweetRetweetedLabel.text = String(tweet.retweetCount)
        tweetFavoritedLabel.text = String(tweet.favoriteCount)
        
        if(tweet.favorited)!{
            tweetFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }
        if(tweet.favorited == false){
            tweetFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        if(tweet.retweeted){
            tweetRetweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }
        if(tweet.retweeted==false){
            tweetRetweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }

        
        let profileImage = NSURL(string: tweet.user!.profilePhoto!)
        tweetProfileImageView.setImageWith(profileImage! as URL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
