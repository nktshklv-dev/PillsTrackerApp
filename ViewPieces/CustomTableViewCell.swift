//
//  CustomTableViewCell.swift
//  
//
//  Created by Nikita  on 10/13/22.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let view = UIView(frame: CGRect(x: 30, y: 10, width: 327, height: 100))
       
        contentView.addSubview(view)
   
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "Gray 2")?.cgColor
        view.layer.borderWidth = 0.5
        
        
        let tabletName = UILabel()
        tabletName.font = UIFont.boldSystemFont(ofSize: 20)
        tabletName.textColor = UIColor(named: "Dark")
        view.addSubview(tabletName)
        tabletName.text = "Tablet name"
        tabletName.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(24)
            make.left.equalTo(view.snp.left).offset(88)
            
        }
        
        let tabletDescription = UILabel()
        tabletDescription.textColor = UIColor(named: "Gray 1")
        tabletDescription.text = "Tablet description"
        tabletDescription.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(tabletDescription)
        tabletDescription.snp.makeConstraints { make in
            make.top.equalTo(tabletName.snp.bottom).offset(8)
            make.left.equalTo(tabletName.snp.left)
        }
        
        
        let daysLabel = UILabel()
        daysLabel.textColor = UIColor(named: "Gray 1")
        daysLabel.text = "7 days"
        daysLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(daysLabel)
        daysLabel.snp.makeConstraints { make in
            make.top.equalTo(tabletName.snp.bottom).offset(8)
            make.left.equalTo(tabletDescription.snp.right).offset(44)
        }
        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "capsule")
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            if imageView.image == UIImage(named: "capsule"){
                make.left.equalTo(view.snp.left).offset(4)
                make.top.equalTo(view.snp.top).offset(6)
            }
            else if  imageView.image == UIImage(named: "ampule"){
                make.left.equalTo(view.snp.left).offset(15)
                make.top.equalTo(view.snp.top).offset(17)
            }
            else if  imageView.image == UIImage(named: "pill"){
                make.left.equalTo(view.snp.left).offset(10)
                make.top.equalTo(view.snp.top).offset(10)
            }
            else if imageView.image == UIImage(named: "ing"){
                make.left.equalTo(view.snp.left).offset(29)
                make.top.equalTo(view.snp.top).offset(25)
            }
        }
        
        
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
}
