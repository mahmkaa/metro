//
//  GameViewController.swift
//  metroTextGame
//
//  Created by Павел Петров on 28.10.2023.
//

import UIKit

class GameViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    // MARK: - Actions
    @IBAction func didTapMapButton() {
        print("tap map")
        let storyboard = UIStoryboard(name: "MapViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        present(vc, animated: true)
    }
}
