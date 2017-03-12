//
//  MBMenuViewController.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/9/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

class MBMenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var slideInView: UIView!
    
    var stocks: [StockModel] = []
    
    var menuStocks: [MenuModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData ()
        // Do any additional setup after loading the view.
        setupTableView ()
        
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(#imageLiteral(resourceName: "MasterbeeTrensparent"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: searchButton)
        
        let cartButton = UIButton(type: .custom)
        cartButton.setImage(#imageLiteral(resourceName: "Bee_Trensperent"), for: .normal)
        cartButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: cartButton)
        
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(#imageLiteral(resourceName: "mb-logo-type6"), for: .normal)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menuButton.addTarget(self, action: #selector(self.slideInContent), for: .touchUpInside)
        let item3 = UIBarButtonItem(customView: menuButton)
        
        self.navigationItem.setRightBarButtonItems([item1, item2, item3], animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = true
        slideInView.isHidden = true
        slideInView.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideInContent() {
        slideInView.isHidden = false
        
        let transform = CATransform3DTranslate(CATransform3DIdentity, slideInView.frame.width, 0, 0)
        slideInView.layer.transform = transform
        
        UIView.animate(withDuration: 0.6) {
            self.slideInView.alpha = 1.0
            self.slideInView.layer.transform = CATransform3DIdentity
        }
    }

}

extension MBMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: MBStaticStrings.stockCellNibName, bundle: nil), forCellReuseIdentifier: MBStaticStrings.stockCelldentifier)
        
        menuTableView.rowHeight = UITableViewAutomaticDimension
        menuTableView.estimatedRowHeight = self.view.frame.width * 0.67
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(UINib(nibName: MBStaticStrings.simpleCellNibName, bundle: nil), forCellReuseIdentifier: MBStaticStrings.simpleCellIdentifier)
        contentTableView.register(UINib(nibName: MBStaticStrings.headerNibName, bundle: nil), forCellReuseIdentifier: MBStaticStrings.headerCellIdentifier)
        contentTableView.rowHeight = 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.contentTableView {
             return menuStocks[section].stocks.count
        }
        return stocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.contentTableView {
            let contentCell = tableView.dequeueReusableCell(withIdentifier: MBStaticStrings.simpleCellIdentifier) as! SimpleTableViewCell
            contentCell.cellLabel.text = menuStocks[indexPath.section].stocks[indexPath.row].name
            return contentCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MBStaticStrings.stockCelldentifier)! as! MenuStockTableViewCell
        
        if tableView == self.menuTableView {
            cell.stock = stocks[indexPath.row]
            return cell
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.contentTableView {
            return menuStocks.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.contentTableView {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: MBStaticStrings.headerCellIdentifier) as! HeaderTableViewCell
            headerCell.cellLabel.text = menuStocks[section].name
            return headerCell.contentView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

extension MBMenuViewController {
    
    func setupData() {
        if let path = Bundle.main.path(forResource: "Sample_Stock_Response", ofType: "json")
        {
            let jsonData = NSData(contentsOfFile: path)
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData as! Data, options: []) as! NSDictionary
                let response = json["response"] as! NSDictionary
                let stocksDict = response["stocks"] as! [NSDictionary]
                for stockDictionary in stocksDict {
                    
                    let stock = StockModel(dictionary: stockDictionary)
                    stocks.append(stock)
                    
                    let menus = stock.menus
                    if menus != nil {
                        for menu in menus! {
                            if let index = menuStocks.index(where: {$0.id == menu.id}) {
                                menuStocks[index].stocks.append(stock)
                            } else {
                                let newMenu = menu
                                newMenu.stocks.append(stock)
                                menuStocks.append(newMenu)
                            }
                        }
                    } else {
                        print("menus is nil")
                    }
                }
            } catch {
                print("Error")
            }
        }
    }
}
