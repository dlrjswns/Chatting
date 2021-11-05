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
    
//    lazy var utilityView:UIView={
//       let vw = UIView()
//        vw.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//        vw.backgroundColor = .systemBackground
//        return vw
//    }()
    //tableView에 Cell이 존재하지않는곳을 가리는 view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        Database.database().reference().child("user").observe(DataEventType.value) { snapshot in
            print(self.array)
            self.array.removeAll()
            
            for child in snapshot.children{
                let fchild = child as! DataSnapshot
                let userModel = UserModel()
                
                userModel.setValuesForKeys(fchild.value as! [String : Any])
                self.array.append(userModel)
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
        
//        URLSession.shared.dataTask(with: URL(string: array[indexPath.row].imageURL!)!) { data, response, error in
//
//            DispatchQueue.main.async {
//                print("data:\(data)")
//                cell.imgView.image = UIImage(data: data!)
//                print("imageloading")
//            }
//
//        }
        let url:URL! = URL(string: array[indexPath.row].imageURL!)
        let data = try! Data(contentsOf: url)
        DispatchQueue.main.async {
                       print("data:\(data)")
                       cell.imgView.image = UIImage(data: data)
                       print("imageloading")
                   }
        cell.nameLabel.text = array[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController()
        vc.destinationUid = self.array[indexPath.row].uid
        navigationController?.pushViewController(vc, animated: true)
    }
}
