//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Amit Bharadwaj on 9/14/14.
//  Copyright (c) 2014 Amit Bharadwaj. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var synopsysTextView: UITextView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    var movieDictionary:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollview.delegate = self
        self.scrollview.contentSize = CGSizeMake(320, 1000)
        self.scrollview.backgroundColor = UIColor.clearColor()
        
        titleLabel.text = movieDictionary["title"] as? String
        synopsysTextView.text = movieDictionary["synopsis"] as? String
        
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
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        println(self.scrollview.contentOffset.y)
        
        if (scrollview == self.scrollview) {
            let yOffset:CGFloat = scrollview.contentOffset.y - self.view.frame.origin.y
            
            let cgPoint:CGPoint = CGPointMake(0, yOffset)

        }
        
//        let frame:CGRect = scrollview.bounds
//        let offsetFrame:CGRect = CGRectOffset(frame, cgPoint.x, cgPoint.y)
//        scrollview.frame = offsetFrame
        
       // scrollview.setContentOffset(cgPoint, animated: true)
    }
    
}
