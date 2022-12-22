//
//  CustomCollectionViewCell.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/30/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    private var isChosen: Bool = false
    public let myLabel: UILabel = {
        let label = UILabel()
        label.text = "My label"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "Gray 2")
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "Gray 4")
        contentView.layer.opacity = 0
        contentView.addSubview(myLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = CGRect(x: 10, y: contentView.frame.size.height - 40, width: contentView.frame.size.width - 15, height: 40)
    }
    
    public func configure(text: String){
        myLabel.text = text
    }
    
    public func changeState(isChosen: Bool){
       
            if isChosen{
                self.myLabel.textColor = UIColor(named: "Dark")
                self.contentView.backgroundColor = UIColor(named: "Gray 4")
                self.contentView.layer.cornerRadius = 20
                self.contentView.layer.opacity = 100
                self.isChosen = !isChosen
            }
            else {
                self.myLabel.textColor = UIColor(named: "Gray 2")
                self.contentView.backgroundColor = .clear
                self.contentView.layer.opacity = 100
                self.isChosen = !isChosen
            }
    }
    
}
