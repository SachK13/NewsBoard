//
//  NewsTableViewCell.swift
//  NewsBoard
//
//  Created by Sachin on 29/09/22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {

    var newsVM: NewsViewModel? {
        didSet {
            if let newsVM = newsVM {
                
            }
        }
    }
    
    var newsImageData: Data? {
        didSet {
            if let data = newsImageData {
                newsImageView.image = UIImage(data: data)
            }
        }
    }
    
    private lazy var newsImageView: ShadowImageView = {
        let imageView = ShadowImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(newsImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        // New Image
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImageView.topAnchor.constraint(equalTo: topAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        // Title
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
