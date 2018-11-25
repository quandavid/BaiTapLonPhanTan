//
//  RegisterCell.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 7/26/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import UIKit

class RegisterCell: AppTableViewCell {
    
    //MARK: Outlet
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var rePasswordTextField: UITextField!
    
    @IBOutlet var cancelPasswordImage: UIImageView!
    
    @IBOutlet var emailExistHeight: NSLayoutConstraint!
    
    @IBOutlet var passwordNotMatchHeight: NSLayoutConstraint!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var rePasswordLine: UIView!
    
    @IBOutlet var emailLine: UIView!
    
    @IBOutlet var emailTitle: UILabel!
    
    @IBOutlet var passwordTitle: UILabel!
    
    @IBOutlet var rePasswordTitle: UILabel!
    
    @IBOutlet var cancelEmailImage: UIImageView!

    @IBOutlet var validEmailText: UILabel!
    
    @IBOutlet var passwordLine: UIView!
    
    @IBOutlet var validPasswordText: UILabel!
    
    @IBOutlet var usernameText: UITextField!
    
    //MARK: Value
    var isAllowRegister: Bool = false
    
    //MARK: Block
    var forgotPasswordBlock: (() -> ())?
    var isShowedKeyboard: (() -> ())?
    var isHiddenKeyboard: (() -> ())?
    var registerBlock: ((_ name: String, _ email: String, _ password: String) -> ())?
    var alreadyAccount: (() -> ())?
    
    //MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        initSomething()
        // Initialization code
    }
    
    func showErrorExistEmail() {
        emailExistHeight.constant = 46
        validEmailText.isHidden = false
        validEmailText.text = "Email already exists!"
        emailLine.backgroundColor = UIColor.colorFromHexString(hex: "FF0000")
        cancelEmailImage.isHidden = false
    }
    
    func initSomething() {
        self.selectionStyle = .none
        emailTextField.delegate = self
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        usernameText.delegate = self
        rePasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        cancelPasswordImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCancel)))
        cancelPasswordImage.isUserInteractionEnabled = true
        
        cancelEmailImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapEmailCancel)))
        cancelEmailImage.isUserInteractionEnabled = true
        
        
        
        validEmailText.isHidden = true
        validPasswordText.isHidden = true
        emailTitle.isHidden = true
        passwordTitle.isHidden = true
        rePasswordTitle.isHidden = true
        emailExistHeight.constant = 0
        passwordNotMatchHeight.constant = 0
        cancelPasswordImage.isHidden = true
        cancelEmailImage.isHidden = true
        checkRegisterButtonEnable()
    }
    
    
    
    //MARK: Action
    @objc func tapCancel() {
        self.rePasswordTextField.text = ""
        self.cancelPasswordImage.isHidden = true
        if !checkMatchPassword() {
            validPasswordText.isHidden = false
            passwordNotMatchHeight.constant = 34
            rePasswordLine.backgroundColor = UIColor.colorFromHexString(hex: "FF0000")
        } else {
            validPasswordText.isHidden = true
            passwordNotMatchHeight.constant = 0
            rePasswordLine.backgroundColor = UIColor.colorFromHexString(hex: "C6CBD4")
        }
        checkRegisterButtonEnable()
    }
    
    @objc func tapEmailCancel() {
        self.emailTextField.text = ""
        self.cancelEmailImage.isHidden = true
        checkRegisterButtonEnable()
    }
    
    func checkValidateEmailAndPassword() -> Bool {
        return isValidEmail(testStr: emailTextField.text ?? "") && isValidPassword(testStr: passwordTextField.text ?? "")
    }
    
    func checkMatchPassword() -> Bool {
        guard let password = passwordTextField.text, let repassword = rePasswordTextField.text else {
            return false
        }
        return password == repassword
    }
    
    
    
    func isValidEmail( testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPassword( testStr: String) -> Bool {
        return testStr.count > 5
    }
    
    func checkRegisterButtonEnable() {
        if let emailText = emailTextField.text, let password = passwordTextField.text, let rePassword = rePasswordTextField.text{
            if emailText == "Email" || password == "Password" || rePassword == "Confirm your password" || !checkMatchPassword() || !checkValidateEmailAndPassword() {
                isAllowRegister = false
                signUpButton.backgroundColor = UIColor.colorFromHexString(hex: "ECECEC")
                signUpButton.setTitleColor(.black, for: .normal)
            } else {
                isAllowRegister = true
                signUpButton.backgroundColor = UIColor.colorFromHexString(hex: "F78600")
                signUpButton.setTitleColor(.white, for: .normal)
            }
        } else {
            isAllowRegister = false
            signUpButton.backgroundColor = UIColor.colorFromHexString(hex: "ECECEC")
            signUpButton.setTitleColor(.black, for: .normal)
        }
    }
    
    
    func checkHideCancelImage() {
        if checkMatchPassword() {
            cancelPasswordImage.isHidden = true
        } else {
            cancelPasswordImage.isHidden = false
        }
    }
    
    func checkHideEmailCancelImage() {
        if isValidEmail(testStr: emailTextField.text ?? "") {
            cancelEmailImage.isHidden = true
        } else {
            cancelEmailImage.isHidden = false
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        checkRegisterButtonEnable()
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if !checkValidateEmailAndPassword() {
            validEmailText.isHidden = false
            emailExistHeight.constant = 46
            emailLine.backgroundColor = UIColor.colorFromHexString(hex: "FF0000")
            validEmailText.text = "Invalid email or password!"
        } else {
            validEmailText.isHidden = true
            emailExistHeight.constant = 0
            emailLine.backgroundColor = UIColor.colorFromHexString(hex: "C6CBD4")
        }
        if !checkMatchPassword() {
            validPasswordText.isHidden = false
            passwordNotMatchHeight.constant = 34
            rePasswordLine.backgroundColor = UIColor.colorFromHexString(hex: "FF0000")
        } else {
            validPasswordText.isHidden = true
            passwordNotMatchHeight.constant = 0
            rePasswordLine.backgroundColor = UIColor.colorFromHexString(hex: "C6CBD4")
        }
        checkHideCancelImage()
        checkHideEmailCancelImage()
        guard isAllowRegister else { return }
        self.endEditing(true)
        if let register = self.registerBlock {
            register(usernameText.text!, emailTextField.text!, passwordTextField.text!)
        }
    }
    
}

extension RegisterCell: UITextFieldDelegate {
    
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
            if textField.text == "Password" {
                textField.text = nil
                textField.isSecureTextEntry = true
            }
        } else if textField == rePasswordTextField {
            rePasswordTitle.isHidden = false
            rePasswordLine.backgroundColor = UIColor.colorFromHexString(hex: "F78600")
            rePasswordTitle.textColor = UIColor.colorFromHexString(hex: "F78600")
            if textField.text == "Confirm your password" {
                textField.text = nil
                textField.isSecureTextEntry = true
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
        if textField == emailTextField {
            emailLine.backgroundColor = UIColor.colorFromHexString(hex: "6C727C")
            emailTitle.textColor = UIColor.colorFromHexString(hex: "6C727C")
            if (emailTextField.text?.isEmpty)! {
                textField.text = "Email"
                emailTitle.isHidden = true
            }
        } else if textField == passwordTextField {
            passwordLine.backgroundColor = UIColor.colorFromHexString(hex: "6C727C")
            passwordTitle.textColor = UIColor.colorFromHexString(hex: "6C727C")
            if (passwordTextField.text?.isEmpty)! {
                textField.text = "Password"
                passwordTitle.isHidden = true
                textField.isSecureTextEntry = false
            }
        } else if textField == rePasswordTextField {
            rePasswordLine.backgroundColor = UIColor.colorFromHexString(hex: "6C727C")
            rePasswordTitle.textColor = UIColor.colorFromHexString(hex: "6C727C")
            if (rePasswordTextField.text?.isEmpty)! {
                textField.text = "Confirm your password"
                rePasswordTitle.isHidden = true
                textField.isSecureTextEntry = false
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if textField == self.emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            rePasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        // Do not add a line break
        return false
    }
}

