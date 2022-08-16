//
//  DetailCollectionViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 09.08.2022.
//

import UIKit

class DetailCollectionViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var networkDataFetcher = NetworkDataFetcher()
    var id = String()
    
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
        getInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        let navVC = tabBarController?.viewControllers?[1] as! UINavigationController
        let tableVC  = navVC.topViewController as! TableViewController
        var counter = 0
        tableVC.favouritesList.forEach { item in
            if item.image == imageView.image?.pngData() {
                counter += 1
            }
        }
        if counter == 0 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
        }
        navigationController?.navigationBar.tintColor = .black
        
    }
    
    @objc func savePressed() {
        
        let model = PhotoModel(context: context)
        model.image = imageView.image?.pngData()
        model.createAt = creatingDate.text
        model.downloads = downloads.text
        model.name = authorName.text
        model.location = location.text
        
        let navVC = tabBarController?.viewControllers?[1] as! UINavigationController
        let tableVC  = navVC.topViewController as! TableViewController
        tableVC.favouritesList.append(model)
        do {
            try context.save()
        } catch  {
            print("\(error)")
        }
        navigationItem.rightBarButtonItem?.isEnabled = false
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
    
    private func getInfo() {
        
        networkDataFetcher.fetchImages(id: id) { infoData in
            guard let fetchedInfo = infoData else {return}
            self.downloads.text = "Downloads: \(String(fetchedInfo.downloads))"
            self.authorName.text = "by \(fetchedInfo.user.name)"
            self.location.text = fetchedInfo.location.name ?? "Somewhere in the Earth"
            let date = fetchedInfo.createdAt
            self.creatingDate.text = self.createCorrectDateFormat(dateJSON: date)
        }
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
