//
//  CustomTableViewCell.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let tableImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints =  false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Name"
        
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Location"
        
        return label
    }()
    
    let firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10.0
        stack.alignment = .trailing
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    let secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5.0
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUserInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserInterface() {
        
        firstStackView.addArrangedSubview(nameLabel)
        firstStackView.addArrangedSubview(locationLabel)
        secondStackView.addArrangedSubview(tableImageView)
        secondStackView.addArrangedSubview(firstStackView)
        self.contentView.addSubview(secondStackView)
    }
    
    private func setupConstraints() {
        
        tableImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        tableImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        secondStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        secondStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        secondStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        secondStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }

}
