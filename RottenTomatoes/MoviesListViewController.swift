//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Amit Bharadwaj on 9/10/14.
//  Copyright (c) 2014 Amit Bharadwaj. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var movieTableView: UITableView!
    var moviesArray: NSArray?
    
    var refreshControl:UIRefreshControl! // For pull to refresh
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh(self);
        
        // Pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.movieTableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject)
    {
        let YourApiKey = "9aqv88tz6dsqazb5qbsgszzj"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        
        // Show waiting for download
        SVProgressHUD.show()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            if (error != nil) {
                println("Network error \(error)")
                var banner = ALAlertBanner(forView: self.view, style: ALAlertBannerStyleFailure, position: ALAlertBannerPositionTop, title: "Network error")
                banner.show()
                SVProgressHUD.dismiss()
                self.refreshControl.endRefreshing()
                return
            }
            var errorValue: NSError? = nil
            let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue)
            
            if parsedResult != nil {
                let dictionary = parsedResult! as NSDictionary
                self.moviesArray = dictionary["movies"] as? NSArray
                SVProgressHUD.dismiss()
                self.movieTableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                println("parsed result is null");
            }
            
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (moviesArray != nil ) {
            return moviesArray!.count
        }
        
        return 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCellWithIdentifier("com.amit.rt.moviecell") as MovieTableViewCell
        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
        cell.titleLabel.text = movieDictionary["title"] as NSString
        
        let imagesDictionary = movieDictionary["posters"] as NSDictionary
        let url = NSURL(string: imagesDictionary["thumbnail"] as NSString)
        
        cell.posterImageView.setImageWithURL(url)
        
        // Create attributed string
        let mpaaRatingString = movieDictionary["mpaa_rating"] as String
        let synopsisString = movieDictionary["synopsis"] as String

        // Define attributes
        let mpaaRatingAttributes :Dictionary = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
        
        var mpaaRatingAttrString = NSMutableAttributedString(string: mpaaRatingString, attributes:mpaaRatingAttributes)
        
        
        var synopsisAttrString = NSMutableAttributedString(string: " \(synopsisString)")

        
        mpaaRatingAttrString.appendAttributedString(synopsisAttrString)

        cell.sysnopsisLabel.attributedText = mpaaRatingAttrString

        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detailsSegue") {
            let movieDictionary = self.moviesArray![self.movieTableView.indexPathForSelectedRow()!.row] as?  NSDictionary
            
            var mdVC = segue.destinationViewController as MovieDetailsViewController;
            mdVC.movieDictionary = movieDictionary
        }
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
