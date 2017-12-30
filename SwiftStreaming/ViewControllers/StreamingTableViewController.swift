//
//  StreamingTableViewController.swift
//  SwiftStreaming
//
//  Created by Renu Punjabi on 12/27/17.
//  Copyright © 2017 Renu Punjabi. All rights reserved.
//

import UIKit

protocol StreamingTableViewControllerDelegate: class {
    func receivedNewData()
}

class StreamingTableViewController: UITableViewController {
    weak var delegate: StreamingTableViewControllerDelegate?
    
    var dataSource: [User]? {
        didSet {
           tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataSource else {
            return 0
        }
        return data.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell")
        if let data = dataSource {
            let userInfo = data[indexPath.row] as User
            cell?.textLabel?.text = userInfo.userName!
            //userInfo.userName! + " and " + userInfo.friendName! + " are " + userInfo.isFriend! + " " + userInfo.timeStamp!
        }
        
        return cell!
    }
    
}

