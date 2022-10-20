//
//  ChooseMedicationImageButton.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/20/22.
//

import UIKit
import SnapKit

class ChooseMedicationImageButton: UIButton {
    
    let checkmarkImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createButton()
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func createButton(){
        self.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        self.backgroundColor = UIColor(named: "Gray 4")
        self.layer.cornerRadius = 32
        self.setImage(UIImage(named: "pill"), for: .normal)
        self.addTarget(self, action: #selector(didPress), for: .touchUpInside)
        self.adjustsImageWhenHighlighted = false
        checkmarkImage.image = nil
        self.addSubview(checkmarkImage)
        checkmarkImage.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(56)
            make.bottom.equalTo(self.snp.bottom).offset(-56)
        }
    
        
    }
    
    
    private func selectButton(){
      
        
        
    }
    
    @objc func didPress(_ sender: UIButton){
        print("press")
        isSelected = !isSelected
        let selfFrame = sender.frame
        if isSelected{
            
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.frame.size.width = 74
                self.frame.size.height = 74
                self.layer.cornerRadius = 37
                self.checkmarkImage.image = UIImage(named: "checkmark")
            }
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.frame.size.width = 64
                self.frame.size.height = 64
                self.backgroundColor = UIColor(named: "Gray 4")
                self.layer.cornerRadius = 32
                print(self.subviews)
                self.checkmarkImage.image = nil
                
            }
         
        }
      
        
    }

}
