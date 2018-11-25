//
//  HistoryViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/25/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class HistoryViewController: AppViewController {

    @IBOutlet var historyTableView: UITableView!
    var historyController: HistoryController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        historyController = ControllerFactory.createController(type: HistoryController.self, for: self) as? HistoryController
        initTableView()
    }

    
    func initTableView() {
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.historyTableView.showsHorizontalScrollIndicator = false
        self.historyTableView.showsVerticalScrollIndicator = false
        self.historyTableView.separatorStyle = .none
        registerCell()
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

