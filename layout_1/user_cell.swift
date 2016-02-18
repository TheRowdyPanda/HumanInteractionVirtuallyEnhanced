//
//  user_cell.swift
//  layout_1
//
//  Created by Rijul Gupta on 3/15/15.
//  Copyright (c) 2015 Rijul Gupta. All rights reserved.
//

import UIKit



class user_cell: UITableViewCell {
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    //@IBOutlet var valueLabel: UILabel!
    
    var userFBID = "none"
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //userImage.image = UIImage(data: data!)
        //userImage.layer.borderWidth=1.0
        userImage.layer.masksToBounds = false
        //userImage.layer.borderColor = UIColor.whiteColor().CGColor
        //profilePic.layer.cornerRadius = 13
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        userImage.clipsToBounds = true
        
        //followButton.frame.width = self.frame.width/4
        //followButton.frame = CGRect(x: followButton.frame.origin.x, y: followButton.frame.origin.y, width: self.frame.width, height: followButton.frame.height)
        followButton.backgroundColor = UIColor.clearColor()
        //followButton.layer.cornerRadius = followButton.frame.width/4
        followButton.layer.borderWidth = 0
        //followButton.layer.borderColor = UIColor.clearColor().CGColor
        
      
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func toggle_user_follow(){
        
        
        self.followButton.titleLabel?.text = "..."
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let fbid = defaults.stringForKey("saved_fb_id") as String!
        
        
        
        let url = NSURL(string: "http://groopie.pythonanywhere.com/mobile_toggle_user_follow")
        //START AJAX
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["gUser_fbID":fbid, "iUser_fbID":userFBID] as Dictionary<String, String>
        
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch var error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            var err: NSError?
            
            var json: NSDictionary?
            do{
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            } catch let error as NSError{
                err = error
            } catch {
                
            }
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                
                if let parseJSON = json {
                    
                    let valTest = parseJSON["results"]![0]["value"] as! String!
                    
                    if(valTest == "yes"){//user did just follow
                        dispatch_async(dispatch_get_main_queue(),{
            
            
                    //self.followButton.titleLabel?.text = "done"
                            //self.followButton.setTitle("unfollow", forState: UIControlState.Normal)
                            self.followButton.setImage(UIImage(named: "Unfollow.png"), forState: UIControlState.Normal)
                        })
                    }
                    else{
                        //user did just unfollow
                        dispatch_async(dispatch_get_main_queue(),{
                            
                            
                            //self.followButton.titleLabel?.text = "done"
                            //self.followButton.setTitle("follow", forState: UIControlState.Normal)
                            self.followButton.setImage(UIImage(named: "Follow.png"), forState: UIControlState.Normal)
                        })
                        
                    }
                    
                }
                else {
                    
                    
                }
            }
        })
        task.resume()
        //END AJAX
        
    }

    
}
