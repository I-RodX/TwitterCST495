//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Isaac on 10/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AFNetworking
import AlamofireImage

protocol ComposeViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var composeImage: UIImageView!
    @IBOutlet weak var composeName: UILabel!
    @IBOutlet weak var composeHandle: UILabel!
    @IBOutlet weak var composeCharCount: UILabel!
    @IBOutlet weak var composeTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        composeTextField.delegate = self
        
        composeName.text = User.current?.name
        composeHandle.text = "@"+String((User.current?.screenName)!)
        
        let profileImage = URL(string: (User.current?.profilePhoto)!)
        composeImage.af_setImage(withURL: profileImage!)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        composeTextField.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        composeCharCount.text = String(140 - newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }

    @IBAction func didTapTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeTextField.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.performSegue(withIdentifier: "backHomeSegue", sender: Any?.self)
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
