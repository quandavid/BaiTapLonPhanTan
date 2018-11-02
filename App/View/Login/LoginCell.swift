//
//  Loginswift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 7/21/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import UIKit

class LoginCell: AppTableViewCell {
    
    //MARK: Outlet
    @IBOutlet var emailTitle: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTitle: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var validationLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var hidePassword: UIImageView!
    @IBOutlet var emailLine: UIView!
    @IBOutlet var passwordLine: UIView!
    @IBOutlet var heightValid: NSLayoutConstraint!
    //MARK: Value
    
    var isPwHidden: Bool = true
    var isAllowLogin: Bool = false
    
    
    //MARK: Block
    var forgotPasswordBlock: (() -> ())?
    var createAccountBlock: (() -> ())?
    var isShowedKeyboard: (() -> ())?
    var isHiddenKeyboard: (() -> ())?
    var loginBlock: ((_ email: String, _ password: String) -> ())?
    //MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        initSomething()
        // Initialization code
    }
    
    func initSomething() {
        self.selectionStyle = .none
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        hidePassword.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHide)))
        hidePassword.isUserInteractionEnabled = true
        hidePassword.image = isPwHidden ? #imageLiteral(resourceName: "View") : #imageLiteral(resourceName: "hide")

        
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        emailTitle.isHidden = true
        passwordTitle.isHidden = true
        
        heightValid.constant = 0
        
        checkLoginButtonEnable()
    }
    
    
    
    //MARK: Action
    @objc func tapHide() {
        if isPwHidden {
            isPwHidden = false
            hidePassword.image = #imageLiteral(resourceName: "hide")
            passwordTextField.isSecureTextEntry = false
        } else {
            isPwHidden = true
            hidePassword.image = #imageLiteral(resourceName: "View")
            passwordTextField.isSecureTextEntry = true
        }
        let currentText: String = self.passwordTextField.text!
        self.passwordTextField.text = "";
        self.passwordTextField.text = currentText
    }

    @objc func tapCreateAccount() {
        if let create = self.createAccountBlock {
            refresh()
            create()
        }
    }
    
    @objc func tapForgotAccount() {
        if let fgPw = self.forgotPasswordBlock {
            refresh()
            fgPw()
        }
    }
    
    func refresh() {
        heightValid.constant = 0
        passwordLine.backgroundColor = UIColor.colorFromHexString(hex: "C6CBD4")
        emailLine.backgroundColor = UIColor.colorFromHexString(hex: "C6CBD4")
        emailTitle.isHidden = true
        passwordTitle.isHidden = true
        emailTextField.text = "Email"
        passwordTextField.text = "Password"
        emailTextField.isSecureTextEntry = false
        passwordTextField.isSecureTextEntry = false
    }
    
    func checkValidateEmailAndPassword() -> Bool {
        return isValidEmail(testStr: emailTextField.text ?? "") && isValidPassword(testStr: passwordTextField.text ?? "")
    }
    
    func isValidEmail( testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPassword( testStr: String) -> Bool {
        return testStr.count > 5
    }
    
    func checkLoginButtonEnable() {
        if let emailText = emailTextField.text, let password = passwordTextField.text {
            if emailText == "Email" || password == "Password" || !checkValidateEmailAndPassword() {
                isAllowLogin = false
                loginButton.backgroundColor = UIColor.colorFromHexString(hex: "ECECEC")
                loginButton.setTitleColor(.black, for: .normal)
            } else {
                isAllowLogin = true
                loginButton.backgroundColor = UIColor.colorFromHexString(hex: "F78600")
                loginButton.setTitleColor(.white, for: .normal)
            }
        } else {
            isAllowLogin = false
            loginButton.backgroundColor = UIColor.colorFromHexString(hex: "ECECEC")
            loginButton.setTitleColor(.black, for: .normal)
        }
    }
    
    @objc func textFieldDidChange( textField: UITextField) {
        checkLoginButtonEnable()
    }

    
    
    @IBAction func loginAction(_ sender: Any) {
        if checkValidateEmailAndPassword() {
            heightValid.constant = 0
            passwordLine.backgroundColor = UIColor.colorFromHexString(hex: "C6CBD4")
            emailLine.backgroundColor = UIColor.colorFromHexString(hex: "C6CBD4")
        } else {
            heightValid.constant = 20
            emailLine.backgroundColor = UIColor.colorFromHexString(hex: "6C727C")
        }
        guard isAllowLogin else { return }
        self.endEditing(true)
        if let login = self.loginBlock {
            login( emailTextField.text!, passwordTextField.text!)
        }
    }
    
}

extension LoginCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let show = self.isShowedKeyboard {
            show()
        }
        if textField == emailTextField {
            emailTitle.isHidden = false
            emailLine.backgroundColor = UIColor.colorFromHexString(hex: "F78600")
            emailTitle.textColor = UIColor.colorFromHexString(hex: "F78600")
            if textField.text == "Email" {
                textField.text = nil
            }
        } else if textField == passwordTextField {
            passwordTitle.isHidden = false
            passwordLine.backgroundColor = UIColor.colorFromHexString(hex: "F78600")
            passwordTitle.textColor = UIColor.colorFromHexString(hex: "F78600")
            if isPwHidden {
                textField.isSecureTextEntry = true
            } else {
                textField.isSecureTextEntry = false
            }
            if textField.text == "Password" {
                textField.text = nil
            }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let hide = self.isHiddenKeyboard {
            hide()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.emailTextField.text = self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        checkLoginButtonEnable()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if textField == self.emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        // Do not add a line break
        return false
    }
}
