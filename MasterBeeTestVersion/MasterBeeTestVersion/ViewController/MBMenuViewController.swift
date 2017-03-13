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
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var LocationImageView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    var stocks: [StockModel] = []
    var menuStocks: [MenuModel] = []
    
    /** 
     Type 0: Eat now
     Type 1: Pick up
     Type 2: Scheduled group delivery
     */
    var orderType = 0
    
    var isSlideViewHidden = true
    
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData ()
        // Do any additional setup after loading the view.
        setupTableView ()
        
        setupHeaderView ()
        
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(#imageLiteral(resourceName: "mb-logo-type6"), for: .normal)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menuButton.addTarget(self, action: #selector(self.slideInContent), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: menuButton)
        
        let cartButton = UIButton(type: .custom)
        cartButton.setImage(#imageLiteral(resourceName: "Bee_Trensperent"), for: .normal)
        cartButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: cartButton)
        
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(#imageLiteral(resourceName: "MasterbeeTrensparent"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
        let item3 = UIBarButtonItem(customView: searchButton)
        
        self.navigationItem.setRightBarButtonItems([item1, item2, item3], animated: true)
        
    }
    
    func setupHeaderView() {
        locationView.setNeedsLayout()
        locationView.layoutIfNeeded()
        
        locationLabel.text = "Purdue Memorial Union"
        
        let height = locationView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = locationView.frame
        frame.size.height = height
        locationView.frame = frame
        
        menuTableView.tableHeaderView = locationView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = true
        slideInView.isHidden = true
        isSlideViewHidden = true
        blurView.isHidden = true
        blurView.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideInContent() {

        if isSlideViewHidden {
            slideInView.isHidden = false
            blurView.isHidden = false
            self.slideInView.frame.origin.x = -self.slideInView.frame.width
            UIView.animate(withDuration: 0.6, animations: {
                self.blurView.alpha = 1.0
                self.slideInView.frame.origin.x = 0
            }, completion: { (completed) in
                self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.slideInContent))
                self.blurView.addGestureRecognizer(self.tapGesture)
            })
        }
        else {
            UIView.animate(withDuration: 0.6, animations: {
                self.blurView.alpha = 0.0
                self.slideInView.frame.origin.x = -self.slideInView.frame.width
            }, completion: { (completed) in
                self.slideInView.isHidden = true
                self.blurView.isHidden = true
            })
        }
        isSlideViewHidden = !isSlideViewHidden
    }

}

extension MBMenuViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func setupTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: MBStaticStrings.stockCellNibName, bundle: nil), forCellReuseIdentifier: MBStaticStrings.stockCelldentifier)
        menuTableView.register(UINib(nibName: MBStaticStrings.menuHeaderCellNibName, bundle: nil), forCellReuseIdentifier: MBStaticStrings.menuHeaderCellIdentifier)
        
        menuTableView.rowHeight = UITableViewAutomaticDimension
        menuTableView.estimatedRowHeight = self.view.frame.width * 0.66
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.allowsMultipleSelection = false
        contentTableView.register(UINib(nibName: MBStaticStrings.simpleCellNibName, bundle: nil), forCellReuseIdentifier: MBStaticStrings.simpleCellIdentifier)
        contentTableView.register(UINib(nibName: MBStaticStrings.headerCellNibName, bundle: nil), forCellReuseIdentifier: MBStaticStrings.headerCellIdentifier)
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
        
        if tableView == self.menuTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: MBStaticStrings.stockCelldentifier)! as! MenuStockTableViewCell
            cell.stock = stocks[indexPath.row]
            return cell
        }
        
        return tableView.cellForRow(at: indexPath)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.contentTableView {
            return menuStocks.count
        }
        /** menu table has 1 section only */
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /** section header view in content table */
        if tableView == self.contentTableView {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: MBStaticStrings.headerCellIdentifier) as! HeaderTableViewCell
            headerCell.cellLabel.text = menuStocks[section].name
            return headerCell.contentView
        }
        /** header view in menu table */
        if tableView == self.menuTableView {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: MBStaticStrings.menuHeaderCellIdentifier) as! MenuHeaderTableViewCell
            headerCell.cellLabel.text = "Mar 11 [20:00 - 21:00]"
            headerCell.cellLabelRight.text = "Order now to earn 1314 credits!"
            return headerCell.contentView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.contentTableView {
            return 20
        }
        if tableView == self.menuTableView {
            return 21
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /** select a cell in content table will automatically scoll menu table to index at product you selected */
        if tableView == self.contentTableView {
            if let indexPathAt = menuStocks[indexPath.section].stocks[indexPath.row].rowAt {
                self.menuTableView.scrollToRow(at: indexPathAt, at: .top, animated: true)
                self.slideInContent()
            } else {
                /* check setupData() method, the indexPath is not assigned correctly */
                print("No indexPath in stock model")
            }
        }
    }
    
    /** 
     hightlight current index: The contentTable scrolls when menuTable scrolled. This functionality should be disabled if you want to do multi menus for one product.
     StockMenu.indexPathAt need change
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.menuTableView {
            let firstVisibleCell = menuTableView.visibleCells.first as! MenuStockTableViewCell
            if let indexPathAt = firstVisibleCell.stock.indexPathAt {
                self.contentTableView.selectRow(at: indexPathAt, animated: true, scrollPosition: .top)
            } else {
                print("No index")
            }
        }
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
                    stock.rowAt = IndexPath(row: stocks.count, section: 0)
                    stocks.append(stock)
                    
                    let menus = stock.menus
                    if menus != nil {
                        for menu in menus! {
                            if let index = menuStocks.index(where: {$0.id == menu.id}) {
                                stock.indexPathAt = IndexPath(row: menuStocks[index].stocks.count, section: index)
                                menuStocks[index].stocks.append(stock)
                            } else {
                                stock.indexPathAt = IndexPath(row: 0, section: menuStocks.count)
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
