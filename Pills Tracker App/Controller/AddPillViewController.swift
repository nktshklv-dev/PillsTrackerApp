//
//  AddPillViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/18/22.
//

import UIKit
import SnapKit

class AddPillViewController: UIViewController {

    var selectedPicture: String = ""
    var selectedTabletName: String = ""
    var selectedTabletDose: String = ""
    var selectedTabletTimestamp: String = ""
    
    let timestamps: [TimestampsModel] = [TimestampsModel(title: "Nevermind", isSelected: true), TimestampsModel(title: "Before Meals", isSelected: false), TimestampsModel(title: "After Meals", isSelected: false), TimestampsModel(title: "With food", isSelected: false)]
    var collectionView: UICollectionView?
    var buttonsArray = [UIButton]()
    var nameTextField = UITextField()
    var doseTextField = UITextField()
    var nextScreenButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIButton()
        backButton.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "closeButton2"), for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.size.width / 2.60, height: view.frame.size.height / 15)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
        guard let collectionView = collectionView else {return}
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.bounces = true
        collectionView.frame = CGRect(x: 20, y: 450, width: 345, height: 100)
        initialise()

        
    }
    
    private func initialise(){
        let pageNumber = UILabel()
        pageNumber.text = "1 is 2"
        pageNumber.textColor = UIColor(named: "Gray 1")
        pageNumber.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(pageNumber)
        pageNumber.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(24)
            make.top.equalTo(view.snp.top).offset(100)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Add medication"
        titleLabel.textColor = UIColor(named: "Dark")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pageNumber.snp.bottom).offset(12)
            make.left.equalTo(pageNumber.snp.left)
        }
        //MARK: - Buttons
        let pillButton = CustomButton()
        pillButton.imageName = "pill"
        view.addSubview(pillButton)
        pillButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(23.5)
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
        }
        let capsuleButton = CustomButton()
        capsuleButton.imageName = "capsule"
        view.addSubview(capsuleButton)
        capsuleButton.snp.makeConstraints { make in
            make.left.equalTo(pillButton.snp.right).offset(24)
            make.top.equalTo(pillButton.snp.top)
        }
        let ampuleButton = CustomButton()
        ampuleButton.imageName = "ampule"
        view.addSubview(ampuleButton)
        ampuleButton.snp.makeConstraints { make in
            make.left.equalTo(capsuleButton.snp.right).offset(24)
            make.top.equalTo(pillButton.snp.top)
        }
        let ingButton = CustomButton()
        ingButton.imageName = "ing"
        view.addSubview(ingButton)
        ingButton.snp.makeConstraints { make in
            make.left.equalTo(ampuleButton.snp.right).offset(24)
            make.top.equalTo(pillButton.snp.top)
        }
        
        
        buttonsArray = [pillButton, capsuleButton, ampuleButton, ingButton]
        
        for button in buttonsArray {
            button.addTarget(self, action: #selector(deselectOtherButtons), for: .touchUpInside)
        }
        
        //MARK: - Text fields
        nameTextField = UITextField()
        nameTextField.font = UIFont.boldSystemFont(ofSize: 20)
        nameTextField.placeholder = "Name"
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(pillButton.snp.bottom).offset(45)
            make.left.equalTo(view).offset(24)
        }
        
        doseTextField = UITextField()
        doseTextField.font = UIFont.boldSystemFont(ofSize: 20)
        doseTextField.placeholder = "Single dose, e.g. 1 tablet"
        doseTextField.delegate = self
        view.addSubview(doseTextField)
        doseTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(44)
            make.left.equalTo(view).offset(24)
        }
        
        
        
        //MARK: - Collection View
        guard let collectionView = collectionView else {return}
        view.addSubview(collectionView)
        
        
        
        
        //MARK: - Next Screen Button
        nextScreenButton = UIButton()
        nextScreenButton.isUserInteractionEnabled = true
        nextScreenButton.setImage(UIImage(named: "disabledButton"), for: .normal)
        view.addSubview(nextScreenButton)
        nextScreenButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-44)
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
        nextScreenButton.addTarget(self, action: #selector(changeScreen), for: .touchUpInside)
        
        
       
        
        
        
        
    }
    
      
    @objc func deselectOtherButtons(_ sender: CustomButton){
        for button in buttonsArray{
            button.isSelected = false
            
        }
        selectedPicture = sender.imageName
        print("Selected Picture: " + selectedPicture)
        sender.isSelected = true
        areAllFieldsFilled()
    }
        
    @objc func closeVC(){
        navigationController?.popViewController(animated: true)
    }
    
}


//MARK: - Collection View Delegate and Collection View DataSource
extension AddPillViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timestamps.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.frame.size.height = 40
        cell.frame.size.width = 150
        
        let timestamp = timestamps[indexPath.row]
        cell.myLabel.text = timestamp.title
        if timestamp.isSelected{
            cell.changeState(isChosen: true)
        }
        else{
            cell.changeState(isChosen: false)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        areAllFieldsFilled()
        var recentSelectedItemId = 0
        for (id, item) in timestamps.enumerated(){
            if item.isSelected{
                recentSelectedItemId = id
            }
            else {
                continue
            }
        }
        
        if recentSelectedItemId == indexPath.row{
            return
        }
        else {
            timestamps[recentSelectedItemId].isSelected.toggle()
            timestamps[indexPath.row].isSelected.toggle()
        }
        selectedTabletTimestamp = timestamps[indexPath.row].title
        print(selectedTabletTimestamp)
        collectionView.reloadData()
    }
    
  //MARK: - areAllFieldsFilled
    func areAllFieldsFilled(){
       
        var isButtonSelected = false
        for button in buttonsArray{
            if button.isSelected{
                isButtonSelected = true
            }
        }
        var timestampIsSelected = false
        for timestamp in timestamps {
            if timestamp.isSelected{
                timestampIsSelected = true
            }
        }
        
        if isButtonSelected && nameTextField.text != "" && doseTextField.text != "" && timestampIsSelected{
            changeButtonStatus()
        }
       
            
    }
    
    
    func changeButtonStatus(){
        nextScreenButton.setImage(UIImage(named: "enabledButton"), for: .normal)
        nextScreenButton.isUserInteractionEnabled = true
    }
    
    
    @objc func changeScreen(){
        performSegue(withIdentifier: "toThirdScreen", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdScreen"{
            guard let destination = segue.destination as? SecondAddPillViewController else {return}
            
            destination.selectedPicture = self.selectedPicture
            destination.selectedTabletName = self.selectedTabletName
            destination.selectedTabletDose = self.selectedTabletDose
            destination.selectedTabletTimestamp = self.selectedTabletTimestamp
        }
    }
    
}

//MARK: - TextField Delegate Methods
extension AddPillViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text == ""{
            return
        }
        else {
            if textField.placeholder! == "Name"{
                selectedTabletName = textField.text!
                print(selectedTabletName)
            }
            else {
                selectedTabletDose = textField.text!
                print(selectedTabletDose)
            }
        }
        
        areAllFieldsFilled()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            return false
        }
        else {
            if textField.placeholder! == "Name"{
                selectedTabletName = textField.text!
                print(selectedTabletName)
            }
            else {
                selectedTabletDose = textField.text!
                print(selectedTabletDose)
            }
        }
      
        areAllFieldsFilled()
        return true
    }
}
