//
//  CustomTableViewCell.swift
//  
//
//  Created by Nikita  on 10/13/22.
//

import UIKit
import SnapKit
import CoreHaptics

enum Direction{
    case rightAccept
    case leftDelete
}
class CustomTableViewCell: UITableViewCell {
    public var currentPill: Pill? = nil
    static let identifier = String(describing: CustomTableViewCell.self)
    public var delegate: CellSwipeButtonDelegate? = nil
    public var isShowingAcceptView = false
    public var isShowingDeleteView = false
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
        tabletDescription.numberOfLines = 2
        return tabletDescription
    }()
    
    private var tabletImage: UIImageView = {
        let tabletImage = UIImageView()
        return tabletImage
    }()
    //MARK: - acceptButton
    private var acceptButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 72, height: 100))
        button.setImage(UIImage(named: "acceptView"), for: .normal)
        button.setImage(UIImage(named: "tappedAcceptView"), for: .highlighted)
        button.layer.opacity = 0
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private var deleteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 72, height: 100))
        button.setImage(UIImage(named: "redDeleteButton"), for: .normal)
        button.setImage(UIImage(named: "tappedRedDeleteButton"), for: .highlighted)
        button.layer.opacity = 0
        button.isUserInteractionEnabled = true
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
        
        
        
        let leftDeleteSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftDeleteSwipePerformed))
        leftDeleteSwipeRecognizer.direction = .left
        view.addGestureRecognizer(leftDeleteSwipeRecognizer)
        
        let rightDeleteSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightDeleteSwipePerformed))
        rightDeleteSwipeRecognizer.direction = .right
        view.addGestureRecognizer(rightDeleteSwipeRecognizer)
        
        let rightAcceptSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightAcceptSwipePerformed))
        rightAcceptSwipeRecognizer.direction = .right
        view.addGestureRecognizer(rightAcceptSwipeRecognizer)
        
        let leftAcceptSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftAcceptSwipePerformed))
        leftAcceptSwipeRecognizer.direction = .left
        view.addGestureRecognizer(leftAcceptSwipeRecognizer)
        
        
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "Gray 2")?.cgColor
        view.layer.borderWidth = 0.5
        
        view.addSubview(tabletName)
        tabletName.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(24)
            make.left.equalTo(view.snp.left).offset(88)
            make.right.equalTo(view.snp.right).offset(-10)
            
        }
        
        
        view.addSubview(tabletDescription)
        tabletDescription.snp.makeConstraints { make in
            make.top.equalTo(tabletName.snp.bottom).offset(8)
            make.left.equalTo(tabletName.snp.left)
            make.right.equalTo(view.snp.right).offset(-10)
        }
        view.addSubview(tabletImage)
        
        contentView.addSubview(acceptButton)
        acceptButton.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        acceptButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.left).offset(-12)
            make.top.equalTo(view)
            make.height.equalTo(100)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        deleteButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.right).offset(12)
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
    
    @objc func rightAcceptSwipePerformed(){
        print("accept RIGHT")
        guard !isShowingDeleteView else {
            rightDeleteSwipePerformed()
            return
        }
        
        isShowingAcceptView = true
        acceptButton.setImage(UIImage(named: "acceptView"), for: .normal)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            
            self.acceptButton.layer.opacity = 1
            self.view.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(95.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
    }
    
    @objc func leftAcceptSwipePerformed(){
        print("accept LEFT")
        print(isShowingAcceptView, isShowingDeleteView)
        guard !isShowingDeleteView && isShowingAcceptView else {
            leftDeleteSwipePerformed()
            return
        }
        isShowingAcceptView = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.acceptButton.layer.opacity = 0.0
            self.view.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(20.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
    }
    
    @objc func acceptButtonPressed(){
        guard let pill = currentPill else {return}
        delegate?.didTapAcceptButton(self.acceptButton, id: pill.id!)
        isShowingAcceptView = false
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.acceptButton.setImage(UIImage(named: "tappedAcceptView"), for: .normal)
            guard let self else { return }
            self.acceptButton.layer.opacity = 0.0
            self.view.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(20.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
        
    }
    
    @objc func leftDeleteSwipePerformed(){
        guard !isShowingAcceptView else {
            leftAcceptSwipePerformed()
            return
        }
        
        isShowingDeleteView = true
        self.deleteButton.setImage(UIImage(named: "redDeleteButton"), for: .normal)
        print("delete LEFT")
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            
            self.deleteButton.layer.opacity = 1
            self.view.snp.updateConstraints {
                $0.trailing.equalToSuperview().offset(-95.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
    }
    
    @objc func rightDeleteSwipePerformed(){
        isShowingDeleteView = false
        print("delete RIGHT")
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            
            self.deleteButton.layer.opacity = 0
            self.view.snp.updateConstraints {
                $0.trailing.equalToSuperview().offset(-20.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
    }
    
    @objc func deleteButtonPressed(){
        guard let pill = currentPill else {return}
        delegate?.didTapDeleteButton(self.deleteButton, id: pill.id!)
        isShowingDeleteView = false
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.deleteButton.setImage(UIImage(named: "tappedRedDeleteButton"), for: .normal)
            guard let self else { return }
            self.deleteButton.layer.opacity = 0.0
            self.view.snp.updateConstraints {
                $0.trailing.equalToSuperview().offset(-20.0)
            }
            
            self.contentView.layoutIfNeeded()
        }
        
    }
    
 
    
}
