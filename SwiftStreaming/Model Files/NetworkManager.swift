//
//  NetworkManager.swift
//  SwiftStreaming
//
//  Created by Renu Punjabi on 12/27/17.
//  Copyright © 2017 Renu Punjabi. All rights reserved.
//

import Foundation
//typealias completionHandler = ((_ response: Any?) -> Void)

protocol NetworkManagerDelegate: class {
    func didReceiveData(responseData: Data)
}

class NetworkManager : NSObject, URLSessionDataDelegate {

    static let shared = NetworkManager()
    private var session: URLSession! = nil
    private var streamingTask: URLSessionDataTask? = nil
    var isStreaming: Bool { return self.streamingTask != nil }
    var outputStream: OutputStream? = nil
//    public var didReceiveResponse: ((URLSession, URLSessionDataTask, URLResponse) -> URLSession.ResponseDisposition)?
    var value: NetworkManagerDelegate?
    weak var delegate: NetworkManagerDelegate? {
        set {
          value = newValue
        }
        get {
            return value
        }
    }

    override init() {
        super.init()
        let config = URLSessionConfiguration.default
        
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: .main)
    }
    
    func startStreaming() {
            precondition( !self.isStreaming )
            let url = URL(string: "https://hp-server-toy.herokuapp.com/?since=20171230")!
            let request = URLRequest(url: url)//SAME
            
            let task = self.session.dataTask(with: request)
            //uploadTask(withStreamedRequest: request)
            
            self.streamingTask = task
            task.resume() //SAME
    }
    
    
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
//        var disposition: URLSession.ResponseDisposition = .allow
//        if let didReceiveResponse = didReceiveResponse {
//            disposition = didReceiveResponse(session, dataTask, response)
//        }
//        completionHandler(disposition)
//    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("##################################")
        print("data = \(data)")
        print("##################################")
        
        // TODO: ENSURE THAT THIS DELEGATE LINE IS SYNCHRONIZED
        delegate?.didReceiveData(responseData: data)
        
        
        // NEW - try printing just data also if you like
//        if let responseText = String(data: data, encoding: .utf8) {
//            print(responseText)
//        }
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
