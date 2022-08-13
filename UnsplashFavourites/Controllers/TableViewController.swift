//
//  TableViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import UIKit

class TableViewController: UITableViewController {

    var favouritesList: [DataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: K.identifierForTableCell)
        tableView.rowHeight = 120
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favouritesList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.identifierForTableCell, for: indexPath) as! CustomTableViewCell
        cell.setCell(model: favouritesList[indexPath.row])
        
        return cell
    }
    
    //MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailViewController = DetailViewController()
        detailViewController.imageView.image = favouritesList[indexPath.row].image
        detailViewController.authorName.text = favouritesList[indexPath.row].name
        detailViewController.creatingDate.text = favouritesList[indexPath.row].createAt
        detailViewController.location.text = favouritesList[indexPath.row].location
        detailViewController.downloads.text = favouritesList[indexPath.row].downloads
        detailViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
