//
//  ViewController.swift
//  Pull-iOS
//
//  Created by AugustRush on 1/6/17.
//  Copyright © 2017 August. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let channelCellIdentifier = "channel_identifier"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var channelList = Array<Channel>()
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        
        let params = ["name":"August Rush"]
        Alamofire.request("http:/172.18.13.136:8888/getchannel/", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if let data = response.result.value {
                let list = data as! [String]
                for name in list {
                    let channel = Channel()
                    channel.name = name
                    self.channelList.append(channel)
                }
                //
                self.tableView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private methods
    
    func setUp() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: channelCellIdentifier)
    }
    
    //MARK: UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: channelCellIdentifier, for: indexPath)
        if indexPath.row < self.channelList.count {
            cell.textLabel?.text = channelList[indexPath.row].name
        }
        return cell
    }
    
    //MARK: UITabbleViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select indexPath is \(indexPath)")
    }
}

