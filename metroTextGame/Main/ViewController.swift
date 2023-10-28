//
//  ViewController.swift
//  metroTextGame
//
//  Created by Павел Петров on 27.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    // MARK: - Actions
    @IBAction func didTapStartButton() {
        print("tap start")
        let storyboard = UIStoryboard(name: "GameViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

