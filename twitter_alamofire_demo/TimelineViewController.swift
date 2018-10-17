//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource {
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 205
        fetchTweets()
        

        // Do any additional setup after loading the view.
    }
    
    func did(post: Tweet){
        tweets.insert(post, at: 0)
        tableView.reloadData()
    }
    
    func fetchTweets(){
        APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }

    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
   
    @IBAction func didTapCompse(_ sender: Any) {
        self.performSegue(withIdentifier: "composeSegue", sender: Any?.self)
    }
    
   
    @IBAction func didTapProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "profileSegue", sender: Any?.self)
    }
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchTweets()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailViewController = segue.destination as? DetailViewController{
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let tweet = tweets[indexPath.row]
                detailViewController.tweet = tweet
            }
        } 
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
