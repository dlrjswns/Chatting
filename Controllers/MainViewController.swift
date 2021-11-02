//
//  ChatViewController.swift
//  Chatting
//
//  Created by 이건준 on 2021/11/02.
//

import UIKit

class MainViewController:UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeTabbar()
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBlue
    }
    
    func makeTabbar(){
        let people = PeopleViewController()
        let chat = ChatViewController()
        let account = AccountViewController()
        
        people.title = "People"
        chat.title = "Chatting"
        account.title = "Account"
        
        self.setViewControllers([people, chat, account], animated: true)
        self.tabBar.clipsToBounds = true
        
        guard let items = self.tabBar.items else {return}
        let images = ["user.png", "chat.png", "account.png"]
        
        for a in 0..<items.count{
            items[a].image = UIImage(named: images[a])
        }
    }
}
