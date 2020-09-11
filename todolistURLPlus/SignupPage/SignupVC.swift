//
//  SignupVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

//TODO 鍵盤位置 正則


class SignupVC: UIViewController {
    //MARK:- Properties
    
    @IBOutlet weak var userNameTF: CustomLogINTF!
    
    @IBOutlet weak var mailTF: CustomLogINTF!
    
    @IBOutlet weak var passwordTF: CustomLogINTF!
    
    @IBOutlet weak var checkPasswordTF: CustomLogINTF!
    //
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var mailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var checkPasswordErrorLabel: UILabel!
    
    @IBOutlet weak var registerBtn: CustomButton!
    
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTF()
        //TODO 鍵盤上移事件
    }
    override func viewWillAppear(_ animated: Bool) {
        registerBtn.isEnabled = false
    }
    
    //MARK:- Functions
    
    fileprivate func settingTF() {
        userNameTF.delegate = self
        mailTF.delegate = self
        passwordTF.delegate = self
        checkPasswordTF.delegate = self
    }
    
    @IBAction func textfieldValueChange(_ sender: CustomLogINTF) {
        switch sender {
        case checkPasswordTF:
            
            let animate = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
                self.registerBtn.backgroundColor = self.checkPasswordTF.text == self.passwordTF.text ? .mainColor : .glassColor
            }
            animate.startAnimation()
            
            registerBtn.isEnabled = checkPasswordTF.text == passwordTF.text ? true : false
        default:
            break
        }
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signupBtnTapped(_ sender: CustomButton) {
        register()
    }
    
    
    
    func register(){
        //驗證資料 成功的話包裝
        guard let parameters = validate() else {
            self.present(.makeAlert(title: "Error", message: "輸入錯誤", handler: {
            }), animated: true)
            return
        }
        
        let rgisterRequest = HTTPRequest(endpoint: .register, method: .POST, parameters: parameters)
        
        NetworkManager().sendRequest(with: rgisterRequest.send()) { (result:Result<LoginInReaponse,NetworkError>) in
            switch result{
                
            case .success(let message):
                print(message)
                if let errorMessage = message.error {
                    print(errorMessage)
                }else {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            case .failure(let err):
                print(err.description)
            }
        }
        
    }
    
    func validate() -> [String:Any]? {
        guard let name = userNameTF.text , let mail = mailTF.text , let password = passwordTF.text else { return nil }
        
        if name.isValidName , mail.isValidEMail , password.isValidPassword , password == checkPasswordTF.text {
            return ["username": name , "password":password , "email" : mail ]
            
        }else if name == "" || mail == "" || password == "" || checkPasswordTF.text == "" {
            present(.makeAlert(title: "錯誤", message: "輸入框不可空白", handler: {
            }), animated: true)
        }
        return nil
    }
}



//MARK:- TextFieldDelegate

extension SignupVC:UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTF:
            mailTF.becomeFirstResponder()
        case mailTF :
            passwordTF.becomeFirstResponder()
        case passwordTF:
            checkPasswordTF.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case userNameTF:
            nameErrorLabel.text = userNameTF.text!.isValidName ? "" : "名稱字元必須介於2 - 16"
        case mailTF:
            mailErrorLabel.text = mailTF.text!.isValidEMail ? "" : "Email格式錯誤"
        case passwordTF:
            passwordErrorLabel.text = passwordTF.text!.isValidPassword ? "" : "密碼格式錯誤"
        case checkPasswordTF:
            checkPasswordErrorLabel.text = checkPasswordTF.text == passwordTF.text ? "" : "確認密碼與密碼不同"
        default:
            break
        }
    }
    
    
    
    
}
