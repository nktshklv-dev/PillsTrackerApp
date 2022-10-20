//
//  CustomButton.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/21/22.
//

import UIKit

class CustomButton: UIButton {
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
       
    }
    
}
