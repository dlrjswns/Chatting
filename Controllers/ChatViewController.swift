//
//  ChatViewController.swift
//  Chatting
//
//  Created by 이건준 on 2021/11/02.
//

import UIKit
import Firebase

class ChatViewController:UIViewController{
    var destinationUid:String? //내가 채팅할 대상의 uid
    
    lazy var button:UIButton={
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("전송", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(btnTapped), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var txtField:UITextField={
       let txt = UITextField()
        txt.layer.borderColor = UIColor.black.cgColor
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txt.widthAnchor.constraint(equalToConstant: view.frame.width-60).isActive = true
        txt.backgroundColor = .systemPink
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        
        view.addSubview(txtField)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        txtField.rightAnchor.constraint(equalTo: button.leftAnchor, constant: -5).isActive = true
    }
    
    //MARK: -@objc
    @objc func btnTapped(){
        let createRoomInfo = ["uid":Auth.auth().currentUser?.uid,
                              "destinationUid":destinationUid]
        
        Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo)
    }
}
