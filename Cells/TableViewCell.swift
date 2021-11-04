//
//  TableViewCell.swift
//  Chatting
//
//  Created by 이건준 on 2021/11/04.
//

import UIKit

class TableViewCell:UITableViewCell{
    lazy var imgView:UIImageView={
        let imgView = UIImageView()
        imgView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        imgView.layer.cornerRadius = self.frame.height/2
        imgView.backgroundColor = .systemBackground
        return imgView
    }()
    
    lazy var nameLabel:UILabel={
       let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Configure
    func configure(){
        self.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 5).isActive = true
    }
}
