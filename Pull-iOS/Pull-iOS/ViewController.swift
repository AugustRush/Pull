//
//  ViewController.swift
//  Pull-iOS
//
//  Created by AugustRush on 1/6/17.
//  Copyright © 2017 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Just for test
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        postTest()
    }

    func postTest()  {
        let url = URL.init(string: "http:/172.18.13.142:8888/post/")
        var request = URLRequest.init(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let params = ["name":"August Rush"]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        let postTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let json = String.init(data: data!, encoding: .utf8)
            print("data is \(json), error is \(error)")
        }
        postTask.resume()
    }

}

