//
//  DetailViewController.swift
//  rotton
//
//  Created by Kun Rong on 9/13/14.
//  Copyright (c) 2014 Kun Rong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var nvbar: UINavigationItem!
    
    @IBOutlet weak var MscrollView: UIScrollView!
    
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieDetail: UILabel!
    
    @IBOutlet weak var Year: UILabel!
    
    
    @IBOutlet weak var MPAA: UILabel!
    
    @IBOutlet weak var C_rating: UILabel!
    
    @IBOutlet weak var A_rating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var movie = defaults.objectForKey("selectedMovie") as NSDictionary
        
        
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["thumbnail"] as String
        var year = movie["year"] as Int
        var mpaa = movie["mpaa_rating"] as? String
        // get movie rating
        var ratings = movie["ratings"] as NSDictionary
        
        
        Year.text = "\(year)"
        MPAA.text = mpaa
        
        println("year:\(year), mpaa:\(mpaa)")
        
        var c_rating = ratings["critics_score"] as Float
        var a_rating = ratings["audience_score"] as Float
        
        C_rating.text = "\(c_rating)%"
        A_rating.text = "\(a_rating)%"
        
        println("c rating:\(c_rating), a_raitng:\(a_rating)")
        
        moviePoster.setImageWithURL(NSURL(string: posterURL))
        nvbar.title = movie["title"] as? String
        MovieTitle.text = movie["title"] as? String
        MovieDetail.text =  movie["synopsis"] as? String
        
        // Do any additional setup after loading the view.
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
