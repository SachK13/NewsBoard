//
//  HeaderView.swift
//  NewsBoard
//
//  Created by Sachin on 26/09/22.
//

import UIKit

final class HeaderView: UIView {
    var fontSize: CGFloat
    
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News"
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var headerCircleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        imageView.image = UIImage(
            systemName: "circle.circle.fill",
            withConfiguration: config)?
            .withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    private lazy var plusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        imageView.image = UIImage(
            systemName: "plus",
            withConfiguration: config)?
            .withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    private lazy var subHeadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top Headlines"
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = .gray
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerCircleImage, headingLabel, plusImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(headerStackView)
        addSubview(subHeadingLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        // News Header
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Sub Heading
        NSLayoutConstraint.activate([
            subHeadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subHeadingLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            subHeadingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
