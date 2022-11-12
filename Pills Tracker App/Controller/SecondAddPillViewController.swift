//
//  SecondAddPillViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/18/22.
//

import UIKit

class SecondAddPillViewController: UIViewController {
    
    var selectedPicture: String = ""
    var selectedTabletName: String = ""
    var selectedTabletDose: String = ""
    var selectedTabletTimestamp: String = ""
    
    var datePicker = UIDatePicker()
    var timeTextField = UITextField()
    var stackView = UIStackView()
    var timestampCount = 0
    var addButton = UIButton()
    var timestamps = [String]()
    var switcher = UISwitch()
    var buttonsArray = [UIButton]()
    var reminderStackView = UIStackView()
    var bottomButton = UIButton()
    var remindTime = ""
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let backButton = UIButton()
            backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
            backButton.setImage(UIImage(named: "backButton"), for: .normal)
            backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
            
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
            switcher.thumbTintColor = UIColor(named: "Blue")
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
            let stack = getMinutesView()
            reminderStackView.addArrangedSubview(stack)
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
    
    //TODO: - refactore code!!! using new var (Dict)
    
    //MARK: - addTimestamp
    @objc func addTimestamp(){
        if timestampCount > 1 {
            let ac = UIAlertController(title: "You can't add more than 3 timestamps with free subscription!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            addButton.isHidden = true
            return
        }
        
        let horStack = UIStackView()
        horStack.axis = .horizontal
        horStack.spacing = 208
        let label = UILabel()
        label.text = "Dose \(timestampCount + 2)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "Dark")
        
        timeTextField = UITextField()
        timeTextField.textColor = UIColor(named: "Dark")
        timeTextField.font = UIFont.boldSystemFont(ofSize: 20)
        timeTextField.placeholder = "00:00"
        timeTextField.inputView = datePicker
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
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
        navigationController?.popToRootViewController(animated: true)
        
    }
    //MARK: - didTapswitcher
    @objc func didTapswitcher(_ sender: UISwitch){
        
        print("didTapswitcher, \(sender.isOn)")
        
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
                
                timeTextField = UITextField()
                timeTextField.textColor = UIColor(named: "Dark")
                timeTextField.font = UIFont.boldSystemFont(ofSize: 20)
                timeTextField.placeholder = "00:00"
                timeTextField.inputView = datePicker
                
                datePicker.datePickerMode = .time
                datePicker.preferredDatePickerStyle = .wheels
                datePicker.timeZone = NSTimeZone.local
                
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
                let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                toolbar.setItems([flexibleSpace, done], animated: true)
                
                timeTextField.inputAccessoryView = toolbar
                
                horStack.addArrangedSubview(label)
                horStack.addArrangedSubview(timeTextField)
                
                stackView.addArrangedSubview(horStack)
        }
        //MARK: - doneAction
        @objc func doneAction(){
            getDateFromPicker()
            checkFields()
            view.endEditing(true)
        }
        
        //MARK: - getDateFromPicker
        func getDateFromPicker(){
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            datePicker.timeZone = NSTimeZone.local
            timeTextField.text = formatter.string(from: datePicker.date)
            timestamps.append(formatter.string(from: datePicker.date))
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
        for button in buttonsArray {
            button.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
        }
        if sender.titleColor(for: .normal) == UIColor(named: "Dark"){
            sender.setTitleColor(UIColor(named: "Gray 2"), for: .normal)
            
        }
        else {
            sender.setTitleColor(UIColor(named: "Dark"), for: .normal)
            remindTime = sender.titleLabel!.text!
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
        
    
}

    

