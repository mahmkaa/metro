//
//  GameViewController.swift
//  metroTextGame
//
//  Created by Павел Петров on 28.10.2023.
//

import UIKit

class GameViewController: UIViewController, NavigationBarVisibilityDelegate {
    var gameLogic: GameLogic = GameLogic()
    
    @IBOutlet weak var buttonV1: UIButton!
    @IBOutlet weak var buttonV2: UIButton!
    @IBOutlet weak var buttonV3: UIButton!
    @IBOutlet weak var gameLabel: UILabel!
    
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
    @IBAction func didTapButtonV1() {
        print("tap v1")
    }
    @IBAction func didTapButtonV2() {
        print("tap v2")
    }
    @IBAction func didTapButtonV3() {
        print("tap v3")
    }
    
    // MARK: - Selectors
    @objc func didTapMapButton() {
        print("tap map")
        let detailImageVC = MapModalViewController()
        detailImageVC.modalPresentationStyle = .overFullScreen
        navigationController?.setNavigationBarHidden(true, animated: true)
        buttonV1.isHidden = true
        buttonV2.isHidden = true
        buttonV3.isHidden = true
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
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Protocols
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
    
    func isHidden(_ isHidden: Bool) {
        buttonV1.isHidden = isHidden
        buttonV2.isHidden = isHidden
        buttonV3.isHidden = isHidden
    }
}
