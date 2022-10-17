//
//  ViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/10/22.
//
import SnapKit
import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var tableView: UITableView!
    
    let greetingLabel = UILabel()
    let dateLabel = UILabel()
    let planProgressView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
       
      
        
    }
    //MARK: - View init
    private func initialize(){
        greetingLabel.textColor = UIColor(named: "Gray 1")
        greetingLabel.textAlignment = .left
        greetingLabel.font = UIFont.systemFont(ofSize: 16)
        greetingLabel.text = "Have a great day!"
        view.addSubview(greetingLabel)
        
     
        
        
        dateLabel.textColor = UIColor(named: "Dark")
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.boldSystemFont(ofSize: 34)
        
        
        dateLabel.text = "Thursday"
        view.addSubview(dateLabel)
        
        let screenHeaderView = UIView(frame: CGRect(x: 0, y: -50, width: 400, height: 100))
        screenHeaderView.addSubview(greetingLabel)
        screenHeaderView.addSubview(dateLabel)
        
        greetingLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(screenHeaderView).offset(68)
            make.left.equalTo(screenHeaderView).offset(24)
            make.right.equalTo(screenHeaderView).offset(-68)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(greetingLabel).offset(24)
            make.left.equalTo(screenHeaderView).offset(24)
            make.right.equalTo(screenHeaderView).offset(-206)
        }
        
//        view.addSubview(screenHeaderView)
      
        
        

        let analyticsView = setupAnalyticsView()
        view.addSubview(analyticsView)
        analyticsView.frame = CGRect(x: 30, y: 0, width: 327, height: 126)
        
        let getVaccinatedView = createGetVaccinatedview()
        view.addSubview(getVaccinatedView)
        getVaccinatedView.frame = CGRect(x: 30, y: 135, width: 327, height: 101)
        
        let finalView = UIView(frame: CGRect(x: 0, y: 0, width: 327, height: 255))
        finalView.addSubview(analyticsView)
        finalView.addSubview(getVaccinatedView)
        
        
        tableView.tableHeaderView = finalView
        
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "roundButton"), for: .normal)
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-16)
            make.bottom.equalTo(view.snp.bottom).offset(-32)
        }
       
    }
    
    
    //MARK: - VC code
    
    @objc func didTapAddButton(){
        performSegue(withIdentifier: "toSecondScreen", sender: self)
        
    }
    
    
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 60))
            let textView = UILabel()
            textView.text = "8:00"
            textView.textColor = UIColor(named: "Dark")
            textView.font = UIFont.boldSystemFont(ofSize: 18)
            view.addSubview(textView)
            textView.snp.makeConstraints { make in
                make.left.equalTo(view.snp.left).offset(30)
                make.top.bottom.equalTo(view)
            }
            view.backgroundColor = .white
            return view
        }
        else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 60))
            let textView = UILabel()
            textView.text = "18:00"
            textView.textColor = UIColor(named: "Dark")
            textView.font = UIFont.boldSystemFont(ofSize: 18)
            view.addSubview(textView)
            textView.snp.makeConstraints { make in
                make.left.equalTo(view.snp.left).offset(30)
                make.top.bottom.equalTo(view)
            }
            view.backgroundColor = .white
            return view
        }
        
       
        
        
    }
   
}




