//
//  StreamingDataCoordinator.swift
//  SwiftStreaming
//
//  Created by Renu Punjabi on 12/27/17.
//  Copyright © 2017 Renu Punjabi. All rights reserved.
//

import UIKit

class StreamingDataCoordinator: NSObject {
    var navigationVC: UINavigationController!
    var streamingTableVC: StreamingTableViewController?
    let networkManager = NetworkManager.shared
//    var userArray = [User]()
    var userArray = SynchronizedArray<User>()

   // fileprivate let concurrentPhotoQueue =
//        DispatchQueue(
//            label: "com.cocoateam.SwiftStreaming.dataQueue",
//            attributes: .concurrent)
    
    
    init(navigationVC: UINavigationController){
        self.navigationVC = navigationVC
    }
    
    func start() {
        if let tableVC = navigationVC.viewControllers.first as? StreamingTableViewController {
            streamingTableVC = tableVC
            streamingTableVC?.delegate = self
            networkManager.delegate = self
            getStreamingData()
        }
    }
    func getStreamingData(){
        if networkManager.isStreaming {
            networkManager.stopStreaming()
        } else {
            networkManager.startStreaming()
        }
    }
}

extension StreamingDataCoordinator: NetworkManagerDelegate {
    
    func didReceiveData(responseData: Data) {
        
        // start a new thread here that takes care of everything
//        concurrentPhotoQueue.async(flags: .barrier) {

        guard var newText = String(data: responseData, encoding: .utf8) else {
            return
        }

        newText = "[" + newText + "]"
        newText = newText.replacingOccurrences(of: "\n", with: ",")
        newText = newText.replacingOccurrences(of: ",]", with: "]")
           
        let newData = newText.data(using: String.Encoding.utf8)
        guard newData != nil else { return }

        self.processReceivedData(responseData: newData!)
        //}
    }
    
    func processReceivedData(responseData: Data) {

        if let array = convertToArray(data: responseData) {
            for item in array {
                if item is NSDictionary {
                    let user = User(userDictionary: item as! NSDictionary)
                    
                    // TODO: ENSURE THIS ARRAY IS SYNCHRONIZED
                    userArray.append(user)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.streamingTableVC?.dataSource = self.userArray
        }
    }
    
    func convertToArray(data: Data) -> [Any]? {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }

}

extension StreamingDataCoordinator: StreamingTableViewControllerDelegate {
    func receivedNewData() {
       
        }
}
