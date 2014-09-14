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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var movie = defaults.objectForKey("selectedMovie") as NSDictionary
        
        
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["thumbnail"] as String
        moviePoster.setImageWithURL(NSURL(string: posterURL))
        
        nvbar.title = movie["title"] as? String

        MovieTitle.text = movie["title"] as? String
        
        MovieDetail.text = movie["synopsis"] as? String
        
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
