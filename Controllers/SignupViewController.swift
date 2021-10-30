//
//  SignupViewController.swift
//  Chatting
//
//  Created by 이건준 on 2021/10/30.
//

import UIKit
import TextFieldEffects
import FirebaseAuth
import FirebaseDatabase
import Firebase

class SignupViewController:UIViewController{
    lazy var statusBar:UIView={
        let vw = UIView()
        vw.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        vw.heightAnchor.constraint(equalToConstant: 20).isActive = true
        vw.backgroundColor = .systemPink
        return vw
    }()
    
    lazy var nametxtField:HoshiTextField={
        let txt = HoshiTextField()
         txt.widthAnchor.constraint(equalToConstant: 200).isActive = true
         txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
         txt.placeholder = "Name"
         txt.borderActiveColor = .systemRed
         txt.borderInactiveColor = .systemGray
         txt.placeholderFontScale = 0.8
         return txt
    }()
    
    lazy var emailtxtField:HoshiTextField={
        let txt = HoshiTextField()
         txt.widthAnchor.constraint(equalToConstant: 200).isActive = true
         txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
         txt.placeholder = "Email"
         txt.borderActiveColor = .systemRed
         txt.borderInactiveColor = .systemGray
         txt.placeholderFontScale = 0.8
         return txt
    }()
    
    lazy var pwdtxtField:HoshiTextField={
        let txt = HoshiTextField()
         txt.widthAnchor.constraint(equalToConstant: 200).isActive = true
         txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
         txt.placeholder = "Password"
         txt.borderActiveColor = .systemRed
         txt.borderInactiveColor = .systemGray
         txt.placeholderFontScale = 0.8
        txt.isSecureTextEntry = true
         return txt
    }()
    
    lazy var signupButton:UIButton={
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("회원가입", for: UIControl.State.normal)
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(signupTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var cancelButton:UIButton={
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("취소", for: UIControl.State.normal)
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(cancelTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //MARK: -Objc
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func signupTapped(){
        Auth.auth().createUser(withEmail: emailtxtField.text!, password: pwdtxtField.text!) { User, Error in
            let uid = User?.user.uid
            Database.database().reference().child("users").child(uid!).setValue(["name" : self.nametxtField.text])
        }
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(nametxtField)
        nametxtField.translatesAutoresizingMaskIntoConstraints = false
        nametxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nametxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        view.addSubview(emailtxtField)
        emailtxtField.translatesAutoresizingMaskIntoConstraints = false
        emailtxtField.centerXAnchor.constraint(equalTo: nametxtField.centerXAnchor).isActive = true
        emailtxtField.topAnchor.constraint(equalTo: nametxtField.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(pwdtxtField)
        pwdtxtField.translatesAutoresizingMaskIntoConstraints = false
        pwdtxtField.centerXAnchor.constraint(equalTo: emailtxtField.centerXAnchor).isActive = true
        pwdtxtField.topAnchor.constraint(equalTo: emailtxtField.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.centerXAnchor.constraint(equalTo: pwdtxtField.centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: pwdtxtField.bottomAnchor, constant: 40).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerXAnchor.constraint(equalTo: signupButton.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(statusBar)
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
