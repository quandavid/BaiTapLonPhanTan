//
//  LoginViewController2.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 7/20/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import UIKit

class LoginViewController: AppViewController {
    //MARK: Outlet
    @IBOutlet var loginTableView: UITableView!
    
    //MARK: Value
    var imageLoginSection = 0
    var dataSection = 1
    var emailRegister: String?
    var passwordRegister: String?
    var isShowedKeyboard: Bool = false
    var isRegisted: Bool = false
    var isAllowPopToRoot: Bool = false
    var loginController: LoginController!
    //MARK: Block
    var didDismisloginBlock: (() -> ())?
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginTableView.reloadData()
    }
    
    //MARK: Init
    func initData() {
        initComponent()
        initTableView()
    }
    
    func initComponent() {
        loginController = ControllerFactory.createController(type: LoginController.self, for: self) as? LoginController
    }
    

    
    func initTableView() {
        self.loginTableView.showsVerticalScrollIndicator = false
        self.loginTableView.showsHorizontalScrollIndicator = false
        self.loginTableView.separatorStyle = .none
        self.loginTableView.dataSource = self
        self.loginTableView.delegate = self
        registerCell()
    }
    
    func registerCell() {
        LoginCell.registerCellByNib(self.loginTableView)
        TopLoginCell.registerCellByNib(self.loginTableView)
    }
    
    //MARK: Other Func
    func showedKeyboard() {
        isShowedKeyboard = true
        updateHeight()
    }
    
    func hiddenKeyboard() {
        isShowedKeyboard = false
        updateHeight()
    }
    
    func updateHeight() {
        loginTableView.beginUpdates()
        let index = IndexPath(row: 0, section: 0)
        loginTableView.reloadRows(at: [index], with: .automatic)
        loginTableView.endUpdates()
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .Login_loginSuccess:
            if let userInfo = data as? UserModel {
                standardUserDefaults.set(userInfo, forKey: kUserInfo)
                self.showViewController(MeetingViewController.self)
            }
            break
        case .Login_loginFail:
            
            break
        default:
            super.update(command, data: data)
        }
    }

}

//TableView
extension LoginViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case imageLoginSection:
            return 1
        case dataSection:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case imageLoginSection:
            let cell = TopLoginCell.loadCell(tableView) as! TopLoginCell
            return cell
        case dataSection:
            let cell = LoginCell.loadCell(tableView) as! LoginCell
            
            cell.isShowedKeyboard = { [unowned self] in
                self.showedKeyboard()
            }
            
            cell.isHiddenKeyboard = { [unowned self] in
                self.hiddenKeyboard()
            }
            
            
            cell.loginBlock = { [unowned self] email, password in
                self.loginController.getUserData(email: email, password: password)
            }
            
            if let email = self.emailRegister, let password = self.passwordRegister , isRegisted {
                cell.emailTextField.text = email
                cell.passwordTextField.text = password
                cell.passwordTextField.isSecureTextEntry = true
                self.isRegisted = false
                cell.checkLoginButtonEnable()
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

extension LoginViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case imageLoginSection:
            return isShowedKeyboard ? 0 : 78 + SCREEN_WIDTH - 77*2
        case dataSection:
            return 516
        default:
            return 0
        }
    }
}



