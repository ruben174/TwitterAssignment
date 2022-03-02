//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Ruben Esqueda on 2/22/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    var favorited = false
    var tweetId: Int = -1
    
    
    
    @IBOutlet weak var retweet: UIButton!
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("Error in retweeting: \(error)")
        })
    }
    func setRetweeted(isRetweeted: Bool){
        if(isRetweeted){
            retweet.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet.isEnabled = false
        }
        else{
            retweet.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet.isEnabled = true
        }
    }
    @IBOutlet weak var favButton: UIButton!
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (error) in
                print("Favorite did not succed: \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { (error) in
                print("Unfavorite did not succed: \(error)")
            })
        }
    }
    
    func setFavorite( isFavorited: Bool){
        favorited = isFavorited
        
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
