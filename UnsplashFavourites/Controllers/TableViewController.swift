//
//  TableViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let detailVC  = DetailViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: K.tableBackgroundColor)
        
        
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
////        detailVC.navigationController?.popViewController(animated: true)
//        detailVC.dismiss(animated: true, completion: nil)
//    }
}
