//
//  ImportViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/21/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class ImportViewController: AppViewController {

    var fileList = ["file 1","file 2","file 3","file 4","file 5","file 6","file 7"]
    var subContentController: SubContentController!
    @IBOutlet var importTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         subContentController = ControllerFactory.createController(type: SubContentController.self, for: self) as? SubContentController
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        initTableView()
        registerCell()
    }
    
    func registerCell() {
        ImportCell.registerCellByNib(importTableView)
    }
    
    func initTableView() {
        self.importTableView.delegate = self
        self.importTableView.dataSource = self
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension ImportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ImportCell.loadCell(tableView) as! ImportCell
        cell.textLabel?.text = fileList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.subContentController.parseTextToObjects(textName: "SubContents") { (status, subcontents) in
            if status {
                DispatchQueue.main.async {
                    if let contents = subcontents {
                        let previewVC = PreviewViewController.init(nibName: "PreviewViewController", bundle: nil)
                        previewVC.subContentList = contents
                        self.navigationController?.pushViewController(previewVC, animated: true)
                    }
                    
                }
                
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
