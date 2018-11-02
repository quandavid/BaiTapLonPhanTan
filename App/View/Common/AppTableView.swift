//
//  AppTableView.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/10/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import Foundation
import UIKit

class AppTableView: UITableView {
    override func viewDidAppear(_ data: Any?) {
        super.viewDidAppear()
        self.dataSource = self
        self.delegate = self
        self.estimatedRowHeight = 80
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
    }
}

extension AppTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Please implement method: numberOfRowsInSection")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Please implement method: cellForRowAt")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
