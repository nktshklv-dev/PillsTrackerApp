//
//  AnalyticsView.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/11/22.
//

import Foundation
import UIKit

 func setupAnalyticsView() -> UIView{
    
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
    
    
    let progressBar = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 86, height: 86), lineWidth: 10, rounded: false)
    progressBar.progressColor = UIColor(named: "Green")!
    progressBar.trackColor = UIColor(named: "Green 2")!
    progressBar.progress = 0.78
    beginView.addSubview(progressBar)
    progressBar.snp.makeConstraints { make in
        make.right.equalTo(beginView).offset(-110)
        make.top.equalTo(beginView.snp.top).offset(20)
    }
    
    let progressLabel = UILabel()
    progressLabel.textColor = UIColor(named: "Green")!
    progressLabel.font = UIFont.boldSystemFont(ofSize: 20)
    progressLabel.text = "78%"
    progressBar.addSubview(progressLabel)
    progressLabel.snp.makeConstraints { make in
        make.top.equalTo(progressBar.snp.top).offset(30)
        make.left.equalTo(progressBar.snp.left).offset(22)
    }
    
  
    return beginView
    
}


