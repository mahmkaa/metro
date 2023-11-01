//
//  File.swift
//  metroTextGame
//
//  Created by Павел Петров on 28.10.2023.
//

import UIKit


class MapModalViewController: UIViewController {
    weak var navigationBarVisibilityDelegate: NavigationBarVisibilityDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupCloseButton()
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "map")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.imageView?.contentMode = .scaleAspectFit
        
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 145).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
    }
    
    func setupImageView() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func closeTapped() {
        navigationBarVisibilityDelegate?.setNavigationBarHidden(false, animated: true)
        dismiss(animated: true)
    }
}

