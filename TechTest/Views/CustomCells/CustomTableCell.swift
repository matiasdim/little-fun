//
//  CustomTableCell.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 25/10/21.
//

import UIKit

protocol CustomTableCellActionsHandler {
    func toggleFavorite(item: ItemViewModel)
}

class CustomTableCell: UITableViewCell {
    
    var toggleFavorite: ((_ item: ItemViewModel) -> ())?
    
    var itemVM: ItemViewModel? {
        didSet {
            configureCell()
        }
    }
    
    private let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
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
    
    private let favoriteButton: UIButton = {
        let favoriteButton = UIButton(type: .custom)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        return favoriteButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        guard let itemVM = itemVM else { return }

        title.text = itemVM.title
        subtitle.text = "Rating: \(itemVM.rating)"
                
        let image = UIImage(systemName: itemVM.isFavorite ? "star.fill" : "star")?.withTintColor(.yellow, renderingMode: .alwaysTemplate)
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(favoriteButton)
        
        favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10).isActive = true
        
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10).isActive = true
    }
    
    @objc private func favoriteButtonPressed() {
        guard let itemVM = itemVM else { return }
        let image = UIImage(systemName: itemVM.isFavorite ? "star.fill" : "star")?.withTintColor(.yellow, renderingMode: .alwaysTemplate)
        favoriteButton.setImage(image, for: .normal)
        toggleFavorite?(itemVM)
    }

}

