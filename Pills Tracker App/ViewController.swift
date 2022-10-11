//
//  ViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/10/22.
//
import SnapKit
import UIKit

class ViewController: UIViewController {

    let greetingLabel = UILabel()
    let dateLabel = UILabel()
    let scrollView = UIScrollView()
    let planProgressView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
    }
    private func initialize(){
        greetingLabel.textColor = UIColor(named: "Gray 1")
        greetingLabel.textAlignment = .left
        greetingLabel.font = UIFont.systemFont(ofSize: 16)
        greetingLabel.text = "Have a great day!"
        view.addSubview(greetingLabel)
        
        greetingLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(view).offset(68)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-68)
        }
        
        dateLabel.textColor = UIColor(named: "Dark")
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.boldSystemFont(ofSize: 34)
        
        dateLabel.text = "Thursday"
        view.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(greetingLabel).offset(24)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-206)
        }
        
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 200, height: 750)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view)
        }
        let analyticsView = setupAnalyticsView()
        scrollView.addSubview(analyticsView)
        analyticsView.frame = CGRect(x: 30, y: 10, width: 327, height: 126)
        
    }
    
    
    


}

