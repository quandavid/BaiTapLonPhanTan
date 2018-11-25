//
//  RegisterViewController.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 7/26/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: AppViewController {
    //MARK: Outlet
    @IBOutlet var navigationView: NavigationView!
    @IBOutlet var registerTableView: UITableView!
    
    //MARK: Value
    var imageRegisterSection = 0
    var dataSection = 1
    var isShowedKeyboard: Bool = false
    var loginController: LoginController!
    //MARK: Block
    var didDismisRegisterBlock: ((_ email: String, _ password: String) -> ())?
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginController = ControllerFactory.createController(type: LoginController.self, for: self) as? LoginController
        initData()
    }
    
    //MARK: Init
    func initData() {
        initTableView()
        initNav()
    }
    
    func initNav() {
        self.navigationView.naviTitleLabel.text = ""
        self.navigationView.backItem.tintColor = .gray
        navigationView.backClicked = { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func initTableView() {
        self.registerTableView.showsVerticalScrollIndicator = false
        self.registerTableView.showsHorizontalScrollIndicator = false
        self.registerTableView.separatorStyle = .none
        self.registerTableView.dataSource = self
        self.registerTableView.delegate = self
        registerCell()
    }
    
    func registerCell() {
        TopRegisterCell.registerCellByNib(self.registerTableView)
        RegisterCell.registerCellByNib(self.registerTableView)
    }
    
    func showedKeyboard() {
        isShowedKeyboard = true
        updateHeight()
    }
    
    func hiddenKeyboard() {
        isShowedKeyboard = false
        updateHeight()
    }
    
    func updateHeight() {
        registerTableView.beginUpdates()
        let index = IndexPath(row: 0, section: 0)
        registerTableView.reloadRows(at: [index], with: .automatic)
        registerTableView.endUpdates()
    }
    
    func getUserData(name: String, email: String, password: String) {
        loginController.registerUser(name: name, email: email, password: password)
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .Register_registerSuccess:
            self.navigationController?.popViewController(animated: true)
            break
        case .Register_registerFail:
            UtilManage.showAlert(message: "register failure", type: .ok, complete: nil)
            break
        default:
            super.update(command, data: data)
        }
    }
}

//TableView
extension RegisterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case imageRegisterSection:
            return 1
        case dataSection:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case imageRegisterSection:
            let cell = TopRegisterCell.loadCell(tableView) as! TopRegisterCell
            return cell
        case dataSection:
            let cell = RegisterCell.loadCell(tableView) as! RegisterCell
            
            cell.isShowedKeyboard = { [unowned self] in
                self.showedKeyboard()
            }
            
            cell.isHiddenKeyboard = { [unowned self] in
                self.hiddenKeyboard()
            }
            
            cell.registerBlock = { [unowned self] name, email, password in
                self.getUserData(name: name, email: email, password: password)
            }
            
            cell.alreadyAccount = { [unowned self] in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

extension RegisterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case imageRegisterSection:
            return isShowedKeyboard ? 54 : 54 + SCREEN_WIDTH*177.0/200 - 88*2
        case dataSection:
            return 581
        default:
            return 0
        }
    }
}



