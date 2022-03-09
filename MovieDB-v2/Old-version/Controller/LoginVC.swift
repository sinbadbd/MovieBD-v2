//
//  LoginVC.swift
//  MovieDB-v2
//
//  Created by Imran on 3/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
class LoginVC : BaseVC {
    let loginView = UIView()
    let changeMpinView = UIView()
    
    let currentPinLabel    = UILabel()
    let newPinLabel        = UILabel()
    let reEnternewPinLabel = UILabel()
    
    let userNameTextField = UITextField()
    let passwordTextField = UITextField()
    
    let continueButton = UIButton()
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowBottomTab = false
        resetBase()
        view.backgroundColor = .white
        setupLogin()
    }
    
    func setupLogin(){
        
        //        contentView.addSubview(loginView)
        //        loginView.position(top: contentView.topAnchor, left: contentView.leadingAnchor, bottom: nil, right: contentView.trailingAnchor)
        //        //         loginView.centerXInSuper()
        //        //         loginView.centerYInSuper()
        //        //        loginView.centerInSuperview()
        //        loginView.centerInSuper()
        //        //        loginView.centerInSuperview()
        //        loginView.backgroundColor = .red
        //        loginView.size( height: 300 )
        contentView.addSubview(changeMpinView)
        
        // MARK: LABEL
        changeMpinView.addSubview(currentPinLabel)
        changeMpinView.addSubview(newPinLabel)
        changeMpinView.addSubview(reEnternewPinLabel)
        
        // MARK: TEXT FIELD
        changeMpinView.addSubview(userNameTextField)
        changeMpinView.addSubview(passwordTextField)
        //        changeMpinView.addSubview(reEnterNewPinTextField)
        changeMpinView.addSubview(continueButton)
        changeMpinView.anchor(top: contentView.topAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              trailing: contentView.trailingAnchor,
                              padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        changeMpinView.backgroundColor = UIColor.init(red: 230/255, green: 238/255, blue: 244/255, alpha: 1)
        changeMpinView.layer.cornerRadius = 8
        shadowForViewLight(shadow: changeMpinView)
        
        // MARK: Current Pin Label
        currentPinLabel.anchor(top: changeMpinView.topAnchor,
                               leading: changeMpinView.leadingAnchor,
                               bottom: nil,
                               trailing: changeMpinView.trailingAnchor,
                               padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                               size: CGSize(width: .init(), height: 20.dynamic())
        )
        currentPinLabel.text = "User Name"
        currentPinLabel.font = UIFont(name: appFont, size: 11.dynamic())
        currentPinLabel.textColor = UIColor.init(red: 12/255, green: 16/255, blue: 38/255, alpha: 1)
        
        // MARK: Current TextField
        userNameTextField.anchor(top: currentPinLabel.bottomAnchor,
                                 leading: changeMpinView.leadingAnchor,
                                 bottom: nil,
                                 trailing: changeMpinView.trailingAnchor,
                                 padding: .init(top: 2, left: 20, bottom: 0, right: 20),
                                 size: .init(width: .init(), height: 40.dynamic())
        )
        userNameTextField.layer.cornerRadius =  4
        userNameTextField.backgroundColor = .white
        userNameTextField.setLeftPaddingPoints(11.dynamic())
        userNameTextField.placeholder = "username"
        //                 curentPinTextField.keyboardType = .numberPad
        // MARK: NEW PIN Label
        newPinLabel.anchor(top: userNameTextField.bottomAnchor,
                           leading: changeMpinView.leadingAnchor,
                           bottom: nil,
                           trailing: changeMpinView.trailingAnchor,
                           padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                           size: CGSize(width: .init(), height: 20)
        )
        
        newPinLabel.text = "Password"
        newPinLabel.font = UIFont(name: appFont, size: 11.dynamic())
        newPinLabel.textColor = UIColor.init(red: 12/255, green: 16/255, blue: 38/255, alpha: 1)
        
        // MARK: NEW PIN TextField
        passwordTextField.anchor(top: newPinLabel.bottomAnchor,
                                 leading: changeMpinView.leadingAnchor,
                                 bottom: nil,
                                 trailing: changeMpinView.trailingAnchor,
                                 padding: .init(top: 2, left: 20, bottom: 0, right: 20),
                                 size: .init(width: .init(), height: 40.dynamic())
        )
        passwordTextField.layer.cornerRadius =  4
        passwordTextField.backgroundColor = .white
        passwordTextField.setLeftPaddingPoints(11.dynamic())
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = .numberPad
        
        
        
        continueButton.anchor(top: passwordTextField.bottomAnchor, leading: changeMpinView.leadingAnchor, bottom: changeMpinView.bottomAnchor, trailing: changeMpinView.trailingAnchor, padding: .init(top: 30, left: 20, bottom: 30, right: 20), size: CGSize(width: .init(), height: 40))
        continueButton.backgroundColor = btnColorBlue
        continueButton.setTitle("Submit".uppercased(), for: UIControl.State.normal)
        continueButton.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        continueButton.titleLabel?.font = UIFont(name: appFont, size: 15.dynamic())!
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 3
    }
    
    @objc func btnPressed(_ sender : UIButton){
        sender.alpha  = 0.5
        //        let name = self.userNameTextField.text ?? ""
        //        let pass =   self.passwordTextField.text  ?? ""
        UIView.animate(withDuration: 0.1
            , animations: {
                sender.alpha  = 1
                APIClient.getRequestToken { (success, error) in
                    if success {
                        //print(APIClient.Auth.requestToken)
                        DispatchQueue.main.async {
                            let username = self.userNameTextField.text ?? ""
                            let password = self.passwordTextField.text ?? ""
                            
                            if username == ""  || password == "" {
                                print("hi")
                                //                              SVProgressHUD.dismiss()
                                let alert =  UIAlertController(title: "Alert", message: "Email &    Password wrong!", preferredStyle: .alert)
                                let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                                alert.addAction(ok)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                APIClient.login(username: username, password: password, completion: { (success, error) in
                                    if success {
                                        //                                      SVProgressHUD.dismiss()
                                        print("requestToken: \(APIClient.Auth.requestToken)")
                                        APIClient.createSessionId(completion: { (success, error) in
                                            if success {
                                                DispatchQueue.main.async{
                                                    //  print(log)
                                                    print(username,password)
                                                    session_token = APIClient.Auth.sessionId
                                                    print("session_token : \(session_token)")
                                                    
                                                    self.userDefault.setLoginSatus(value: true)
                                                    self.userDefault.set(session_token, forKey: "session_token")
                                                    self.userDefault.set(user_name, forKey: "user_name")
                                                    
                                                    
                                                    
                                                    //                                                    if (UserDefaults.standard.object(forKey: "session_token") != nil) {
                                                    //                                                        if (UserDefaults.standard.object(forKey: "user_name") != nil) {
                                                    //                                                            user_name = (UserDefaults.standard.object(forKey: "user_name")) as! String
                                                    //                                                        }
                                                    //
                                                    //                                                        session_token = (UserDefaults.standard.object(forKey: "session_token")) as! String
                                                    //
                                                    //                                                        print("session_token: \(session_token)")
                                                    //                                                        print("user_name: \(user_name)")
                                                    //
                                                    //                                                    }
                                                    //                                                    self.userDefault.setEmail(value: username)
                                                    //                                                    self.userDefault.setSessionToken(value: APIClient.Auth.requestToken)
                                                    
                                                    self.navigationController?.popViewController(animated: true)
                                                    //
                                                    
                                                }
                                                //                                              SVProgressHUD.dismiss()
                                            }
                                        })
                                    }
                                })
                            }
                        }
                    }
                }
        }) { (_) in
            
            
        }
    }
}
