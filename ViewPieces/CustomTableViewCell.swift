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
    
   
   private var tabletName: UILabel = {
        let tabletName = UILabel()
        tabletName.font = UIFont.boldSystemFont(ofSize: 20)
        tabletName.textColor = UIColor(named: "Dark")
        return tabletName
    }()
    
    private var tabletDescription: UILabel = {
        let tabletDescription = UILabel()
        tabletDescription.textColor = UIColor(named: "Gray 1")
        tabletDescription.font = UIFont.systemFont(ofSize: 16)
        return tabletDescription
    }()
    
    private var tabletImage: UIImageView = {
        let tabletImage = UIImageView()
        return tabletImage
    }()
    //MARK: - acceptButton
    private var acceptButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "acceptView"), for: .normal)
        button.layer.opacity = 0 
        return button
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let view = UIView(frame: CGRect(x: 30, y: 10, width: 327, height: 100))
       
        self.contentView.addSubview(view)
   
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "Gray 2")?.cgColor
        view.layer.borderWidth = 0.5
        
        view.addSubview(tabletName)
        tabletName.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(24)
            make.left.equalTo(view.snp.left).offset(88)
            
        }
        
       
        view.addSubview(tabletDescription)
        tabletDescription.snp.makeConstraints { make in
            make.top.equalTo(tabletName.snp.bottom).offset(8)
            make.left.equalTo(tabletName.snp.left)
        }
        
        //MARK: - Days Label
//        let daysLabel = UILabel()
//        daysLabel.textColor = UIColor(named: "Gray 1")
//        daysLabel.text = "7 days"
//        daysLabel.font = UIFont.systemFont(ofSize: 16)
//        view.addSubview(daysLabel)
//        daysLabel.snp.makeConstraints { make in
//            make.top.equalTo(tabletName.snp.bottom).offset(8)
//            make.left.equalTo(tabletDescription.snp.right).offset(44)
//        }
        
        view.addSubview(tabletImage)
        view.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.left).offset(-12)
            make.top.equalTo(view)
        }
    }
    
    public func configure(name: String, description: String, imageName: String){
        
        tabletName.text = name
        tabletDescription.text = description
        
        let image = UIImage(named: imageName)
        tabletImage.image = image
        tabletImage.snp.makeConstraints { make in
            if tabletImage.image == UIImage(named: "capsule"){
                make.left.equalTo(self.contentView.snp.left).offset(32)
                make.top.equalTo(self.contentView.snp.top).offset(15)
            }
            else if tabletImage.image == UIImage(named: "ing"){
                make.left.equalTo(self.contentView.snp.left).offset(57)
                make.top.equalTo(self.contentView.snp.top).offset(36)
            }
            else if  tabletImage.image == UIImage(named: "ampule"){
                make.left.equalTo(self.contentView.snp.left).offset(42)
                make.top.equalTo(self.contentView.snp.top).offset(28)
            }
            else if  tabletImage.image == UIImage(named: "pill"){
                make.left.equalTo(self.contentView.snp.left).offset(37)
                make.top.equalTo(self.contentView.snp.top).offset(20)
            }
          
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tabletName.text = nil
        tabletDescription.text = nil
        tabletImage.image = nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
}
