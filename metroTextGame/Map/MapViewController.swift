//
//  MapViewController.swift
//  metroTextGame
//
//  Created by Павел Петров on 28.10.2023.
//

import UIKit
import SnapKit

class MapViewController: UIViewController, UIScrollViewDelegate {
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        setupScrollView()
    }
    
    
    
    @objc func imageTapped() {
        print("interative map")

    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 0.4
        view.maximumZoomScale = 2.0
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "map")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupScrollView() {
        scrollView.delegate = self
            view.addSubview(scrollView)
            scrollView.addSubview(imageView)
        
//        scrollView.snp.makeConstraints { make in
//            make.leading.trailing.top.equalToSuperview()
//        }
//        
//        imageView.snp.makeConstraints { make in
//            make.leading.trailing.top.equalToSuperview()
//        }
//            
            // Установите констрейны для UIScrollView и UIImageView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }

    func centerImage() {
        let boundsSize = scrollView.bounds.size
        var frameToCenter = imageView.frame
        
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height)

        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }

        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }

        imageView.frame = frameToCenter
    }
}

