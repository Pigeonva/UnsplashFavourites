//
//  TableViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var favouritesList = [UnsplashPhoto]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: K.identifierForTableCell)
        tableView.rowHeight = 120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.identifierForTableCell, for: indexPath) as! CustomTableViewCell
        
        return cell
    }
}
