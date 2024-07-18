//
//  ListTableCell.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/15/24.
//

import UIKit

class ListCell: UITableViewCell {
    
    private let listImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true  // 이미지가 뷰 경계 넘지 않도록(true)
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let listName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let listNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func setupView() {
        
        contentView.addSubview(listImage)
        contentView.addSubview(listName)
        contentView.addSubview(listNumber)
        
        NSLayoutConstraint.activate([
            listImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            listImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            listImage.widthAnchor.constraint(equalToConstant: 70),
            listImage.heightAnchor.constraint(equalToConstant: 70),
            
            listName.leadingAnchor.constraint(equalTo: listImage.trailingAnchor, constant: 20),
            listName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            listNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            listNumber.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(withName name: String, number: String?, image: UIImage?) {
        listName.text = name
        listNumber.text = number
        listImage.image = image
    }
}

#Preview {
    ListView()
}
