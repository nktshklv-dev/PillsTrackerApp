//
//  AnalyticsView.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/11/22.
//

import Foundation
import UIKit

class AnalyticsView{
    var progressView = CircularProgressView()
    var progressLabel = UILabel()
    
    func setupAnalyticsView() -> UIView {
       
       let beginView = UIView()
       beginView.layer.cornerRadius = 24
       beginView.layer.borderColor = UIColor(named: "Gray 2")?.cgColor
        beginView.layer.borderWidth = 0.5
       
      
       let labelView = UILabel()
       beginView.addSubview(labelView)
       labelView.numberOfLines = 2
       labelView.textAlignment = .left
       labelView.text = "Your plan\nis almost done!"
       labelView.textColor = UIColor(named: "Dark")
       labelView.font = UIFont.boldSystemFont(ofSize: 24)
       labelView.frame.size.width = 177
       labelView.frame.size.height = 56
      
       labelView.snp.makeConstraints { make in
           make.top.equalTo(beginView.snp.top).offset(21)
           make.left.equalTo(beginView.snp.left).offset(24)
     
       }
       
       let hStack = UIStackView()
       hStack.axis = .horizontal
       hStack.spacing = 4
       let resultIcon = UIImageView()
       resultIcon.contentMode = .scaleAspectFit
       resultIcon.image = UIImage(named: "UpIcon")!
       hStack.addArrangedSubview(resultIcon)
       
       let detailedTextLabel = UILabel()
       detailedTextLabel.text = "13% than week ago"
       detailedTextLabel.font = UIFont.systemFont(ofSize: 16)
       detailedTextLabel.textColor = UIColor(named: "Gray 1")
       hStack.addArrangedSubview(detailedTextLabel)
       
       beginView.addSubview(hStack)
       hStack.snp.makeConstraints { make in
           make.top.equalTo(labelView.snp.bottomMargin).offset(10)
           make.left.equalTo(beginView.snp.left).offset(24)
       }
       
       
       progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 86, height: 86), lineWidth: 10, rounded: false)
       progressView.progressColor = UIColor(named: "Green")!
       progressView.trackColor = UIColor(named: "Green 2")!
        progressView.progress = 0.0
       beginView.addSubview(progressView)
       progressView.snp.makeConstraints { make in
           make.right.equalTo(beginView).offset(-110)
           make.top.equalTo(beginView.snp.top).offset(20)
       }
       
       progressLabel = UILabel()
       progressLabel.textColor = UIColor(named: "Green")!
       progressLabel.font = UIFont.boldSystemFont(ofSize: 20)
       progressLabel.text = "0%"
       progressView.addSubview(progressLabel)
       progressLabel.snp.makeConstraints { make in
           make.top.equalTo(progressView.snp.top).offset(31)
           
           make.center.equalTo(progressView.snp.center).offset(42)
           
       }
       
     
       return beginView
   }
    
    func setNewProgress(newProgress: Float){
        print(newProgress)
        let newValue = Int(newProgress * 100)
        progressView.progress = newProgress
        changeProgressLabelWithAnimation(newValue: newValue)
    }
    
    //MARK: - animated text updating?
    func changeProgressLabelWithAnimation(newValue: Int){
        guard let currentRawValue = (progressLabel.text)?.dropLast() else {return}
        guard var currentValue = Int(String(describing: currentRawValue)) else {return}
            if newValue > currentValue{
                while currentValue < newValue{
                        print("newValue: \(newValue), currentValue: \(currentValue)")
                        currentValue += 1
                        self.updateProgressLabel(with: currentValue)
                }
            }
            else {
                while currentValue > newValue{
                        currentValue -= 1
                        self.updateProgressLabel(with: currentValue)
                }
            }
       
        
    }
    
    func updateProgressLabel(with value: Int){
        print("updated to: \(value)")
        self.progressLabel.text = "\(value)%"
    }
    
   
}
 


