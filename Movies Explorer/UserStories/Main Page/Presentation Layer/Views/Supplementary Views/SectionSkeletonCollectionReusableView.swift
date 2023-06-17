//
//  SectionSkeletonCollectionReusableView.swift
//  Movies Explorer
//
//  Created by Temirlan on 10.06.2023.
//

import UIKit

class SectionSkeletonCollectionReusableView: UICollectionReusableView {
    
    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray150
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray150
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleView.widthAnchor.constraint(equalToConstant: 108),
            titleView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        addSubview(buttonView)
        NSLayoutConstraint.activate([
            buttonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            buttonView.widthAnchor.constraint(equalToConstant: 66),
            buttonView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
