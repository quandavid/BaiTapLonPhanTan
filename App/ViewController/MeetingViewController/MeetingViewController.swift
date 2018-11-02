//
//  MeetingViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/1/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class MeetingViewController: AppViewController {

    @IBOutlet var meetingTableView: UITableView!
    var meetingController: MeetingController!
    override func viewDidLoad() {
        super.viewDidLoad()

        initComponent()
        meetingController.getAllMeetings()
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        meetingController = ControllerFactory.createController(type: MeetingController.self, for: self) as? MeetingController
        initTableView()
    }
    
    func initTableView() {
        self.meetingTableView.delegate = self
        self.meetingTableView.dataSource = self
        registerCell()
    }
    
    func registerCell() {
        MeetingCell.registerCellByNib(self.meetingTableView)
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .Meeting_getAllSucess:
            self.meetingTableView.reloadData()
            break
        default:
            super.update(command, data: data)
        }
    }
}

extension MeetingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetingController.meetingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MeetingCell.loadCell(tableView) as! MeetingCell
            cell.textLabel?.text = self.meetingController.meetingList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meetingInfo = self.meetingController.meetingList[indexPath.row]
        self.pushViewController(SubContentViewController.self, data: ["meetingInfo" : meetingInfo])
    }
    
}
