//
//  DetailViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 09.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var networkDataFetcher = NetworkDataFetcher()
    var id = String()
    var collectionModel: PhotoModel?
    var tableModel: PhotoModel?
    var models: [PhotoModel] = []
    
    //MARK: - Create instances
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let authorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let creatingDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let downloads: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .trailing
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    let secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUserInterface()
        setConstraints()
        networkDataFetcher.fetchImages(id: id) { infoData in
            guard let fetchedInfo = infoData else {return}
            self.downloads.text = "Downloads: \(String(fetchedInfo.downloads))"
            self.authorName.text = "by \(fetchedInfo.user.name)"
            self.location.text = fetchedInfo.location.name ?? "Somewhere in the Earth"
            let date = fetchedInfo.createdAt
            self.creatingDate.text = self.createCorrectDateFormat(dateJSON: date)
        }
        checkTableSaving()
        checkCollectionSaving()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func savePressed() {
        
        guard let image = imageView.image?.pngData(), let name = authorName.text, let location = location.text, let downloads = downloads.text, let createAt = creatingDate.text else {return}
        
        let model = PhotoModel(context: context)
        model.image = image
        model.name = name
        model.createAt = createAt
        model.downloads = downloads
        model.location = location

        let navController = tabBarController?.viewControllers![1] as! UINavigationController
        let tableVC = navController.topViewController as! TableViewController
        var counter = 0
        for item in tableVC.favouritesList {
            if item.image == model.image {
                counter += 1
            } else {
                models.append(item)
            }
        }
        if counter == 0 {
            tableVC.favouritesList.append(model)
            do {
                try context.save()
            }
            catch  {
                print("Error contex \(error)")
            }
            tableVC.tableView.reloadData()
        }
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func checkTableSaving() {
        guard let safeModel = tableModel else {return}
        var counter = 0
        for item in models {
            if item.image == safeModel.image {
                counter += 1
            }
            if counter != 0 {
                navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    private func checkCollectionSaving() {
        guard let safeModel = collectionModel else {return}
        let navController = tabBarController?.viewControllers![1] as! UINavigationController
        let tableVC = navController.topViewController as! TableViewController
        var counter = 0
        print("\(tableVC.favouritesList)")
        for item in tableVC.favouritesList {
            if item.image == safeModel.image {
                counter += 1
            }
            if counter != 0 {
                navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    private func setupUserInterface() {
        
        view.backgroundColor = .white
        firstStackView.addArrangedSubview(authorName)
        firstStackView.addArrangedSubview(creatingDate)
        firstStackView.addArrangedSubview(location)
        firstStackView.addArrangedSubview(downloads)
        secondStackView.addArrangedSubview(imageView)
        secondStackView.addArrangedSubview(firstStackView)
        view.addSubview(secondStackView)
    }
    
    //MARK: - CreateCorrectDateFormat
    
    private func createCorrectDateFormat(dateJSON: String) -> String {
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateJSON)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    //MARK: - Setting Constraints
    
    private func setConstraints() {
        
        NSLayoutConstraint(item: secondStackView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 150).isActive = true
        
        NSLayoutConstraint(item: secondStackView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -20).isActive = true
        
        NSLayoutConstraint(item: secondStackView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: secondStackView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -150).isActive = true
        
        NSLayoutConstraint(item: authorName,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: creatingDate,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: location,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: downloads,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 20).isActive = true
    }
}
