//
//  SecondAddPillViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/18/22.
//

import UIKit
import CoreData
import UserNotifications

//TODO: implement "remind in..." functional

class SecondAddPillViewController: UIViewController {
    
    //CoreData context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //CoreData prop-s
    
    var tabletId: String?
    var selectedPicture: String = ""
    var selectedTabletName: String = ""
    var selectedTabletDose: String = ""
    var selectedTabletTimestamp: String = ""
    var tabletDescription = ""
    var pill = Pill()
    
    //UI prop-s
    var numberOfFields = 0
    var datePicker = UIDatePicker()
    var timeTextField: UITextField!
    var stackView = UIStackView()
    var timestampCount = 0
    var addButton = UIButton()
    var timestamps = [Int: Date]()
    var switcher = UISwitch()
    var buttonsArray = [UIButton]()
    var reminderStackView = UIStackView()
    var bottomButton = UIButton()
    var remindInTime = 0
    var textFields = [Int: UITextField]()
    var notificationContent: UNMutableNotificationContent!
    override func viewDidLoad() {
        super.viewDidLoad()
        //UNMutableNotificationContent
        notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Hey!"
        notificationContent.body = "It's time to take your medication!"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        
        
        
        
        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        tabletDescription = selectedTabletDose + " " + selectedTabletTimestamp
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "closeButton2"), for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        print("------")
        print(selectedPicture)
        print(selectedTabletDose)
        print(selectedTabletName)
        print(selectedTabletTimestamp)
        initialise()
    }
    //MARK: - previousVC
    @objc func previousVC(){
        navigationController?.popViewController(animated: true)
    }
    //MARK: - closeVC
    @objc func closeVC(){
        navigationController?.popToRootViewController(animated: true)
    }
    //MARK: - initialise!
    func initialise(){
        tabletId = UUID().uuidString
        
        let pageNumberLabel = UILabel()
        pageNumberLabel.text = "2 is 2"
        pageNumberLabel.font = UIFont.systemFont(ofSize: 16)
        pageNumberLabel.textColor = UIColor(named: "Gray 1")
        view.addSubview(pageNumberLabel)
        pageNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(24)
            make.top.equalTo(view.snp.top).offset(100)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Schedule"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.textColor = UIColor(named: "Dark")
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(pageNumberLabel)
            make.top.equalTo(pageNumberLabel.snp.bottom).offset(12)
        }
        
        let rectangleView = UIImageView()
        rectangleView.image = UIImage(named: "rectangle")
        view.addSubview(rectangleView)
        rectangleView.snp.makeConstraints { make in
            make.left.equalTo(pageNumberLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
        }
        
        let tabletName = UILabel()
        tabletName.text = selectedTabletName
        tabletName.font = UIFont.boldSystemFont(ofSize: 20)
        tabletName.textColor = UIColor(named: "Dark")
        view.addSubview(tabletName)
        tabletName.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.equalTo(view.snp.left).offset(109)
        }
        
        let additionalTextLabel = UILabel()
        let text = selectedTabletDose + " " + selectedTabletTimestamp
        print(text)
        additionalTextLabel.text = text.lowercased()
        additionalTextLabel.font = UIFont.systemFont(ofSize: 16)
        additionalTextLabel.textColor = UIColor(named: "Gray 1")
        view.addSubview(additionalTextLabel)
        additionalTextLabel.snp.makeConstraints { make in
            make.top.equalTo(tabletName.snp.bottom).offset(8)
            make.left.equalTo(tabletName)
        }
        
        getImageView(for: selectedPicture)
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(rectangleView.snp.bottom).offset(50)
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
        
        addButton = UIButton()
        addButton.setImage(UIImage(named: "addButton2"), for: .normal)
        addButton.addTarget(self, action: #selector(addTimestamp), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(15)
            make.left.equalTo(stackView)
        }
        
        
        createDoseTimeView()
        
        
        let remindersTitle = UILabel()
        remindersTitle.text = "Reminders"
        remindersTitle.font = UIFont.boldSystemFont(ofSize: 20)
        remindersTitle.textColor = UIColor(named: "Dark")
        
        
        
        switcher = UISwitch()
        switcher.isOn = false
        switcher.onTintColor = UIColor(named: "Gray 4")
        switcher.thumbTintColor = UIColor(named: "Gray 1")
        switcher.addTarget(self, action: #selector(didTapswitcher), for: .touchUpInside)
        
        
        reminderStackView = UIStackView()
        reminderStackView.axis = .vertical
        reminderStackView.alignment = .fill
        reminderStackView.spacing = 32
        view.addSubview(reminderStackView)
        
        reminderStackView.snp.makeConstraints { make in make.left.equalTo(addButton)
            make.top.equalTo(titleLabel.snp.bottom).offset(330)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
        }
        
        
        reminderStackView.addArrangedSubview(remindersTitle)
        reminderStackView.addSubview(switcher)
        
        switcher.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-24)
            make.top.equalTo(titleLabel.snp.bottom).offset(326)
        }
        let minutesView = getMinutesView()
        reminderStackView.addArrangedSubview(minutesView)
        reminderStackView.arrangedSubviews[1].isHidden = true
        self.reminderStackView.arrangedSubviews[1].layer.opacity = 0
        
        bottomButton = UIButton()
        bottomButton.setImage(UIImage(named: "addMedicationTimesButton"), for: .normal)
        bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        bottomButton.isUserInteractionEnabled = false
        view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-44)
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
        
        
        
        
        
        
        
    }
    
    
    
    //MARK: - add doseTimeView
    @objc func addTimestamp(){
        guard var prevTextField = textFields[numberOfFields] else {return}
        if prevTextField.text?.isEmpty == true {
            let ac = UIAlertController(title: "Please, set the current timestamp!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        if timestampCount > 0 {
            addButton.isHidden = true
        }
        let horStack = UIStackView()
        horStack.axis = .horizontal
        horStack.spacing = 208
        let label = UILabel()
        label.text = "Dose \(timestampCount + 2)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "Dark")
        
        var timeTextField = UITextField()
        timeTextField.isUserInteractionEnabled = true
        timeTextField.tag = numberOfFields
        timeTextField.textColor = UIColor(named: "Dark")
        timeTextField.font = UIFont.boldSystemFont(ofSize: 20)
        timeTextField.placeholder = "00:00"
        timeTextField.inputView = datePicker
        numberOfFields += 1
        timeTextField.tag = numberOfFields
        textFields[numberOfFields] = timeTextField
        
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        done.tag = numberOfFields
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexibleSpace, done], animated: true)
        
        timeTextField.inputAccessoryView = toolbar
        
        horStack.addArrangedSubview(label)
        horStack.addArrangedSubview(timeTextField)
        
        stackView.addArrangedSubview(horStack)
        
        timestampCount += 1
        
    }
    //MARK: - didTapBottomButton
    @objc func didTapBottomButton(){
        createPillObject()
        for (number, date) in timestamps.enumerated(){
            guard var currDate = timestamps[number] else {return}
            createLocalNotification(date: currDate)
        }
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    //MARK: - didTapswitcher
    @objc func didTapswitcher(_ sender: UISwitch){
        
        print("didTapswitcher, \(sender.isOn)")
        if sender.isOn{
            sender.thumbTintColor = UIColor(named: "Blue")
            
        }
        else {
            sender.thumbTintColor = UIColor(named: "Gray 1")
            
        }
        UIView.animate(withDuration: 0.5 , delay: 0) {
            if sender.isOn{
                self.reminderStackView.arrangedSubviews[1].isHidden = false
                self.reminderStackView.arrangedSubviews[1].layer.opacity = 1
                
            }
            else {
                self.reminderStackView.arrangedSubviews[1].isHidden = true
                self.reminderStackView.arrangedSubviews[1].layer.opacity = 0
            }
        }
    }
    
    
    //MARK: - getImageView
    func getImageView(for selectedPicture: String){
        let imageView = UIImageView(image: UIImage(named: selectedPicture))
        view.addSubview(imageView)
        
        switch selectedPicture{
        case "capsule":
            imageView.snp.makeConstraints { make in
                make.top.equalTo(view).offset(201.74)
                make.left.equalTo(view).offset(23.87)
            }
            break
        case "pill":
            imageView.snp.makeConstraints { make in
                make.top.equalTo(view).offset(205.74)
                make.left.equalTo(view).offset(27.87)
            }
            break
        case "ampule":
            imageView.snp.makeConstraints { make in
                make.top.equalTo(view).offset(214.74)
                make.left.equalTo(view).offset(30.87)
            }
            break
        case "ing":
            imageView.snp.makeConstraints { make in
                make.top.equalTo(view).offset(222.74)
                make.left.equalTo(view).offset(47.87)
            }
            break
            
        default:
            print("def")
            
        }
        
        
        print(selectedPicture)
    }
    
    //MARK: - createDoseTimeView
    func createDoseTimeView(){
        let horStack = UIStackView()
        horStack.axis = .horizontal
        horStack.spacing = 208
        let label = UILabel()
        label.text = "Dose \(1)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "Dark")
        
        let timeTextField = UITextField()
        timeTextField.textColor = UIColor(named: "Dark")
        timeTextField.font = UIFont.boldSystemFont(ofSize: 20)
        timeTextField.placeholder = "00:00"
        timeTextField.tag = numberOfFields
        timeTextField.inputView = datePicker
        textFields[numberOfFields] = timeTextField
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.timeZone = NSTimeZone.local
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        done.tag = numberOfFields
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexibleSpace, done], animated: true)
        
        timeTextField.inputAccessoryView = toolbar
        
        horStack.addArrangedSubview(label)
        horStack.addArrangedSubview(timeTextField)
        
        stackView.addArrangedSubview(horStack)
    }
    //MARK: - doneAction
    @objc func doneAction(_ sender: UIBarButtonItem){
        getDateFromPicker(sender.tag)
        print(sender.tag)
        checkFields()
        if timestampCount > 1 {
            addButton.isHidden = true
        }
        view.endEditing(true)
    }
    
    //MARK: - getDateFromPicker
    func getDateFromPicker(_ senderTag: Int){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        datePicker.timeZone = NSTimeZone.system
        let date = datePicker.date
        
        guard let textField = textFields[senderTag] else {print("no"); return }
        textField.text = formatter.string(from: datePicker.date)
        timestamps[textField.tag] = date
        print(timestamps)
    }
    
    //MARK: - createLocalNotification
    func createLocalNotification(date: Date){
        guard let newDate = subtractMinutes(from: date, minutes: remindInTime) else {return}
        let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
        print("newDate components: \(components.hour), \(components.minute)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let id = tabletId!
        let request = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        print(timestamps)
    }
    
    //MARK: - getMinutesView
    func getMinutesView() -> UIStackView{
        let returnStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 327, height: 24))
        returnStack.axis = .horizontal
        returnStack.distribution = .equalSpacing
        returnStack.spacing = 24
        
        let button5min = UIButton(frame: CGRect(x: 0, y: 0, width: 53, height: 24))
        button5min.setTitle("in 5 m", for: .normal)
        button5min.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
        button5min.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button5min.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        
        let button10min = UIButton(frame: CGRect(x: 0, y: 0, width: 43, height: 24))
        button10min.setTitle("10 m", for: .normal)
        button10min.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
        button10min.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button10min.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        
        let button15min = UIButton(frame: CGRect(x: 0, y: 0, width: 43, height: 24))
        button15min.setTitle("15 m", for: .normal)
        button15min.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
        button15min.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button15min.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        
        let button20min = UIButton(frame: CGRect(x: 0, y: 0, width: 43, height: 24))
        button20min.setTitle("20 m", for: .normal)
        button20min.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
        button20min.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button20min.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        
        let button30min = UIButton(frame: CGRect(x: 0, y: 0, width: 43, height: 24))
        button30min.setTitle("30 m", for: .normal)
        button30min.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
        button30min.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button30min.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        
        
        buttonsArray.append(contentsOf: [button5min, button10min, button15min, button20min, button30min])
        returnStack.alignment = .fill
        returnStack.addArrangedSubview(button5min)
        returnStack.addArrangedSubview(button10min)
        returnStack.addArrangedSubview(button15min)
        returnStack.addArrangedSubview(button20min)
        returnStack.addArrangedSubview(button30min)
        
        
        
        
        return returnStack
    }
    
    //MARK: - didTapTimeButton
    @objc func didTapTimeButton(_ sender: UIButton){
        UIView.animate(withDuration: 0.2, delay: 0) {
            for button in self.buttonsArray {
                button.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
            }
            if sender.titleColor(for: .normal) == UIColor(named: "Dark"){
                sender.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
                
            }
            else {
                sender.setTitleColor(UIColor(named: "Dark"), for: .normal)
                var text = sender.titleLabel?.text
                switch text{
                case "in 5 m":
                    self.remindInTime = 5
                    break
                case "10 m":
                    self.remindInTime = 10
                    break
                case "15 m":
                    self.remindInTime = 15
                    break
                case "20 m":
                    self.remindInTime = 20
                    break
                case "30 m":
                    self.remindInTime = 30
                    break
                default:
                    self.remindInTime = 0
                    break
                    
                    
                }
                print("Remind time: ", self.remindInTime)
                
                
            }
        }
        
        
        checkFields()
        
    }
    
    
    //MARK: - checkFields
    func checkFields(){
        guard !selectedPicture.isEmpty else {return}
        guard !selectedTabletName.isEmpty else {return}
        guard !selectedTabletDose.isEmpty else {return}
        guard !selectedTabletTimestamp.isEmpty else {return}
        guard !timestamps.isEmpty else {return}
        
        bottomButton.isUserInteractionEnabled = true
        bottomButton.setImage(UIImage(named: "doneButton"), for: .normal)
        
    }
    //MARK: - createPillObject
    func createPillObject(){
        let newPill = Pill(context: context)
        newPill.tabletName = selectedTabletName
        newPill.tabletDescription = tabletDescription
        newPill.imageName = selectedPicture
        newPill.id = tabletId
        
        do{
            try self.context.save()
        }
        catch{
            let ac = UIAlertController(title: "Failed to save pill", message: "Please try again!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
            print(error.localizedDescription)
        }
    }
    func subtractMinutes(from date: Date, minutes: Int) -> Date?{
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: -minutes, to: date)!
        print("Raw Date: \(date), Minutes: \(minutes), Modified Date: \(modifiedDate)")
        return modifiedDate
    }
}

 


