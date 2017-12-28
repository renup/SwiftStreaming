//
//  StreamingTableViewController.swift
//  SwiftStreaming
//
//  Created by Renu Punjabi on 12/27/17.
//  Copyright © 2017 Renu Punjabi. All rights reserved.
//

import UIKit

class StreamingTableViewController: UITableViewController {

    var dataSource: NSDictionary? {
        didSet {
           tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStreamingData()
    }
    
    func getStreamingData(){
        if NetworkManager.shared.isStreaming {
            NetworkManager.shared.stopStreaming()
        } else {
            NetworkManager.shared.startStreaming()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}

