//
//  SubContentViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subContentController = ControllerFactory.createController(type: SubContentController.self, for: self) as? SubContentController
        initComponent()
        // Do any additional setup after loading the view.
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
    @IBAction func test1Action(_ sender: Any) {
        subContentController.readTextFromFile(textName: "SubContents") { (status, string) in
            if status {
                self.previewTextView.text = string
                DispatchQueue.main.async {
                    self.preview.isHidden = false
                }
            }
        }
    }
    
    @IBAction func pushAction(_ sender: Any) {
        self.subContentController.parseTextToObjects(textName: "SubContents") { (status, subcontents) in
            if status {
                self.subContentController.pushTextToSystem(contents: subcontents ?? [], meetingId: self.meetingId)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.preview.isHidden = true
    }
    
    @IBAction func handleInviteAction(_ sender: Any) {
        self.invitedView.isHidden = false
    }
    
    @IBAction func handleBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        return 100
    }
    
    
}

extension SubContentViewController: UITextViewDelegate {
    
}

extension SubContentViewController: UITextFieldDelegate {
    
}
