//
//  MoviesViewController.swift
//  rotton
//
//  Created by Kun Rong on 9/13/14.
//  Copyright (c) 2014 Kun Rong. All rights reserved.
//

import UIKit


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var movies: [NSDictionary] = []
    
    var refreshControl:UIRefreshControl!  // An optional variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=n97b6ed9bugj8xbermcqpdns&limit=20&country=us"
        
        var request = NSURLRequest(URL: NSURL(string: url))
        
        [MBProgressHUD .showHUDAddedTo(self.view, animated: true )]
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), {
        
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
                if data == nil {
                    return
                }
            
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
                self.movies = object["movies"] as [NSDictionary]
            
            
                self.tableView.reloadData()
            
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                println("yes")
                [MBProgressHUD .hideHUDForView(self.view, animated: true)]
            })
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("row is : \(indexPath.row), session is \(indexPath.section)")
        
        var movie = movies[indexPath.row]
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as  MovieCell
        cell.MovieTitleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["thumbnail"] as String
        cell.posterView.setImageWithURL(NSURL(string: posterURL))
        
        println("Hello, I am  at Row \(indexPath.row),session \(indexPath.section)")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("click selected is: \(indexPath.row)")
        defaults.setObject(movies[indexPath.row], forKey: "selectedMovie")
        defaults.synchronize()
    }
    
    func refresh(sender:AnyObject)
    {
        // Code to refresh table view
        println("table are refreshed!!")
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
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
