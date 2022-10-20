//
//  CustomButton.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/21/22.
//

import UIKit

class CustomButton: UIButton {
    
    
    let checkmark = UIImageView(image: UIImage(named: "checkmark"))
    override var isSelected: Bool {
        didSet{
            if isSelected{
                print("selected")
            }
            else {
                print("not selected")
                
            }
        }
    }
    var image: String = "capsule"{
        didSet{
            changeImage(image: image)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createButton(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createButton(image: String){
        changeImage(image: image)
        addSubview(checkmark)
        isSelected = false
        checkmark.layer.opacity = 0.0
        checkmark.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(46)
            make.bottom.equalTo(self.snp.bottom).offset(-46)
        }
        addTarget(self, action: #selector(selectedButton), for: .touchUpInside)

    }
    
    
    private func changeImage(image: String){
        setImage(nil, for: .normal)
        switch image{
            case "pill":
                setImage(UIImage(named: "pillButton"), for: .normal)
                break
            case "capsule":
                setImage(UIImage(named: "capsuleButton"), for: .normal)
                break
            case "ampule":
                setImage(UIImage(named: "ampuleButton"), for: .normal)
                break
            case "ing":
                setImage(UIImage(named: "ingButton"), for: .normal)
                break
            default:
                setImage(UIImage(named: "pillButton"), for: .normal)
                break
            }
    }
    
    
    @objc func selectedButton(){
        UIView.animate(withDuration: 0.3, delay: 0) {
            if self.isSelected{
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.checkmark.layer.opacity = 0.0
               
            }
            else {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.checkmark.layer.opacity = 1
            }
        }
        self.isSelected.toggle()
       
    }
    
}
