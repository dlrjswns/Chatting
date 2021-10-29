//
//  LoginViewController.swift
//  Chatting
//
//  Created by 이건준 on 2021/10/29.
//

import UIKit
import TextFieldEffects

class LoginViewController:UIViewController{
    lazy var statusView:UIView={
        let vw = UIView()
        vw.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        vw.heightAnchor.constraint(equalToConstant: 30).isActive = true
        vw.backgroundColor = .systemPink
        return vw
    }()
    
    lazy var imageView:UIImageView={
        let imageView = UIImageView(image: UIImage(named: "talk.png"))
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var idtextField:HoshiTextField={
       let txt = HoshiTextField()
        txt.widthAnchor.constraint(equalToConstant: 200).isActive = true
        txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        txt.borderStyle = .line
        txt.placeholder = "ID"
        txt.borderActiveColor = .systemRed
        txt.borderInactiveColor = .systemGray
        txt.placeholderFontScale = 0.8
        return txt
    }()
    
    lazy var pwdtextField:HoshiTextField={
       let txt = HoshiTextField()
        txt.widthAnchor.constraint(equalToConstant: 200).isActive = true
        txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        txt.borderStyle = .line
        txt.placeholder = "PWD"
        txt.borderActiveColor = .systemRed
        txt.borderInactiveColor = .systemGray
        txt.placeholderFontScale = 0.8
        return txt
    }()
    
    lazy var loginButton:UIButton={
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("로그인", for: UIControl.State.normal)
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemPink
        return button
    }()
    
    lazy var pwdButton:UIButton={
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("회원가입", for: UIControl.State.normal)
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemPink
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        
        view.addSubview(idtextField)
        idtextField.translatesAutoresizingMaskIntoConstraints = false
        idtextField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        idtextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(pwdtextField)
        pwdtextField.translatesAutoresizingMaskIntoConstraints = false
        pwdtextField.centerXAnchor.constraint(equalTo: idtextField.centerXAnchor).isActive = true
        pwdtextField.topAnchor.constraint(equalTo: idtextField.bottomAnchor, constant: 20).isActive = true
    
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: pwdtextField.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: pwdtextField.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(pwdButton)
        pwdButton.translatesAutoresizingMaskIntoConstraints = false
        pwdButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        pwdButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(statusView)
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
