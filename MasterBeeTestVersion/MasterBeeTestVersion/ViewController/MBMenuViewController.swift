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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MBMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell")! as UITableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
