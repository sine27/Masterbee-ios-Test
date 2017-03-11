//
//  MBOrderTypeViewController.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/9/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

let timespans = ["12:00 - 13:00", "13:00 - 14:00", "18:00 - 20:00"]
let locations = ["Purdue Memorial Union", "Windsor Halls", "The Cottages on Lindberg"]

class MBOrderTypeViewController: UIViewController {

    /** Outlet Field */
    @IBOutlet weak var scheduledGroupDeliveryTableView: UITableView!
    
    @IBOutlet weak var eatnowButton: UIButton!
    
    @IBOutlet weak var pickupButton: UIButton!
    
    @IBOutlet weak var scheduleButton: UIButton!
    
    @IBOutlet weak var datePickerButton: UIButton!
    
    @IBOutlet weak var datePicker: UIPickerView!
    
    /** variable Field */
    
    // Strings
    var eatnowButtonTitle = "Eat Now"
    var pickupButtonTitle = "Pick Up"
    var scheduledButtonTitled = "Scheduled Group Delivery"
    
    // static
    /// should move this field to some helper class, and change MBOrderTypeViewController.xxx to SomeHelperClass.xxx
    static let timespanHeaderString = "timespanHeader"
    static let timespanHeaderNibNameString = "TimeSpanHeaderTableViewCell"
    static let locationCellString = "locationCell"
    static let locationTableViewCellString = "LocationTableViewCell"
    
    // index
    var isPickerViewHidden = true
    
    var dateRowSelected = 0
    
    let calendar = Calendar.current
    
    var dateArray: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view setup
        setupTableView ()
        
        // picker view setup
        setupPickerView ()
        
        datePickerButton.setTitle(dateArray[dateRowSelected].dateToString(type: 4), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension MBOrderTypeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView () {
        scheduledGroupDeliveryTableView.delegate = self
        scheduledGroupDeliveryTableView.dataSource = self
        scheduledGroupDeliveryTableView.register(UINib(nibName: MBOrderTypeViewController.timespanHeaderNibNameString, bundle: nil), forCellReuseIdentifier: MBOrderTypeViewController.timespanHeaderString)
        scheduledGroupDeliveryTableView.register(UINib(nibName: MBOrderTypeViewController.locationTableViewCellString, bundle: nil), forCellReuseIdentifier: MBOrderTypeViewController.locationCellString)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MBOrderTypeViewController.locationCellString) as! LocationTableViewCell
        cell.locationNameLabel.text = locations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return timespans.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        for i in 0...timespans.count {
            if section == i {
                let headerCell = tableView.dequeueReusableCell(withIdentifier: MBOrderTypeViewController.timespanHeaderString) as! TimeSpanHeaderTableViewCell
                headerCell.timeSpanLabel.text = timespans[i]
                return headerCell.contentView
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

extension MBOrderTypeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func setupPickerView () {
        
        let dateToday = Date()
        for i in 0...6 {
            let newDate = calendar.date(byAdding: .day, value: i, to: dateToday)
            dateArray.append(newDate!)
        }
        
        datePicker.dataSource = self
        datePicker.delegate = self
        datePicker.backgroundColor = UIColor.mbYellow
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.layer.borderWidth = 0.3
        datePicker.layer.borderColor = UIColor.lightGray.cgColor
        
        datePicker.isHidden = true
        datePicker.alpha = 0.0
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateArray.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dateArray[row].dateToString(type: 4)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateRowSelected = row
        datePickerButton.setTitle(dateArray[row].dateToString(type: 5), for: .normal)
    }
    
    @IBAction func datePickerButtonTapped(_ sender: UIButton) {
        
        isPickerViewHidden = !isPickerViewHidden
        
        if !isPickerViewHidden {
            datePicker.isHidden = isPickerViewHidden
            let transform = CATransform3DTranslate(CATransform3DIdentity, 0, self.view.frame.height * 0.3, 0)
            datePicker.layer.transform = transform
            
            UIView.animate(withDuration: 0.6) {
                self.datePicker.alpha = 1.0
                self.datePicker.layer.transform = CATransform3DIdentity
            }
        }
        
        else {
            UIView.animate(withDuration: 0.6, animations: { 
                self.datePicker.alpha = 0.0
            }, completion: { (done) in
                self.datePicker.isHidden = self.isPickerViewHidden
            })
        }
    }
}

extension MBOrderTypeViewController {
    
    func initializeUIData (/** request data */) {
        // Button titles
        eatnowButton.setTitle("1", for: .normal)
        pickupButton.setTitle("2", for: .normal)
        scheduleButton.setTitle("3", for: .normal)
        
        scheduledGroupDeliveryTableView.reloadData()
    }
    
}
    
