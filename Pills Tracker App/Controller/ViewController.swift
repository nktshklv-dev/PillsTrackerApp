//
//  ViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/10/22.
//
import SnapKit
import UIKit
import UserNotifications

class ViewController: UIViewController {

    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var tableView: UITableView!
    
    
    var savedPills = [Pill]()
    
    let greetingLabel = UILabel()
    let dateLabel = UILabel()
    let planProgressView = UIView()
    var dayOfWeek: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
        
        
        initialize()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        fetchRequest()
        print(Date().dayOfWeek())
        print(Date().dayNumberOfWeek())
        dayOfWeek = Date().dayOfWeek()
        title = dayOfWeek
       
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
        tableView.reloadData()
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
        
        
        dateLabel.text = dayOfWeek
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
    
    //MARK: - didTapAddButton
    @objc func didTapAddButton(){
        performSegue(withIdentifier: "toSecondScreen", sender: self)
    }
}
    //MARK: - UITableViewDataSource methods
extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPills.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let currentPill = savedPills[indexPath.row]
        let name = currentPill.tabletName ?? "New Cell"
        let description = currentPill.tabletDescription ?? "no data"
        let imageName = currentPill.imageName ?? "pill"
        
        cell.configure(name: name , description: description, imageName: imageName)
        return cell
    
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
   
    
    
    
    func fetchRequest(){
        do{
            self.savedPills = try context.fetch(Pill.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.savedPills)
            }
        }catch{
            let ac = UIAlertController(title: "Failed to fetch pills!", message: "Please, try agin!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
            print(error.localizedDescription)
            fatalError()
        }
        
    }
}
extension ViewController{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            _,_,_ in
            self.context.delete(self.savedPills[indexPath.row])
            do{
                try self.context.save()
            }
            catch{
                let ac = UIAlertController(title: "Failed to remove pill", message: "Please try again!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(ac, animated: true)
                print(error.localizedDescription)
            }
            self.fetchRequest()
        }
        
        let action = UISwipeActionsConfiguration(actions: [deleteAction])
        return action
    }
}


extension Date {
    func dayOfWeek() -> String {
        var dayNum = Date().dayNumberOfWeek()!
        var dateToReturn = ""
        switch dayNum{
        case 1:
            dateToReturn = "Sunday"
        case 2:
            dateToReturn = "Monday"
        case 3:
            dateToReturn = "Tuesday"
        case 4:
            dateToReturn = "Wednesday"
        case 5:
            dateToReturn = "Tuesday"
        case 6:
            dateToReturn = "Friday"
        case 7:
            dateToReturn = "Saturday"
        default:
            dateToReturn = "Monday"
        }
        return dateToReturn
      
    }
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
        }
}



