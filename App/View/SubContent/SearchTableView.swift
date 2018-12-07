//
//  SearchTableView.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 12/7/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class SearchTableView: UITableView {

    var inputContents: [String] = []
    override func viewWillDisappear() {
        super.viewWillDisappear()
        initComponent()
    }
    
    func initComponent() {
        registerCell()
        initSetup()
    }
    
    func initSetup() {
        self.delegate = self
        self.dataSource = self
    }
    
    func registerCell() {
        SearchTableViewCell.registerCellByNib(self)
    }
    
}

extension SearchTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = SearchTableViewCell.loadCell(self) as! SearchTableViewCell
        
        return searchCell
    }
    
}
