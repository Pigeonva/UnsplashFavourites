//
//  DetailTableViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 16.08.2022.
//

import UIKit

class DetailTableViewController: UIViewController {
    
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
        
        navigationController?.navigationBar.tintColor = .black
        setupUserInterface()
        setConstraints()
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
