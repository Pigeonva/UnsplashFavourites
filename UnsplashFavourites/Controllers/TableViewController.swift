//
//  TableViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let request: NSFetchRequest<PhotoModel> = PhotoModel.fetchRequest()

    var favouritesList: [PhotoModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: K.identifierForTableCell)
        tableView.rowHeight = 120
        loadData()
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

        let tableDetailViewController = DetailTableViewController()
        tableDetailViewController.imageView.image = UIImage(data: favouritesList[indexPath.row].image!)
        tableDetailViewController.authorName.text = favouritesList[indexPath.row].name
        tableDetailViewController.creatingDate.text = favouritesList[indexPath.row].createAt
        tableDetailViewController.location.text = favouritesList[indexPath.row].location
        tableDetailViewController.downloads.text = favouritesList[indexPath.row].downloads
        tableDetailViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(tableDetailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(favouritesList[indexPath.row])
            do {
                try context.save()
            } catch  {
                print("\(error)")
            }
            favouritesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func loadData() {
        
        do {
         favouritesList = try context.fetch(request)
        } catch {
            print("Error fatching \(error)")
        }
    }
}

