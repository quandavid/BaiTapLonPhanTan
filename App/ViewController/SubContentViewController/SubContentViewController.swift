//
//  SubContentViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit
import SocketIO

class SubContentViewController: AppViewController {
    @IBOutlet var titleLabel: UILabel!
    //MARK: Value - preview
    @IBOutlet var preview: UIView!
    @IBOutlet var previewTextView: UITextView!
    @IBOutlet var subContentTableView: UITableView!
    //MARK: Value - invite
    @IBOutlet var emailText: UITextField!
    
    @IBOutlet var switchEditer: UISwitch!
    @IBOutlet var switchViewer: UISwitch!
    @IBOutlet var invitedView: UIView!
    
    var subContentController: SubContentController!
    var meetingId: Int = 0
    let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        subContentController = ControllerFactory.createController(type: SubContentController.self, for: self) as? SubContentController
        initComponent()
        configureSocketIO()
        // Do any additional setup after loading the view.
    }
    
    func configureSocketIO() {
        
        SocketIOManager.sharedInstance.socketIOClient = manager.defaultSocket
        
        SocketIOManager.sharedInstance.socketIOClient.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        SocketIOManager.sharedInstance.socketIOClient.emit("edit_subcontent", ["user_id": 3, "meeting_id": 1, "subcontent": ["id": 27, "author": "Quan Nguyen", "content": "abcdefgh"]])
        
        SocketIOManager.sharedInstance.socketIOClient.on("edit_subcontent") {data, ack in
            //            guard let cur = data[0] as? Double else { return }
        }
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.subContentController.getMeeting(meetingId: meetingId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let meeting = self.initData["meetingInfo"] as? MeetingModel {
            self.titleLabel.text = meeting.title
            self.meetingId = meeting.meetingId
        }
        SocketIOManager.sharedInstance.socketIOClient.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SocketIOManager.sharedInstance.socketIOClient.disconnect()
    }
    
    func initComponent() {
        initTableView()
        registerCell()
        initTextView()
        initInvited()
    }
    
    func registerCell() {
        SubContentCell.registerCellByNib(subContentTableView)
    }
    
    func initTableView() {
        self.subContentTableView.delegate = self
        self.subContentTableView.dataSource = self
        self.subContentTableView.showsVerticalScrollIndicator = false
        
    }
    
    func initTextView() {
        self.previewTextView.delegate = self
        self.preview.isHidden = true
    }
    
    func initInvited() {
        self.invitedView.isHidden = true
        self.emailText.delegate = self
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .SubContent_gotData:
                self.subContentTableView.reloadData()
                self.preview.isHidden = true
            break
        case .SubContent_invited:
            self.invitedView.isHidden = true
            UtilManage.alert(message: "Invited User", type: .ok, complete: nil)
        default:
            super.update(command, data: data)
        }
    }
    
    func getAuthorAndContentIsConfligFrom(startTime: String, endTime: String) -> ([String],[String]) {
        return (self.subContentController.fullContents.filter { $0.startTime == startTime && $0.endTime == endTime }.filter {$0.author != ""}.map { $0.author }, self.subContentController.fullContents.filter { $0.startTime == startTime && $0.endTime == endTime }.filter {$0.content != ""}.map { $0.content })
    }
    
    @IBAction func importAction(_ sender: Any) {
        let importVC = ImportViewController()
        importVC.meetingId = self.meetingId
        self.navigationController?.pushViewController(importVC, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.preview.isHidden = true
    }
    
    @IBAction func handleInviteAction(_ sender: Any) {
        self.invitedView.isHidden = false
    }
    
    @IBAction func handleBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleOkInvite(_ sender: Any) {
        if !switchViewer.isOn && !switchEditer.isOn || emailText.text == "" {
            return
        }
        
        if switchEditer.isOn {
            subContentController.inviteUser(email: emailText.text!, role: 1, meetingId: self.meetingId)
        } else {
            subContentController.inviteUser(email: emailText.text!, role: 0, meetingId: self.meetingId)
        }
        
    }
    @IBAction func handleCancelInvite(_ sender: Any) {
        self.invitedView.isHidden = true
    }
    
    
}

extension SubContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subContentController.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SubContentCell.loadCell(tableView) as! SubContentCell
        cell.subContent = self.subContentController.contents[indexPath.row]
        cell.updatedText = { [weak self] text in
            guard let this = self else { return }
            (this.subContentController.contents[indexPath.row]).content = text
            this.subContentController.updateText(meetingId: this.meetingId, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.subContentController.contents[indexPath.row].flag == 1 {
            return 85
        }
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subContent = self.subContentController.contents[indexPath.row]
        guard subContent.flag == 1 else {
            return
        }
        
        let (authors, contents) = self.getAuthorAndContentIsConfligFrom(startTime: subContent.startTime, endTime: subContent.endTime)
        
        let resolveViewController = ResolveConfligViewController()
        resolveViewController.authors = authors
        resolveViewController.contents = contents
        self.navigationController?.pushViewController(resolveViewController, animated: true)
    }
    
    
}

extension SubContentViewController: UITextViewDelegate {
    
}

extension SubContentViewController: UITextFieldDelegate {
    
}
