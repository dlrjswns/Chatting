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
import FirebaseStorage

class SignupViewController:UIViewController{
    lazy var statusBar:UIView={
        let vw = UIView()
        vw.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        vw.heightAnchor.constraint(equalToConstant: 20).isActive = true
        vw.backgroundColor = .systemPink
        return vw
    }()
    
    lazy var imageView:UIImageView={
       let imgView = UIImageView()
        imgView.image = UIImage(named: "personAdd.png")
        imgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.layer.borderWidth = 1
        imgView.layer.cornerRadius = 50
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        return imgView
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
        guard let nameText = nametxtField.text,
              let emailText = emailtxtField.text,
              let pwdText = pwdtxtField.text
              else{return}
        Auth.auth().createUser(withEmail: emailText, password: pwdText) { [self] User, Error in
            guard let user = User?.user, Error == nil else{return}
            guard let data = imageView.image?.pngData() else{return}
            let uid = user.uid
            let imageRef = Storage.storage().reference().child("userImage").child(uid)
            imageRef.putData(data, metadata: nil) { StorageMetadata, Error in
                imageRef.downloadURL { URL, Error in
                    Database.database().reference().child("user").child(uid).setValue(["name" : nameText, "imageURL" : URL?.absoluteString, "uid":Auth.auth().currentUser?.uid])
                }
            }
            self.dismiss(animated: true) {
                let alert = UIAlertController(title: "알림", message: "회원가입에 성공했습니다", preferredStyle: UIAlertController.Style.alert)
                let positive = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(positive)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func imageViewTapped(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        view.addSubview(nametxtField)
        nametxtField.translatesAutoresizingMaskIntoConstraints = false
        nametxtField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        nametxtField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        
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
extension SignupViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = (info[.editedImage] as! UIImage)
        self.dismiss(animated: true) {
            let alert = UIAlertController(title: "알림", message: "프로필을 등록하였습니다", preferredStyle: UIAlertController.Style.alert)
            let positive = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(positive)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) {
            let alert = UIAlertController(title: "알림", message: "프로필등록을 취소하였습니다", preferredStyle: UIAlertController.Style.alert)
            let positive = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(positive)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
