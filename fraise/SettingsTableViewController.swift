//
//  SettingsTableViewController.swift
//  fraise
//
//  Created by Matt Wang on 2019-07-24.
//  Copyright © 2019 Matthew Wang. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var randomizeTimer: Bool = true
    var showTimer: Bool = false
    
    var includeSongs: Bool = true
    var includeMovies: Bool = true

    @IBOutlet weak var RandomizeTimerValue: UISwitch!
    @IBOutlet weak var ShowTimerValue: UISwitch!
    @IBOutlet weak var IncludeSongsValue: UISwitch!
    @IBOutlet weak var IncludeMoviesValue: UISwitch!
    
    @IBAction func RandomizeTimerToggle(_ sender: UISwitch) {
        randomizeTimer.toggle()
    }
    @IBAction func ShowTimerToggle(_ sender: UISwitch) {
        showTimer.toggle()
    }
    @IBAction func IncludeSongsToggle(_ sender: UISwitch) {
        includeSongs.toggle()
    }
    @IBAction func IncludeMoviesToggle(_ sender: UISwitch) {
        includeMovies.toggle()
    }
    
    func setRandomizeTimer(_ mode: Bool?){
        if let modeInput:Bool = mode {
            randomizeTimer = modeInput;
        }
    }
    func setShowTimer(_ mode: Bool?){
        if let modeInput:Bool = mode {
            showTimer = modeInput;
        }
    }
    func setIncludeSongs(_ mode: Bool?){
        if let modeInput:Bool = mode {
            includeSongs = modeInput;
        }
    }
    func setIncludeMovies(_ mode: Bool?){
        if let modeInput:Bool = mode {
            includeMovies = modeInput;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RandomizeTimerValue.setOn(randomizeTimer, animated: true)
        ShowTimerValue.setOn(showTimer, animated: true)
        IncludeSongsValue.setOn(includeSongs, animated: true)
        IncludeMoviesValue.setOn(includeMovies, animated: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
