//
//  NetworkManager.swift
//  SwiftStreaming
//
//  Created by Renu Punjabi on 12/27/17.
//  Copyright © 2017 Renu Punjabi. All rights reserved.
//

import Foundation

class NetworkManager : NSObject, URLSessionDataDelegate {

    static var shared = NetworkManager()
    private var session: URLSession! = nil
    private var streamingTask: URLSessionDataTask? = nil
    var isStreaming: Bool { return self.streamingTask != nil }
    var outputStream: OutputStream? = nil
    
    override init() {
        super.init()
        let config = URLSessionConfiguration.default
        
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: .main)
    }
    
    func startStreaming() {
        precondition( !self.isStreaming )
        let url = URL(string: "https://hp-server-toy.herokuapp.com/?since=20171227")!
        let request = URLRequest(url: url)//SAME
        
        let task = self.session.dataTask(with: request)
        //uploadTask(withStreamedRequest: request)
        
        self.streamingTask = task
        task.resume() //SAME
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("Now description")
        
        // NEW - try printing just data also if you like
        if let responseText = String(data: data, encoding: .utf8) {
            print(responseText)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error as NSError? {
            print("task error: \(error.domain), \(error.code)")
        } else {
            print("task complete")
        }
    }
    
    func stopStreaming() {
        guard let task = self.streamingTask else {
            return
        }
        self.streamingTask = nil
        task.cancel()
        self.closeStream()
    }
    
    
    private func closeStream() {
        if let stream = self.outputStream {
            stream.close()
            self.outputStream = nil
        }
    }

}
