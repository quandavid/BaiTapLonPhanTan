//
//  PreviewViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/21/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class PreviewViewController: AppViewController {

    
    @IBOutlet var previewTableView: UITableView!
    var subContentList: [SubContentModel]!
    var meetingId: Int = 0
    var userId: Int = 0
    var subContentController: SubContentController!
    override func viewDidLoad() {
        super.viewDidLoad()
        subContentController = ControllerFactory.createController(type: SubContentController.self, for: self) as? SubContentController
        initComponent()
        userId = (StorageFactory.userStorage.getAll()?.first?.userId)!
        
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        initTableView()
        registerCell()
    }
    
    func registerCell() {
        PreviewCell.registerCellByNib(previewTableView)
    }
    
    func initTableView() {
        self.previewTableView.delegate = self
        self.previewTableView.dataSource = self
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pushAction(_ sender: Any) {
        subContentController.pushTextToSystem(contents: subContentList, meetingId: self.meetingId)
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .Preview_PushTextSuccess:
            UtilManage.showAlert(message: "update successfully!", type: .ok) { (alertVC, button) in
                SocketIOManager.sharedInstance.socketIOClient.emit("add_subcontent")
        self.navigationController?.popToRootViewController(animated: true)
            }
            break
        default:
            super.update(command, data: data)
        }
    }
    
}

extension PreviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subContentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PreviewCell.loadCell(tableView) as! PreviewCell
        cell.subContent = self.subContentList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
