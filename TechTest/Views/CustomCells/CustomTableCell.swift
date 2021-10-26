//
//  CustomTableCell.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 25/10/21.
//

import UIKit

class CustomTableCell: UITableViewCell {
    
    var itemVM: ItemViewModel? {
        didSet {
            configureCell()
        }
    }
    
    private let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 12, weight: .bold)
        return title
    }()
    
    private let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.numberOfLines = 0
        subtitle.font = .systemFont(ofSize: 12, weight: .light)
        return subtitle
    }()
    
    private let favoritesButton: UIButton = {
        let favoritesButton = UIButton(type: .custom)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.addTarget(self, action: #selector(toggleFavorites), for: .touchUpInside)
        return favoritesButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        guard let itemVM = itemVM else { return }
        
        

        title.text = itemVM.title
        subtitle.text = "\(itemVM.rating)"
                
        let image = UIImage(systemName: itemVM.isFavorite ? "star.fill" : "star")?.withTintColor(.yellow, renderingMode: .alwaysTemplate)
        favoritesButton.setImage(image, for: .normal)
        
        addSubview(title)
        addSubview(subtitle)
        addSubview(favoritesButton)
        
        favoritesButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        favoritesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        favoritesButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true

        
        title.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: favoritesButton.leadingAnchor, constant: -10).isActive = true
        
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: favoritesButton.leadingAnchor, constant: -10).isActive = true
    }
    
    @objc private func toggleFavorites() {
        print("")
    }

}

