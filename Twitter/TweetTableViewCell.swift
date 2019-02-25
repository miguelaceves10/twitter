//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Miguel Aceves on 2/15/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

	@IBOutlet var profileImageView: UIImageView!
	@IBOutlet var userNameLabel: UILabel!
	@IBOutlet var tweetContentLabel: UILabel!
	@IBOutlet var favButton: UIButton!
	@IBOutlet var retweetButton: UIButton!
	
	var favorited:Bool = false
	var tweetId:Int = -1
	
	@IBAction func favoriteTweet(_ sender: Any) {
		
		let toBeFavorited = !favorited
		if(toBeFavorited){
			TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
				self.setFavorite(true)
			}, failure: { (Error) in
				print("Favorite did not succeed: \(Error)")
			})
		}
		else{
			TwitterAPICaller.client?.UnfavoriteTweet(tweetId: tweetId, success: {
				self.setFavorite(false)
			}, failure: { (Error) in
				print("Unfavorite did not succeed: \(Error)")
			})
		}
	}
	
	@IBAction func retweet(_ sender: Any) {
		TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
			self.setRetweeted(true)
		}, failure: { (Error) in
			print("Error is retweeting: \(Error)")
		})
	}
	
	func setRetweeted(_ isRetweeted:Bool){
		if(isRetweeted){
			retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
			retweetButton.isEnabled = false
		}
		else{
			retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
			retweetButton.isEnabled = true
		}
	}
	
	func setFavorite(_ isFavorited:Bool){
		favorited = isFavorited
		if(favorited){
			favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
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
