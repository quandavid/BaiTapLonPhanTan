//
//  MeetingViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/1/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class MeetingViewController: AppViewController {

    @IBOutlet var createView: UIView!
    @IBOutlet var meetingTableView: UITableView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var createMeetinView: UIView!
    @IBOutlet var cancelButton: UIButton!
    var meetingController: MeetingController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        meetingController = ControllerFactory.createController(type: MeetingController.self, for: self) as? MeetingController
        self.navigationController?.isNavigationBarHidden = true
        self.createMeetinView.layer.masksToBounds = true
        self.createMeetinView.layer.cornerRadius = 5
        self.createButton.layer.masksToBounds = true
        self.createButton.layer.cornerRadius = 4
        self.cancelButton.layer.masksToBounds = true
        self.cancelButton.layer.cornerRadius = 4
        initTableView()
        initCreateView()
    }
    
    func initCreateView() {
        createView.isHidden = true
        createView.isUserInteractionEnabled = true
        createView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCreateView)))
        titleTextField.delegate = self
        
    }
    
    @objc func tapCreateView() {
        createView.isHidden = true
    }
    
    
    @IBAction func handleCancelPopup(_ sender: Any) {
        createView.isHidden = true
    }
    
    func initTableView() {
        self.meetingTableView.delegate = self
        self.meetingTableView.dataSource = self
        self.meetingTableView.showsHorizontalScrollIndicator = false
        self.meetingTableView.showsVerticalScrollIndicator = false
        self.meetingTableView.separatorStyle = .none
        registerCell()
    }
    
    func registerCell() {
        MeetingCell.registerCellByNib(self.meetingTableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         meetingController.getAllMeetings()
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .Meeting_getAllSucess:
            self.meetingTableView.reloadData()
            break
        case .Meeting_createdNewMeeting:
            self.meetingTableView.reloadData()
            self.createView.isHidden = true
            self.titleTextField.text = ""
            break
        default:
            super.update(command, data: data)
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        createView.isHidden = false
    }
   
    @IBAction func handleCreateAction(_ sender: Any) {
        if self.titleTextField.text == "" {
            return
        }
        self.meetingController.createNewMeeting(titleName: self.titleTextField.text!)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MeetingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetingController.meetingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MeetingCell.loadCell(tableView) as! MeetingCell
        if self.meetingController.meetingList.count > 0 {
            cell.meetingModel = self.meetingController.meetingList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meetingInfo = self.meetingController.meetingList[indexPath.row]
        self.showViewController(SubContentViewController.self, data: ["meetingInfo" : meetingInfo])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension MeetingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
