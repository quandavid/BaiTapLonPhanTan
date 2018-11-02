//
//  SubContentViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class SubContentViewController: AppViewController {
    @IBOutlet var navigationTitle: UILabel!
    @IBOutlet var subContentTableView: UITableView!
    var subContentController: SubContentController!
    var subContents: [SubContent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subContentController = ControllerFactory.createController(type: SubContentController.self, for: self) as? SubContentController
        initComponent()
        if let meeting = self.initData["meetingInfo"] as? MeetingModel {
            self.navigationTitle.text = meeting.title
            subContentController.getMeeting(meetingId: meeting.meetingId)
        }
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        initTableView()
        registerCell()
    }
    
    func registerCell() {
        SubContentCell.registerCellByNib(subContentTableView)
    }
    
    func initTableView() {
        self.subContentTableView.delegate = self
        self.subContentTableView.dataSource = self
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .SubContent_getDataSucess:
            if let subContents = data as? [SubContent] {
                self.subContents = subContents
                self.subContentTableView.reloadData()
            }
            break
        default:
            super.update(command, data: data)
        }
    }


}

extension SubContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SubContentCell.loadCell(tableView) as! SubContentCell
        cell.subContent = self.subContents[indexPath.row]
        return cell
    }
    
    
}
