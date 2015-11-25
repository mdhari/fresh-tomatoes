//
//  ViewController.swift
//  Fresh Tomatoes Swift
//
//  Created by Michael Hari on 11/25/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var movieArray = ["Transformers","Superman","Batman"]
    
    @IBOutlet var movieTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.movieTblView.dataSource=self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:MovieItemTableViewCell! = tableView.dequeueReusableCellWithIdentifier("MovieItem") as! MovieItemTableViewCell
        
        if(cell == nil){
            cell = MovieItemTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MovieItem")
        }
        
        cell.movieTitle.text = movieArray[indexPath.row]
        
        return cell
    }
}

