//
//  PeopleViewController.swift
//  Chatting
//
//  Created by 이건준 on 2021/11/02.
//

import UIKit
import Firebase

private let tableViewIdentifier = "cell"
class PeopleViewController:UITableViewController{
    var array = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        Database.database().reference().child("user").observe(DataEventType.value) { snapshot in
            print(self.array)
            self.array.removeAll()
            
            for child in snapshot.children{
                print(self.array)
                let fchild = child as! DataSnapshot
                print("fchild:\(fchild)")
                let userModel = UserModel()
                print("userModel:\(userModel)")
                
                userModel.setValuesForKeys(fchild.value as! [String : Any])
                print("usermomo:\(userModel)")
                self.array.append(userModel)
                print(self.array)
            }
            print(self.array)
            DispatchQueue.main.async {
                print("imageloading")
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewIdentifier)
    }
}
extension PeopleViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as! TableViewCell
        
        URLSession.shared.dataTask(with: URL(string: array[indexPath.row].imageURL!)!) { data, response, error in
            
            DispatchQueue.main.async {
                print("imageloading")
                cell.imgView.image = UIImage(data: data!)
            }
           
        }
        cell.nameLabel.text = array[indexPath.row].name
        return cell
    }
}
