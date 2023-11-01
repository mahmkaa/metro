//
//  GameViewController.swift
//  metroTextGame
//
//  Created by Павел Петров on 28.10.2023.
//

import UIKit

class GameViewController: UIViewController, NavigationBarVisibilityDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapButton = UIBarButtonItem(
            image: UIImage(systemName: "map.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapMapButton))
        
        navigationItem.rightBarButtonItem = mapButton
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "figure.walk.arrival"),
            style: .plain,
            target: self,
            action: #selector(confirmBack)
        )
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    @objc func didTapMapButton() {
        print("tap map")
        let detailImageVC = MapModalViewController()
        detailImageVC.modalPresentationStyle = .overFullScreen
        navigationController?.setNavigationBarHidden(true, animated: true)
        detailImageVC.navigationBarVisibilityDelegate = self
        present(detailImageVC, animated: true)
    }
    
    @objc func confirmBack() {
        print("tap exit")
        let alert = UIAlertController(
            title: "Хотите выйти?",
            message: "Ваш прогресс не сохранится",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            // Выбрано "Да", выполняйте действия, которые нужно выполнить при нажатии "Back"
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
    

}
