//
//  HistoryViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/25/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit
import SocketIO

class HistoryViewController: AppViewController {

    @IBOutlet var historyTableView: UITableView!
    var historyController: HistoryController!
    var meetingId: Int = 0
    let manager = SocketManager(socketURL: URL(string: FDefined.SocketUrl)!, config: [.log(true)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meetingId = initData["meetingId"] as? Int {
            self.meetingId = meetingId
        }
        initComponent()
        self.configureSocketIO()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SocketIOManager.sharedInstance.socketIOClient.connect()
        
    }
    
    
    
    func configureSocketIO() {
        
        SocketIOManager.sharedInstance.socketIOClient = manager.defaultSocket
        
        SocketIOManager.sharedInstance.socketIOClient.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        SocketIOManager.sharedInstance.socketIOClient.on("edit_subcontent") {data, ack in
            self.historyController.getHistory()
        }
        
        SocketIOManager.sharedInstance.socketIOClient.on("delete_subcontent") {data, ack in
            self.historyController.getHistory()
        }
        
        SocketIOManager.sharedInstance.socketIOClient.on("add_subcontent") { (data, ack) in
            self.historyController.getHistory()
        }
    }
    
    func initComponent() {
        historyController = ControllerFactory.createController(type: HistoryController.self, for: self) as? HistoryController
        historyController.meetingId = self.meetingId
        initTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        historyController.getHistory()
    }

    
    func initTableView() {
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.historyTableView.showsHorizontalScrollIndicator = false
        self.historyTableView.showsVerticalScrollIndicator = false
//        self.historyTableView.separatorStyle = .none
        registerCell()
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .History_GetSuccess:
            self.historyTableView.reloadData()
            break
        case .History_GetFailure:
            UtilManage.alert(message: "get data falure", type: .ok, complete: nil)
            break
        default:
            super.update(command, data: data)
        }
    }
    
    func registerCell() {
        HistoryCell.registerCellByNib(self.historyTableView)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyController.histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HistoryCell.loadCell(tableView) as! HistoryCell
        let historyInfo = self.historyController.histories[indexPath.row]
        let string = "\(historyInfo.changeBy) has excute \(historyInfo.action) to change \(historyInfo.column) from \(historyInfo.oldValue) to \(historyInfo.nwValue) at \(historyInfo.createdAt)"
        let range = (string as NSString).range(of: historyInfo.changeBy)
        let attributedString = NSMutableAttributedString(string:string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        cell.textLb.attributedText = attributedString
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

