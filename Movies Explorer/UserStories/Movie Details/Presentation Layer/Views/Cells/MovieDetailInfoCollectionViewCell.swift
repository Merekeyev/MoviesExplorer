//
//  MovieDetailInfoCollectionViewCell.swift
//  Movies Explorer
//
//  Created by Temirlan on 11.06.2023.
//

import UIKit

class MovieDetailInfoCollectionViewCell: UICollectionViewCell {
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16
        view.distribution = .fill
        return view
    }()
    
    private var releaseDateLabel: UILabel!
    private var durationLabel: UILabel!
    private var voteLabel: UILabel!
    private var popularityLabel: UILabel!
    
    func configure(movieDetail: MovieDetailModel) {
        releaseDateLabel.text = "2023"
        durationLabel.text = "1h 20m"
        voteLabel.text = "Vote: 8.3"
        popularityLabel.text = "Popularity: 2024"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalToConstant: 48),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        scrollView.addSubview(containerView)
        let trailingAnchor = containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        trailingAnchor.priority = .defaultLow
        let centerXAnchor = containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        centerXAnchor.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            trailingAnchor,
            centerXAnchor
        ])
        
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        releaseDateLabel = getLabel()
        durationLabel = getLabel()
        voteLabel = getLabel()
        popularityLabel = getLabel()
        
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(durationLabel)
        stackView.addArrangedSubview(voteLabel)
        stackView.addArrangedSubview(popularityLabel)
    }
    
    private func getLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = Colors.gray200
        return label
    }
}
