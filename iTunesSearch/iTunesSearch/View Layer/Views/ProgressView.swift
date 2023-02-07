//
//  ProgressView.swift
//  iTunesSearch
//
//  Created by user on 07.02.2023.
//

import UIKit

class ProgressView: UIView {
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setProgress(50, animated: true)
        view.tintColor = .red
        
        view.layer.cornerRadius = 3
//        view.layer.backgroundColor = UIColor.blue.cgColor
        view.layer.sublayers![1].backgroundColor = UIColor.blue.cgColor
        view.clipsToBounds = true
        view.layer.sublayers![1].cornerRadius = 3
        view.subviews[1].clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 4
        backgroundColor = .black
//        heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        addSubview(progressView)
        
        progressView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        progressView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
