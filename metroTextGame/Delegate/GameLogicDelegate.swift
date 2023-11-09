//
//  GameLogicDelegate.swift
//  metroTextGame
//
//  Created by Павел Петров on 02.11.2023.
//

protocol GameLogicDelegate: class {
    func updateGameScene(text: String, choice: [String])
    func gameOver(message: String)
}
