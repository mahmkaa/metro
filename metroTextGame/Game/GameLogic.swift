//
//  GameLogic.swift
//  metroTextGame
//
//  Created by Павел Петров on 02.11.2023.
//


class GameLogic {
    var isGameInProgress = false
    var currentSceneIndex = 0
    var stepsRemaining = 10
    weak var delegate: GameLogicDelegate?
    
    struct Scene {
        let location: String
        let text: String
        let choices: [Choice]
    }
    
    struct Choice {
        let text: String
        let nextSceneindex: Int?
    }
    
    private let scenes: [Scene] = [
        // MARK: - Start scene
        //0
        Scene(location: "Стартовая сцена",text: "Цель вашего пути", choices: [
            Choice(text: "Войти в метро", nextSceneindex: 10)
        ]),
        // MARK: - Death Scenes
        //1
        Scene(location: "Сцена смерти 1",text: "Вы заблудились. Вы растерялись. Вас съел монстр. Вы умерли от голода.", choices: [
            Choice(text: "Ой", nextSceneindex: 22)
        ]),
        //2
        Scene(location: "Сцена смерти 2",text: "Вы начали осматривать депо. Вскоре вы начали ходить туда-сюда, пока не запутались в действиях. А ещё вы запутались, поэтому начали звать людей. Вскоре вы запутались в словах и умерли от голода.", choices: [
            Choice(text: "Ой", nextSceneindex: 22)
        ]),
        //3
        Scene(location: "Сцена смерти 3",text: "Вы зашли в депо. Там не было ничего интересного, поэтому вы вернулись. Началась ядерная война. Вы не успели забежать в метро. Вы умерли.", choices: [
            Choice(text: "Ой", nextSceneindex: 22)
        ]),
        //4
        Scene(location: "Сцена смерти 4",text: "Ты схвачен, намочен, отфигачен и проглочен. Ты мертв, мертвее мёртвого. Вопросы?", choices: [
            Choice(text: "Ой", nextSceneindex: 22)
        ]),
        //5
        Scene(location: "Сцена смерти 4",text: "Ты схвачен, намочен, отфигачен и проглочен. Ты мертв, мертвее мёртвого. Вопросы?", choices: [
            Choice(text: "Ой", nextSceneindex: 22)
        ]),
        //6
        Scene(location: "Сцена смерти 5",text: "Вы не сдаётесь и решили поискать помощи или припасы", choices: [
            Choice(text: "Искать", nextSceneindex: 7)
        ]),
        //7
        Scene(location: "Сцена смерти 5",text: "Вы ничего не нашли.", choices: [
            Choice(text: "Искать дальше", nextSceneindex: 8)
        ]),
        //8
        Scene(location: "Сцена смерти 5",text: "Вы снова ничего не нашли.", choices: [
            Choice(text: "Искать дальше", nextSceneindex: 9)
        ]),
        //9
        Scene(location: "Сцена смерти 5",text: "Вы разочаровались в себе. Вы сели на первую попавшуюся коробку с едой. Вас сбила муха. Вы остались лежать пока не умерли от голода.", choices: [
            Choice(text: "Эх", nextSceneindex: 22)
        ]),
        // MARK: - Green line
        //10
        Scene(location: "Беговая",text: "Сцена", choices: [
            Choice(text: "Идти в депо", nextSceneindex: Int.random(in: 1...6)),
            Choice(text: "Идти на юг", nextSceneindex: 11)
        ]),
        //11
        Scene(location: "Зенит",text: "Сцена", choices: [
            Choice(text: "Идти на север", nextSceneindex: 10),
            Choice(text: "Идти на юго-восток", nextSceneindex: 12)
        ]),
        //12
        Scene(location: "Приморская",text: "Вы нашли очень странный проход", choices: [
            Choice(text: "Идти на северо-запад", nextSceneindex: 11),
            Choice(text: "Идти на восток", nextSceneindex: 13)
        ]),
        //13
        Scene(location: "Василеостровская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на запад", nextSceneindex: 12),
            Choice(text: "Идти на восток", nextSceneindex: 14)
        ]),
        //14
        Scene(location: "Гостиный двор",text: "Вы посмотрели 14.", choices: [
            Choice(text: "Идти на запад", nextSceneindex: 13),
            Choice(text: "Идти на восток", nextSceneindex: 15),
            Choice(text: "Совершить пересадку", nextSceneindex: Int.random(in: 1...6))
        ]),
        //15
        Scene(location: "Маяковская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на запад", nextSceneindex: 14),
            Choice(text: "Идти на северо-восток", nextSceneindex: 16),
            Choice(text: "Совершить пересадку", nextSceneindex: Int.random(in: 1...6))
        ]),
        //16
        Scene(location: "Площадь Александра Невского 1",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на северо-запад", nextSceneindex: 15),
            Choice(text: "Идти на юг", nextSceneindex: 17)
        ]),
        //17
        Scene(location: "Елизаровская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 16),
            Choice(text: "Идти на юг", nextSceneindex: 18)
        ]),
        //18
        Scene(location: "Ломоносовская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 17),
            Choice(text: "Идти на юг", nextSceneindex: 19)
        ]),
        //19
        Scene(location: "Пролетарская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 18),
            Choice(text: "Идти на юг", nextSceneindex: 20)
        ]),
        //20
        Scene(location: "Обухово",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 19),
            Choice(text: "Идти на юг", nextSceneindex: 21)
        ]),
        //21
        Scene(location: "Рыбацкое",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 0),
            Choice(text: "Идти в депо", nextSceneindex: 0)
        ]),
        // MARK: - Violet line
        //22
        Scene(location: "Комендатский проспект",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 0),
            Choice(text: "Идти на юг", nextSceneindex: 0)
        ]),
        //14
        Scene(location: "Василеостровская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 0),
            Choice(text: "Идти на юг", nextSceneindex: 0)
        ]),
        //14
        Scene(location: "Василеостровская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 0),
            Choice(text: "Идти на юг", nextSceneindex: 0)
        ]),
        //14
        Scene(location: "Василеостровская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 0),
            Choice(text: "Идти на юг", nextSceneindex: 0)
        ]),
        //14
        Scene(location: "Василеостровская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 0),
            Choice(text: "Идти на юг", nextSceneindex: 0)
        ])
    ]
    
    func startNewGame() {
        isGameInProgress = true
        currentSceneIndex = 0
        stepsRemaining = 50
        showCurrentScene()
    }
    
    func playerChoice(_ choice: Int) {
        guard isGameInProgress, choice >= 0, choice < scenes[currentSceneIndex].choices.count else {
            return
        }
        
        let nextSceneIndex = scenes[currentSceneIndex].choices[choice].nextSceneindex
        
        if let nextSceneIndex = nextSceneIndex {
            currentSceneIndex = nextSceneIndex
            stepsRemaining -= 1
            showCurrentScene()
        }
        
        if stepsRemaining <= 0 || currentSceneIndex == 22 {
            isGameInProgress = false
            delegate?.gameOver(message: "Вы не успели добраться до цели. Игра окончена.")
        }
        
        if currentSceneIndex == 21 {
            isGameInProgress = false
            delegate?.gameOver(message: "Поздравляем! Вы успешно добрались до цели.")
        }
    }
    
    private func showCurrentScene() {
        let currentScene = scenes[currentSceneIndex]
        let choices = currentScene.choices.map { $0.text }
        delegate?.updateGameScene(text: currentScene.text, choice: choices)
    }
}
