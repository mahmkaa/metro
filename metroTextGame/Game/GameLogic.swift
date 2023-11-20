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
        Scene(location: "Беговая",text: "Беговая", choices: [
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
        Scene(location: "Гостиный двор",text: "Гостинка", choices: [
            Choice(text: "Идти на запад", nextSceneindex: 13),
            Choice(text: "Идти на восток", nextSceneindex: 15),
            Choice(text: "Совершить пересадку", nextSceneindex: 45)
        ]),
        //15
        Scene(location: "Маяковская",text: "Маяковская", choices: [
            Choice(text: "Идти на запад", nextSceneindex: 14),
            Choice(text: "Идти на северо-восток 16", nextSceneindex: 16),
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
            Choice(text: "Идти на север", nextSceneindex: 20),
            Choice(text: "Идти в депо", nextSceneindex: Int.random(in: 1...6))
        ]),
        // MARK: - Violet line
        //22
        Scene(location: "Комендатский проспект",text: "Комендантский проспект", choices: [
            Choice(text: "Идти в депо", nextSceneindex: Int.random(in: 1...6)),
            Choice(text: "Идти на юг", nextSceneindex: 23)
        ]),
        //23
        Scene(location: "Старая деревня",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 22),
            Choice(text: "Идти на юг", nextSceneindex: 24)
        ]),
        //24
        Scene(location: "Крестовский остров",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 23),
            Choice(text: "Идти на юг", nextSceneindex: 25)
        ]),
        //25
        Scene(location: "Чкаловская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 24),
            Choice(text: "Идти на юг", nextSceneindex: 26)
        ]),
        //26
        Scene(location: "Спортивная",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 25),
            Choice(text: "Идти на юго-восток", nextSceneindex: 27)
        ]),
        //27
        Scene(location: "Адмиралтейская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на северо-запад", nextSceneindex: 26),
            Choice(text: "Идти на юго-восток", nextSceneindex: 28)
        ]),
        //28
        Scene(location: "Садовая",text: "Садовая", choices: [
            Choice(text: "Идти на северо-запад", nextSceneindex: 27),
            Choice(text: "Идти на юго-восток", nextSceneindex: 29),
            Choice(text: "Совершить пересадку 46", nextSceneindex: 46),
            Choice(text: "Совершить пересадку", nextSceneindex: Int.random(in: 1...6))
        ]),
        //29
        Scene(location: "Звенигородская",text: "Звенигородская", choices: [
            Choice(text: "Идти на северо-запад", nextSceneindex: 28),
            Choice(text: "Идти на юг", nextSceneindex: 30),
            Choice(text: "Совершить пересадку", nextSceneindex: Int.random(in: 1...6))
        ]),
        //30
        Scene(location: "Обводный канал",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 29),
            Choice(text: "Идти на юг", nextSceneindex: 31)
        ]),
        //31
        Scene(location: "Волковская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 30),
            Choice(text: "Идти на юг", nextSceneindex: 32)
        ]),
        //32
        Scene(location: "Бухарестская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 31),
            Choice(text: "Идти на юг", nextSceneindex: 33)
        ]),
        //33
        Scene(location: "Международная",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 32),
            Choice(text: "Идти на юг", nextSceneindex: 34)
        ]),
        //34
        Scene(location: "Проспект славы",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 33),
            Choice(text: "Идти на юг", nextSceneindex: 35)
        ]),
        //35
        Scene(location: "Дунайская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 34),
            Choice(text: "Идти на юг", nextSceneindex: 36)
        ]),
        //36
        Scene(location: "Шушары",text: "Шушары", choices: [
            Choice(text: "Идти на север", nextSceneindex: 35),
            Choice(text: "Идти в депо", nextSceneindex: Int.random(in: 1...6))
        ]),
        // MARK: - Blue line
        //37
        Scene(location: "Парнас",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти в депо", nextSceneindex: Int.random(in: 1...6)),
            Choice(text: "Идти на юг", nextSceneindex: 38)
        ]),
        //38
        Scene(location: "Проспект просвещения",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 37),
            Choice(text: "Идти на юг", nextSceneindex: 39)
        ]),
        //39
        Scene(location: "Озерки",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 38),
            Choice(text: "Идти на юг", nextSceneindex: 40)
        ]),
        //40
        Scene(location: "Удельная",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 39),
            Choice(text: "Идти на юг", nextSceneindex: 41)
        ]),
        //41
        Scene(location: "Пионерская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 40),
            Choice(text: "Идти на юг", nextSceneindex: 42)
        ]),
        //42
        Scene(location: "Чёрная речка",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 41),
            Choice(text: "Идти на юг", nextSceneindex: 43)
        ]),
        //43
        Scene(location: "Петроградская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 42),
            Choice(text: "Идти на юг", nextSceneindex: 44)
        ]),
        //44
        Scene(location: "Горьковская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 43),
            Choice(text: "Идти на юг", nextSceneindex: 45)
        ]),
        //45
        Scene(location: "Невский проспект",text: "Невский проспект", choices: [
            Choice(text: "Идти на север", nextSceneindex: 44),
            Choice(text: "Идти на юг", nextSceneindex: 46),
            Choice(text: "Совершить пересадку", nextSceneindex: 14)
        ]),
        //46
        Scene(location: "Сенная площадь",text: "Сенная площадь", choices: [
            Choice(text: "Идти на север", nextSceneindex: 45),
            Choice(text: "Идти на юг", nextSceneindex: 47),
            Choice(text: "Совершить пересадку 28", nextSceneindex: 28),
            Choice(text: "Совершить пересадку", nextSceneindex: Int.random(in: 1...6))
        ]),
        //47
        Scene(location: "Технологический институт 2",text: "Техноложка 2", choices: [
            Choice(text: "Идти на север", nextSceneindex: 46),
            Choice(text: "Идти на юг", nextSceneindex: 48),
            Choice(text: "Совершить пересадку", nextSceneindex: Int.random(in: 1...6))
        ]),
        //48
        Scene(location: "Фрунзенская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 47),
            Choice(text: "Идти на юг", nextSceneindex: 49)
        ]),
        //49
        Scene(location: "Московские ворота",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 48),
            Choice(text: "Идти на юг", nextSceneindex: 50)
        ]),
        //50
        Scene(location: "Электросила",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 49),
            Choice(text: "Идти на юг", nextSceneindex: 51)
        ]),
        //51
        Scene(location: "Парк победы",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 50),
            Choice(text: "Идти на юг", nextSceneindex: 52)
        ]),
        //52
        Scene(location: "Московская",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 51),
            Choice(text: "Идти на юг", nextSceneindex: 53)
        ]),
        //53
        Scene(location: "Звездная",text: "Вы посмотрели.", choices: [
            Choice(text: "Идти на север", nextSceneindex: 52),
            Choice(text: "Идти на юг", nextSceneindex: 54)
        ]),
        //54
        Scene(location: "Купчино",text: "купчага", choices: [
            Choice(text: "Идти на север", nextSceneindex: 53),
            Choice(text: "Идти в депо", nextSceneindex: Int.random(in: 1...6))
        ]),
        //MARK: - Red line
        //55
        Scene(location: "Девяткино",text: "Вы в жопе мира", choices: [
            Choice(text: "Идти на север", nextSceneindex: Int.random(in: 1...6)),
            Choice(text: "Идти на юг", nextSceneindex: 0)
        ]),
        //56
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
        
        if stepsRemaining <= 0 || currentSceneIndex == 200 {
            isGameInProgress = false
            delegate?.gameOver(message: "Вы не успели добраться до цели. Игра окончена.")
        }
        
        if currentSceneIndex == 53 {
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
