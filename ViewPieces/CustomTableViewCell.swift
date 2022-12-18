//
//  CustomTableViewCell.swift
//  
//
//  Created by Nikita  on 10/13/22.
//

import UIKit
import SnapKit
import CoreHaptics

class CustomTableViewCell: UITableViewCell {
    static let identifier = String(describing: CustomTableViewCell.self)
    
    var view: UIView!
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
        view = UIView(frame: .zero)
        self.contentView.addSubview(view)
        
        view.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(100.0)
        }
        
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipePerformed))
        rightSwipeRecognizer.direction = .right
        view.addGestureRecognizer(rightSwipeRecognizer)
        
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipePerformed))
        leftSwipeRecognizer.direction = .left
        view.addGestureRecognizer(leftSwipeRecognizer)
        
        
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
        view.addSubview(tabletImage)
        view.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.left).offset(-12)
            make.top.equalTo(view)
            make.height.equalTo(100)
        }
    }
    
    public func configure(name: String, description: String, imageName: String){
        
        tabletName.text = name
        tabletDescription.text = description
        
        let image = UIImage(named: imageName)
        tabletImage.image = image
        tabletImage.snp.makeConstraints { make in
            if tabletImage.image == UIImage(named: "capsule"){
                make.left.equalTo(view.snp.left).offset(2)
                make.top.equalTo(view.snp.top).offset(7)
            }
            else if tabletImage.image == UIImage(named: "ing"){
                make.left.equalTo(view.snp.left).offset(8)
                make.top.equalTo(view.snp.top).offset(10)
            }
            else if tabletImage.image == UIImage(named: "ampule"){
                make.left.equalTo(view.snp.left).offset(12)
                make.top.equalTo(view.snp.top).offset(30)
            }
            else if  tabletImage.image == UIImage(named: "pill"){
                make.left.equalTo(view.snp.left).offset(8)
                make.top.equalTo(view.snp.top).offset(10)
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
    
    @objc func rightSwipePerformed(_ recognizer: UISwipeGestureRecognizer){
        print("performed right swipe action")
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.acceptButton.layer.opacity = 1
            self.view.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(95.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
    }
    
    @objc func leftSwipePerformed(_ recognizer: UISwipeGestureRecognizer){
        print("performed left swipe action")
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.acceptButton.layer.opacity = 0.0
            self.view.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(20.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
    }
    
    
    
}
