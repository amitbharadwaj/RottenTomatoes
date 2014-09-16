//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Amit Bharadwaj on 9/14/14.
//  Copyright (c) 2014 Amit Bharadwaj. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsysLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movieDictionary:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieDictionary["title"] as? String
        synopsysLabel.text = movieDictionary["synopsis"] as? String
        
        let imagesDictionary = movieDictionary["posters"] as NSDictionary
        
        // Load thumbnail firsts
        let thumbnail = imagesDictionary["thumbnail"] as NSString
        let tmbUrl = NSURL(string: thumbnail)
        posterImageView.setImageWithURL(tmbUrl)
        
        // I am assuming here that thumbnail will be downloaded quickly and cannot override the high-res image.
        // TODO check for data in cache
        // Load original once it is downloaded
        let original = (thumbnail).stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        let origUrl = NSURL(string: original)
        posterImageView.setImageWithURL(origUrl)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
