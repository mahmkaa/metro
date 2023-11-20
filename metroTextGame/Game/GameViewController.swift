//
//  GameViewController.swift
//  metroTextGame
//
//  Created by Павел Петров on 28.10.2023.
//

import UIKit

class GameViewController: UIViewController, NavigationBarVisibilityDelegate, GameLogicDelegate {
    var gameLogic: GameLogic = GameLogic()
    
    @IBOutlet weak var buttonV1: UIButton!
    @IBOutlet weak var buttonV2: UIButton!
    @IBOutlet weak var buttonV3: UIButton!
    @IBOutlet weak var buttonV4: UIButton!
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
        
        gameLogic = GameLogic()
        gameLogic.delegate = self
        gameLogic.startNewGame()
    }
    
    // MARK: - Actions
    @IBAction func didTapButtonV1() {
        print("tap v1")
        let choiceIndex = 0
        handleChoice(for: choiceIndex)
    }
    @IBAction func didTapButtonV2() {
        print("tap v2")
        let choiceIndex = 1
        handleChoice(for: choiceIndex)
    }
    @IBAction func didTapButtonV3() {
        print("tap v3")
        let choiceIndex = 2
        handleChoice(for: choiceIndex)
    }
    @IBAction func didTapButtonV4() {
        var choiceIndex = 0
        
        if buttonV1.isHidden == false || buttonV2.isHidden == false || buttonV3.isHidden == false {
            choiceIndex = 3
        }
        
        print("tap v4 with choice index = \(choiceIndex)")
        handleChoice(for: choiceIndex)
    }
    
    func handleChoice(for choiceIndex: Int) {
        gameLogic.playerChoice(choiceIndex)
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
        buttonV4.isHidden = true
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
        buttonV4.isHidden = isHidden
    }
    
    func updateGameScene(text: String, choice: [String]) {
        gameLabel.text = text
        
        let choiceButtons = [buttonV1, buttonV2, buttonV3, buttonV4]
        let choiceTexts = choice
        
//        if choice.count == 1 {
//            buttonV4.isHidden = false
//            buttonV1.isHidden = true
//            buttonV2.isHidden = true
//            buttonV3.isHidden = true
//            buttonV4.setTitle(choice[0], for: .normal)
//        } else {
//            buttonV4.isHidden = true
//            for (index, button) in choiceButtons.prefix(choice.count).enumerated() {
//                button?.isHidden = false
//                button?.setTitle(choice[index], for: .normal)
//            }
//        }
        if choice.count == 1 {
            buttonV4.isHidden = false
            buttonV1.isHidden = true
            buttonV2.isHidden = true
            buttonV3.isHidden = true
            
            buttonV4.setTitle(choice[0], for: .normal)
        }
        
        if choice.count == 2 {
            buttonV1.isHidden = false
            buttonV2.isHidden = false
            buttonV3.isHidden = true
            buttonV4.isHidden = true
            
            buttonV1.setTitle(choice[0], for: .normal)
            buttonV2.setTitle(choice[1], for: .normal)
        }
        
        if choice.count == 3 {
            buttonV1.isHidden = false
            buttonV2.isHidden = false
            buttonV3.isHidden = false
            buttonV4.isHidden = true
            
            buttonV1.setTitle(choice[0], for: .normal)
            buttonV2.setTitle(choice[1], for: .normal)
            buttonV3.setTitle(choice[2], for: .normal)
        }
        
        if choice.count >= 4 {
            buttonV1.isHidden = false
            buttonV2.isHidden = false
            buttonV3.isHidden = false
            buttonV4.isHidden = false
            
            buttonV1.setTitle(choice[0], for: .normal)
            buttonV2.setTitle(choice[1], for: .normal)
            buttonV3.setTitle(choice[2], for: .normal)
            buttonV4.setTitle(choice[3], for: .normal)
        }
    }
    
    func gameOver(message: String) {
        gameLabel.text = message
        
        buttonV1.isHidden = true
        buttonV2.isHidden = true
        buttonV3.isHidden = true
        buttonV4.isHidden = true
    }
    
}
