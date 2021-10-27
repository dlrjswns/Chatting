//
//  RootViewController.swift
//  Chatting
//
//  Created by 이건준 on 2021/10/28.
//

import UIKit
import SnapKit
import Firebase

class RootViewController:UIViewController{
    
    var remoteConfig:RemoteConfig!
    lazy var imageView:UIImageView={
        let imageView = UIImageView()
        imageView.image = UIImage(named: "talk.png")
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults") //만약에 서버와 연결이 안될 경우 이 default값을 사용
        
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
              // ...
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          self.displayWelcome()
        }

    }
    
    func displayWelcome(){
        print("displayWelcome()")
//        let color = remoteConfig["splash_background"].stringValue
        let caps = remoteConfig["splash_message_caps"].boolValue
        let message = remoteConfig["splash_message"].stringValue
        
        if (caps){
            print("displayWelcome()-caps")
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: UIAlertController.Style.alert)
            let positive = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {action in
//                exit(0) 앱이 꺼짐
            })
            alert.addAction(positive)
            self.present(alert, animated: true, completion: nil)
        }
        print("displayWelcome()-nocaps")
        self.view.backgroundColor = .blue
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
