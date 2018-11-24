//
//  ResolveConfligViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/24/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class ResolveConfligViewController: AppViewController {

    @IBOutlet var tableview: UITableView!
    
    var authorSection: Int = 0
    var contentSection: Int = 1
    var maxSection: Int = 2
    var authors: [String] = []
    var contents: [String] = []
    var currentAuthor: Int = -1
    var currentContent: Int = -1
    var subContentInfos: [SubContentModel]!
    var subContentInfo: SubContentModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        initTableView()
        registerCell()
    }

    func registerCell() {
        ResolveTableViewCell.registerCellByNib(tableview)
    }

    func initTableView() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    

    @IBAction func confirmAction(_ sender: Any) {
        guard currentContent != -1 && currentAuthor != -1 else { return }
        let subcontent1 = getSubContentByAuthor(author: authors[currentAuthor])
        let subcontent2 = getSubContentByContent(content: contents[currentContent])
        SocketIOManager.sharedInstance.socketIOClient.emit("edit_subcontent", ["user_id": subcontent1.userId, "meeting_id": subcontent1.meetingId, "subcontent": ["id": 0, "author": subcontent1.author, "content": subcontent2.content, "start_time": subcontent2.startTime, "end_time": subcontent2.endTime]])
            SocketIOManager.sharedInstance.socketIOClient.emit("delete_subcontent", ["user_id": subcontent1.userId, "meeting_id": subcontent1.meetingId, "subcontent": ["id": subcontent1.subId, "author": subcontent1.author, "content": subcontent1.content, "start_time": subcontent1.startTime, "end_time": subcontent1.endTime]])
            SocketIOManager.sharedInstance.socketIOClient.emit("delete_subcontent", ["user_id": subcontent2.userId, "meeting_id": subcontent2.meetingId, "subcontent": ["id": subcontent2.subId, "author": subcontent2.author, "content": subcontent2.content, "start_time": subcontent2.startTime, "end_time": subcontent2.endTime]])
        self.navigationController?.popViewController(animated: true)
    }
    
    func getSubContentByAuthor(author: String) -> SubContentModel {
        return subContentInfos.filter{ $0.author == author }.first!
    }
    
    func getSubContentByContent(content: String) -> SubContentModel {
        return subContentInfos.filter{ $0.content == content }.first!
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ResolveConfligViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return maxSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case authorSection:
            return authors.count
        case contentSection:
            return contents.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ResolveTableViewCell.loadCell(tableView) as! ResolveTableViewCell
        cell.tapCheckBoxBlock = { [unowned self] in
            switch indexPath.section {
            case self.authorSection:
                self.currentAuthor = indexPath.row
                print(self.currentAuthor)
            case self.contentSection:
                self.currentContent = indexPath.row
                print(self.currentContent)
            default:
                break
            }
            self.tableview.reloadData()
        }
        switch indexPath.section {
        case authorSection:
            cell.textLb.text = authors[indexPath.row]
            cell.checkbox.image = (indexPath.row == currentAuthor) ? UIImage(named: "ic_checked_box") : UIImage(named: "ic_un_check_box")
        case contentSection:
            cell.textLb.text = contents[indexPath.row]
            cell.checkbox.image = (indexPath.row == currentContent) ? UIImage(named: "ic_checked_box") : UIImage(named: "ic_un_check_box")
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case authorSection:
            return "Authors"
        case contentSection:
            return "Contents"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

