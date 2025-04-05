//
//  MatchViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 18.04.2023.
//

import UIKit

extension UIButton { // расширение для кнопки, чтобы корректно менять шрифт
    func setFont(_ font: UIFont) {
        if #available(iOS 15.0, *) {
            self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = font
                return outgoing
            }
        }
        else {
            self.titleLabel?.font = font
        }
    }
}


class MatchViewController: UIViewController, UITextFieldDelegate {
    
    let GamePoints = ["0", "15", "30", "40", "AD", "0"] // счет
    var CurrentStep: Int = 0 // текущий шаг матча
    
    @IBOutlet weak var TurnirTextField: UITextField! // поле ввода названия турнира
    @IBOutlet weak var FirstPlayerNameTextField: UITextField! // поле ввода имени 1-го игрока
    @IBOutlet weak var SecondPlayerNameTextField: UITextField! // поле ввода имени 2-го игрока
    
    @IBOutlet weak var Win1Button: UIButton! // кнопка победы 1-го игрока
    @IBOutlet weak var Lose1Button: UIButton! // кнопка проигрыша 1-го игрока
    @IBOutlet weak var Win2Button: UIButton! // кнопка победы 2-го игрока
    @IBOutlet weak var Lose2Button: UIButton! // кнопка проигрыша 2-го игрока
    @IBOutlet weak var Point2WinButton: UIButton! // кнопка выигранного очка 1-го игрока
    @IBOutlet weak var Point1WinButton: UIButton! // кнопка выигранного очка 2-го игрока
    @IBOutlet weak var SwapButton: UIButton! // кнопка чтобы поменять игроков местами
    @IBOutlet weak var UndoButton: UIButton! // кнопка отмены последнего действия
    
    @IBOutlet weak var Set1Label: UILabel! // количество сетов 1-го игрока
    @IBOutlet weak var Set2Label: UILabel! // количество сетов 2-го игрока
    @IBOutlet weak var Game1Label: UILabel! // количество геймов 1-го игрока
    @IBOutlet weak var Game2Label: UILabel! // количество геймов 2-го игрока
    @IBOutlet weak var Point1Label: UILabel! // количество очков 1-го игрока
    @IBOutlet weak var Point2Label: UILabel! // количество очков 2-го игрока
    @IBOutlet weak var ScoreLabel: UILabel! // индикатор очков 0/15/30/40 или тайбрейка
    @IBOutlet weak var FirstPlayerStatusLabel: UILabel! // подача или прием у 1-го игрока
    @IBOutlet weak var SecondPlayerStetusLabel: UILabel! // и у второго игрока
    @IBOutlet weak var BallLabel: UILabel! // один или два мячика - ндикатор подачи
    
    @IBOutlet weak var Stat1Label: UILabel! // для отображения статистики очков 1-го игрока
    @IBOutlet weak var Stat2Label: UILabel! // для отображения статистики очков 2-го игрока
    @IBOutlet weak var GameStat1Label: UILabel! // для отображения статистики геймов 1-го игрока
    @IBOutlet weak var GameStat2Label: UILabel! // для отображения статистики геймов 2-го игрока
    @IBOutlet weak var Player1SetScoreLabel: UILabel! // для отображения выигранных геймов
    @IBOutlet weak var Player2SetScoreLabel: UILabel! // в предыдущих сетах
    
    @IBOutlet weak var FirstPlayerImage: UIImageView! // изображение 1-го игрока
    @IBOutlet weak var SecondPlayerImage: UIImageView! // изображение 2-го игрока
 
    @IBOutlet weak var FirstPlayerImageButton: UIButton! // кнопка поверх изображения 1-го игрока
    @IBOutlet weak var SecondPlayerImageButton: UIButton! // кнопка поверх изображения 2-го игрока
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // выполняется при отображении экрана
        if (match.TieBreak10)&&(!match.Finished) {
            ScoreLabel.text = "ТБ("+String(match.MaxPoint)+")"
        } else {
            ScoreLabel.text = "Очки"
        }
    }
    
    func SaveState() // запоминаем текущее состояние матча
    {
        CurrentStep+=1 // следующий шаг матча
        CurrentState.player1 = player1 // сохраняем состояние
        CurrentState.player2 = player2
        CurrentState.match = match
        MatchStates.append(CurrentState) // записываем текущее состояние в массив состояний
    }
    
    func RestoreState() // восстанавливаем предыдущее состояние матча
    {
        if CurrentStep >= 1 {
            CurrentStep-=1 // предыдущий шаг
            if CurrentStep == 0 { FullReset = true }
            player1 = MatchStates[CurrentStep].player1 // восстанавливаем состояние
            player2 = MatchStates[CurrentStep].player2
            match = MatchStates[CurrentStep].match
            // восстанавливаем имена игроков и название турнира, если они менялись
            if MatchStates[CurrentStep].player1.name != MatchStates[CurrentStep+1].player1.name
            { FirstPlayerNameTextField.text = player1.name }
            if MatchStates[CurrentStep].player2.name != MatchStates[CurrentStep+1].player2.name
            { SecondPlayerNameTextField.text = player2.name }
            if MatchStates[CurrentStep].match.TurnirName != MatchStates[CurrentStep+1].match.TurnirName
            { TurnirTextField.text = match.TurnirName }
            if match.TieBreak7 { ScoreLabel.text = "ТБ(7)"}
            else { ScoreLabel.text = "Очки"}
            if match.TieBreak10 { ScoreLabel.text = "ТБ("+String(match.MaxPoint)+")"}
            
            MatchStates.removeLast() // удаляем последнее состояние из массива
        }
    }
    
    func FinishGame () { // конец матча
        Win1Button.isEnabled = false
        Win2Button.isEnabled = false
        Lose1Button.isEnabled = false
        Lose2Button.isEnabled = false
        Point1WinButton.isEnabled = false
        Point2WinButton.isEnabled = false
        SwapButton.isEnabled = false
        FirstPlayerNameTextField.isEnabled = false
        SecondPlayerNameTextField.isEnabled = false
        TurnirTextField.isEnabled = false
        FirstPlayerImageButton.isEnabled = false
        SecondPlayerImageButton.isEnabled = false
        match.Finished = true
        match.MatchStop = Date(timeIntervalSinceNow: 0) // фиксируем время кончания матча
        match.MatchLength = match.MatchStop.timeIntervalSince(match.MatchStart) // длительность матча
    }
    
    func showWinAlert(playerName : String) { // показывает сообщение о победе игрока
        let alertController = UIAlertController(title: "Матч окончен", message: "Победитель матча: "+playerName, preferredStyle: .alert) // создаем алерт-контроллер
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil) // создаем действие "ОК"
        alertController.addAction(defaultAction) // добавляем действие к алерт-контроллеру
        present(alertController, animated: true, completion: nil) // отображаем алерт-контроллер
    }
    
    func SmenaPodachiDraw () { // отрисовка смены подачи
        switch match.PodaetNow {
        case 1: do {
            BallLabel.frame.origin.x = Point1Label.frame.origin.x + Point1Label.frame.width - 30
            FirstPlayerStatusLabel.text = String(match.Podacha)+" подача"
            SecondPlayerStetusLabel.text = "Прием"
            Win1Button.setTitle("Эйс", for: .normal)
            Win2Button.setTitle("Виннер", for: .normal)
            Lose1Button.setTitle("Ошибка на подаче", for: .normal)
            Lose2Button.setTitle("Ошибка", for: .normal)
            FirstPlayerImage.image = UIImage(named: "img_serve_left")
            SecondPlayerImage.image = UIImage(named: "img_return_right")
        }
        case 2: do {
            BallLabel.frame.origin.x = Point2Label.frame.origin.x
            SecondPlayerStetusLabel.text = String(match.Podacha)+" подача"
            FirstPlayerStatusLabel.text = "Прием"
            Win2Button.setTitle("Эйс", for: .normal)
            Win1Button.setTitle("Виннер", for: .normal)
            Lose2Button.setTitle("Ошибка на подаче", for: .normal)
            Lose1Button.setTitle("Ошибка", for: .normal)
            SecondPlayerImage.image = UIImage(named: "img_serve_right")
            FirstPlayerImage.image = UIImage(named: "img_return_left")
        }
        default: BallLabel.frame.origin.x = Point1Label.frame.origin.x
        }
    }
    
    func NextSet() { // начало следующего сета
        match.SetNow+=1
        player1.gamesStat.append("")
        player2.gamesStat.append("")
        
        if match.TieBreak10 { // если закончился тайбрейк до 10
            ScoreLabel.text = "Очки" // восстанавливаем надпись
            player1.game = player1.point // счет сета записываем не 1:0 а по очкам тайбрейка
            player2.game = player2.point
        }
        
        player1.setScore = player1.setScore + String(player1.game) + " " // отображаем счет сета
        player2.setScore = player2.setScore + String(player2.game) + " "
        player1.game = 0 // обнуляем счет геймов у игроков
        player2.game = 0
        
        // если равенство по сетам 1:1 или 2:2, то начинаем решающий тайбрейк
        if (player1.set == player2.set)&&(player1.set == match.MaxSet - 1)&&(match.LastSetTieBreak10) {
            match.TieBreak10 = true //
            match.TieBreakPoint = -1 // сколько розыгрышей в тайбрейке прошло
            // в первом цикле увеличится на 1 и начнется с 0
            ScoreLabel.text = "ТБ(10)"
            match.MaxPoint = 10 // до 10 очков тайбрейк
        }
    }
    
    func ChangeGames( g1: Int, g2: Int) { // g1, g2 - изменение геймов 1-го и 2-го игроков
        // функция для пересчета геймов
        player1.game = player1.game + g1
        player2.game = player2.game + g2
        
        if !match.TieBreak10 { // если не тайбрейк10 то счет сета - по геймам
            player1.inGameScore[match.GameNow] = String(player1.game)
            player2.inGameScore[match.GameNow] = String(player2.game)
        } else { // если тайбрейк10 то счета сета - по очкам
            player1.inGameScore[match.GameNow] = String(player1.point)
            player2.inGameScore[match.GameNow] = String(player2.point)
        }
        
        if !match.TieBreak7 { // если закончился обычный гейм, не тайбрейк, то смена подачи
            if (match.PodaetNow == 1) { match.PodaetNow = 2}
            else { match.PodaetNow = 1} // смена подачи
            SmenaPodachiDraw()
        }
        
        if ((player1.game>=match.MaxGame)&&(player1.game - player2.game >= 2))||((player1.game==1)&&(match.TieBreak10)) {
            // игрок 1 набрал 6 или больше геймов с разницей в 2 гейма
            // или игрок 1 выиграл тайбрейк до 10
            player1.set+=1
            NextSet()
            if player1.set>=match.MaxSet { // если 1-й игрок выиграл 2 сета - сообщение о победе
                player1.name = FirstPlayerNameTextField.text ?? "Игрок1"
                showWinAlert(playerName: player1.name)
                match.Winner = 1
                FinishGame()
            }
        }
        if ((player2.game>=match.MaxGame)&&(player2.game - player1.game >= 2))||((player2.game==1)&&(match.TieBreak10))  {
            // игрок 2 набрал 6 или больше геймов с разницей в 2 гейма
            // или игрок 2 выиграл тайбрейк до 10
            player2.set+=1
            NextSet()
            if player2.set>=match.MaxSet { // если 2-й игрок выиграл 2 сета - сообщение о победе
                player2.name = SecondPlayerNameTextField.text ?? "Игрок2"
                showWinAlert(playerName: player2.name)
                match.Winner = 2
                FinishGame()
            }
        }
        if (player1.game == match.MaxGame) && (player2.game == match.MaxGame) {
            // при счете 6:6 по сэтам начинается тайбрейк до 7
            match.TieBreak7 = true
            match.TieBreakPoint = -1 // сколько розыгрышей в тайбрейке прошло
            // в первом цикле увеличится на 1 и начнется с 0
            match.TieBreakPodacha = match.PodaetNow // запоминаем на чьей подаче начался тайбрейк
            ScoreLabel.text = "ТБ(7)"
            match.MaxPoint = 7 // до 7 очков тайбрейк
        }
        if (player1.game + player2.game == 2 * match.MaxGame + 1) {
            // при счете 7:6 или 6:7 по геймам заканчивается тайбрейк
            match.TieBreak7 = false
            match.PodaetNow = match.TieBreakPodacha // возвращаем подачу тому кто начал тайбрейк
            // и только потом проводим смену подачи
            if (match.PodaetNow == 1) { match.PodaetNow = 2}
            else { match.PodaetNow = 1} // смена подачи
            SmenaPodachiDraw()
            ScoreLabel.text = "Очки"
            match.MaxPoint = 4 // до 4-х очков гейм 0/15/30/40
            player1.set = player1.set + (player1.game - match.MaxGame)
            player2.set = player2.set + (player2.game - match.MaxGame)
            NextSet()
            if player1.set>=match.MaxSet { // если 1-й игрок выиграл 2 сета - сообщение о победе
                player1.name = FirstPlayerNameTextField.text ?? "Игрок1"
                showWinAlert(playerName: player1.name)
                match.Winner = 1
                FinishGame()
            }
            if player2.set>=match.MaxSet { // если 2-й игрок выиграл 2 сета - сообщение о победе
                player2.name = SecondPlayerNameTextField.text ?? "Игрок2"
                showWinAlert(playerName: player2.name)
                match.Winner = 2
                FinishGame()
            }
        }
        match.GameNow+=1 // начинаем следующий гейм
        player1.stat.append(" ")
        player2.stat.append(" ")
        player1.inGameScore.append("0")
        player2.inGameScore.append("0")
        
    }
    
    func ChangePoints( p1: Int, p2 : Int) { // p1, p2 - изменение очков 1-го и 2-го игроков
        // функция для пересчета счета
        player1.point = player1.point + p1
        player2.point = player2.point + p2
        match.Podacha = 1 // снова первая подача
        
        if ((player1.point >= match.MaxPoint)&&(player1.point - player2.point >= 2))
        || ((player1.point == match.MaxPoint) && (player2.point == match.MaxPoint - 1) && (match.BolsheMenshe == false)) {
            // если игрок 1 набрал больше 40 очков, а у 2-го меньше 30 то
            // или 40:40 и решающее очко у 1-го то
            if (match.PodaetNow == 1)||(match.TieBreak7)||(match.TieBreak10) { // выиграл гейм на своей подаче
                // или выиграл тайбрейк
                player1.gamesStat[match.SetNow] = player1.gamesStat[match.SetNow] + "o"
            }
            else { // выиграл гейм на подаче соперника
                player1.gamesStat[match.SetNow] = player1.gamesStat[match.SetNow] + "★"
                player1.breakpoint+=1 // игрок 1 реализовал брейкпоинт
            }
            player2.gamesStat[match.SetNow] = player2.gamesStat[match.SetNow] + " "
            ChangeGames(g1: 1, g2: 0) // игрок 1 выиграл +1 гейм
            player1.point = 0 // обнуляем очки 1-го
            player2.point = 0 // и 2-го игроков чтоб следующий гнейм начался с нуля
        }
        
        if ((player2.point >= match.MaxPoint)&&(player2.point - player1.point >= 2))
        || ((player1.point == match.MaxPoint - 1) && (player2.point == match.MaxPoint) && (match.BolsheMenshe == false)) {
            // если игрок 2 набрал больше 40 очков, а у 1-го меньше 30 то
            // или 40:40 и решающее очко у 2-го то
            player1.gamesStat[match.SetNow] = player1.gamesStat[match.SetNow] + " "
            if (match.PodaetNow == 2)||(match.TieBreak7)||(match.TieBreak10) { // выиграл гейм на своей подаче
                // или выиграл тайбрейк
                player2.gamesStat[match.SetNow] = player2.gamesStat[match.SetNow] + "o"
            }
            else { // выиграл гейм на подаче соперника
                player2.gamesStat[match.SetNow] = player2.gamesStat[match.SetNow] + "★"
                player2.breakpoint+=1 // игрок 2 реализовал брейкпоинт
            }
            ChangeGames(g1: 0, g2: 1) // игрок 1 выиграл +1 гейм
            player1.point = 0 // обнуляем очки 1-го
            player2.point = 0 // и 2-го игроков чтоб следующий гнейм начался с нуля
        }
        
        if (player1.point == match.MaxPoint) && (player2.point == match.MaxPoint) && (match.TieBreak7 == false) && (match.TieBreak10 == false) { // если не тайбрейк, у кого то было больше и он проиграл очко, то счет 40:40
            player1.point = match.MaxPoint - 1
            player2.point = match.MaxPoint - 1
        }
        if (match.TieBreak7)||(match.TieBreak10) { // если идет тайбрейк до 7 или до 10
            match.TieBreakPoint+=1 // считаем какой по счету розыгрыш в тайбрейке закончился
            if match.TieBreakPoint % 2 == 1 { // если нечетный - то смена подачи
                if (match.PodaetNow == 1) { match.PodaetNow = 2}
                else { match.PodaetNow = 1} // смена подачи
                SmenaPodachiDraw()        }
        }
    }
    
    func UpdatePointsDraw() {
        // отображаем на экране текущие очки, геймы, сэты
        if (match.TieBreak7)||(match.TieBreak10) {
            Point1Label.text = String(player1.point)
            Point2Label.text = String(player2.point)
        } else {
            Point1Label.text = GamePoints[player1.point]
            Point2Label.text = GamePoints[player2.point]
        }
        Game1Label.text = String(player1.game)
        Game2Label.text = String(player2.game)
        Set1Label.text = String(player1.set)
        Set2Label.text = String(player2.set)
        Stat1Label.text = player1.stat[match.GameNow]
        Stat2Label.text = player2.stat[match.GameNow]
        GameStat1Label.text = player1.gamesStat[match.SetNow]
        GameStat2Label.text = player2.gamesStat[match.SetNow]
        Player1SetScoreLabel.text = player1.setScore
        Player2SetScoreLabel.text = player2.setScore
        switch match.Podacha { // какая подача (1/2) - столько и мячиков на экране
        case 1: BallLabel.text = "🎾"
        case 2: BallLabel.text = "🎾🎾"
        default: BallLabel.text = ""
        }
        
        switch match.PodaetNow { // пишем подающему какая у него подача 1/2
        case 1: do {
            FirstPlayerStatusLabel.text = String(match.Podacha)+" подача"
        }
        case 2: do {
            SecondPlayerStetusLabel.text = String(match.Podacha)+" подача"
        }
        default: FirstPlayerStatusLabel.text = String(match.Podacha)+" подача"
        }
        SmenaPodachiDraw() // отрисовка кто подает кто принимает
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
        BallLabel.translatesAutoresizingMaskIntoConstraints = true // чтоб можно было двигать метку
        BallLabel.frame.origin.x = Point1Label.frame.origin.x + Point1Label.frame.width - 30 // выставляем мячики первому игроку
        Lose1Button.titleLabel?.textAlignment = .center // выравнивание текста на кнопках по центру
        Lose2Button.titleLabel?.textAlignment = .center
        
        Win1Button.setFont(UIFont (name: "Arial Bold", size: 15)!) // корректный шрифт на кнопках
        Win2Button.setFont(UIFont (name: "Arial Bold", size: 15)!)
        Lose1Button.setFont(UIFont (name: "Arial Bold", size: 15)!)
        Lose2Button.setFont(UIFont (name: "Arial Bold", size: 15)!)
        
        UpdatePointsDraw() // прорисовываем очки, геймы, сэты
        player1.name = "Игрок1"
        player2.name = "Игрок2"
        match.TurnirName = "Турнир без названия"
        
        CurrentState.player1 = player1 // сохраняем состояние
        CurrentState.player2 = player2
        CurrentState.match = match
        MatchStates.append(CurrentState) // записываем текущее состояние в массив состояний
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // вызывается когда пользователь коснулся экрана
        super.touchesBegan(touches, with: event)
        view.endEditing(true) // убираем клавиатуру
        player1.name = FirstPlayerNameTextField.text ?? "Игрок1"
        if player1.name == "" { player1.name = "Игрок1" }
        player2.name = SecondPlayerNameTextField.text ?? "Игрок2"
        if player2.name == "" { player2.name = "Игрок2" }
        match.TurnirName = TurnirTextField.text ?? "Турнир без названия"
        if match.TurnirName == "" { match.TurnirName = "Турнир без названия" }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // вызывается при нажатии кнопки "готово"
        textField.resignFirstResponder()
        player1.name = FirstPlayerNameTextField.text ?? "Игрок1"
        if player1.name == "" { player1.name = "Игрок1" }
        player2.name = SecondPlayerNameTextField.text ?? "Игрок2"
        if player2.name == "" { player2.name = "Игрок2" }
        match.TurnirName = TurnirTextField.text ?? "Турнир без названия"
        if match.TurnirName == "" { match.TurnirName = "Турнир без названия" }
        return true
    }
    
    @IBAction func Win1ButtonPress(_ sender: Any) {
        // при нажатии кнопки победы 1-го игрока
        if (sender as? UIButton)?.titleLabel?.text == "Виннер" { player1.winners+=1 } // считаем виннеры 1-го игрока
        if (sender as? UIButton)?.titleLabel?.text == " Выиграно очко" { player1.totalPoints+=1 } // считаем выигранные очки 1-го игрока
        
        if (match.PodaetNow == 1) && (match.Podacha == 2) {
            // вторая подача - заменяем символ
            player1.stat[match.GameNow].removeLast() // убираем .
            player2.stat[match.GameNow].removeLast()
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player1.stat[match.GameNow] = player1.stat[match.GameNow] + "Ạ" // игрок 1 подал эйс на 2-й подаче
                player1.aces+=1
            }
            else {
                player1.stat[match.GameNow] = player1.stat[match.GameNow] + "!" // игрок 1 выиграл 2-ю подачу после проигранной 1-й
            }
            player2.stat[match.GameNow] = player2.stat[match.GameNow] + " "
        }
        else {
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player1.stat[match.GameNow] = player1.stat[match.GameNow] + "A" // игрок 1 подал эйс на 1-й подаче
                player1.aces+=1
                player1.vsegoPodach+=1 // +1 подача первого
                player2.stat[match.GameNow] = player2.stat[match.GameNow] + " "
            }
            else {
                if match.Podacha == 1 {
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + "/" // игрок 1 просто выиграл розыгрыш
                    if (match.PodaetNow == 1) { player1.vsegoPodach+=1} // +1 подача первого
                    if (match.PodaetNow == 2) { player2.vsegoPodach+=1} // +1 подача второго
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + " "
                }
                else {
                    player1.stat[match.GameNow].removeLast()
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + "/"
                }
            }
        }
        ChangePoints(p1: 1, p2: 0)
        UpdatePointsDraw()
        SaveState()
    }
    
    @IBAction func Lose1ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 1-го игрока
        if (match.PodaetNow == 1) && (match.Podacha == 1) && ((sender as? UIButton)?.titleLabel?.text == "Ошибка на подаче" ) { // если подает 1-й и ошибка на подаче то
            match.Podacha = 2 // 2-я подача
            player1.podach2+=1
            player1.vsegoPodach+=1 // +1 подача первого
            player1.stat[match.GameNow] = player1.stat[match.GameNow] + "."
            player2.stat[match.GameNow] = player2.stat[match.GameNow] + " "
        }
        else { // ошибка 1-го на 2-й подаче = выигранное очко 2-го
            if (match.PodaetNow == 1) && ((sender as? UIButton)?.titleLabel?.text == "Ошибка на подаче" )  {
                player2.stat[match.GameNow].removeLast()
                player2.stat[match.GameNow] = player2.stat[match.GameNow] + "D" // двойная ошибка
                player1.doubleFaults+=1 // считаем двойные ошибки для статистики
            }
            if (match.PodaetNow == 2) {
                if match.Podacha == 2 {
                    player2.stat[match.GameNow].removeLast() // убираем .
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + "!"
                    player1.ufe+=1 // считаем невынужденные ошибки первого
                }
                else {
                    player2.vsegoPodach+=1 // +1 подача второго
                    player1.ufe+=1 // считаем невынужденные ошибки первого
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + "/"
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + " "
                }
            }
            if (match.PodaetNow == 1) && ((sender as? UIButton)?.titleLabel?.text == "Ошибка" ) {
                
                player1.ufe+=1 // считаем невынужденные ошибки первого
                if match.Podacha == 2 {
                    player2.stat[match.GameNow].removeLast() // убираем " "
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + "/" }
                else {
                    player1.vsegoPodach+=1 // +1 подача первого
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + "/"
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + " " }
            }
            ChangePoints(p1: 0, p2: 1)
        }
        UpdatePointsDraw()
        SaveState()
    }
    
    @IBAction func Win2ButtonPress(_ sender: Any) {
        // при нажатии кнопки победы 2-го игрока
        if (sender as? UIButton)?.titleLabel?.text == "Виннер" { player2.winners+=1 } // считаем виннеры 2-го игрока
        if (sender as? UIButton)?.titleLabel?.text == " Выиграно очко" { player2.totalPoints+=1 } // считаем выигранные очки 2-го игрока
        if (match.PodaetNow == 2) && (match.Podacha == 2) {
            // вторая подача - заменяем символ
            player2.stat[match.GameNow].removeLast() // убираем .
            player1.stat[match.GameNow].removeLast()
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player2.stat[match.GameNow] = player2.stat[match.GameNow] + "Ạ" // игрок 2 подал эйс на 2-й подаче
                player2.aces+=1
            }
            else {
                player2.stat[match.GameNow] = player2.stat[match.GameNow] + "!" // игрок 2 выиграл 2-ю подачу после проигранной 1-й
            }
            player1.stat[match.GameNow] = player1.stat[match.GameNow] + " "
        }
        else {
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player2.stat[match.GameNow] = player2.stat[match.GameNow] + "A" // игрок 2 подал эйс на 1-й подаче
                player2.aces+=1
                player2.vsegoPodach+=1 // +1 подача второго
                player1.stat[match.GameNow] = player1.stat[match.GameNow] + " "
            }
            else {
                if match.Podacha == 1 {
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + "/" // игрок 2 просто выиграл розыгрыш
                    if (match.PodaetNow == 1) {player1.vsegoPodach+=1} // +1 подача первого
                    if (match.PodaetNow == 2) { player2.vsegoPodach+=1} // +1 подача второго
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + " "
                } else {
                    player2.stat[match.GameNow].removeLast()
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + "/"
                }
            }
        }
        ChangePoints(p1: 0, p2: 1)
        UpdatePointsDraw()
        SaveState()
    }
    
    @IBAction func Lose2ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 2-го игрока
        if (match.PodaetNow == 2) && (match.Podacha == 1) && ((sender as? UIButton)?.titleLabel?.text == "Ошибка на подаче" )  { // если подает 2-й и ошибка на подаче то
            match.Podacha = 2 // 2-я подача
            player2.podach2+=1
            player2.vsegoPodach+=1 // +1 подача второго
            player2.stat[match.GameNow] = player2.stat[match.GameNow] + "."
            player1.stat[match.GameNow] = player1.stat[match.GameNow] + " "
        }
        else {
            // ошибка 2-го на 2-й подаче = выигранное очко 1-го
            if (match.PodaetNow == 2) && ((sender as? UIButton)?.titleLabel?.text == "Ошибка на подаче" )  {
                player1.stat[match.GameNow].removeLast()
                player1.stat[match.GameNow] = player1.stat[match.GameNow] + "D" // двойная ошибка
                player2.doubleFaults+=1 // считаем двойные ошибки для статистики
            }
            if (match.PodaetNow == 1) {
                if match.Podacha == 2 {
                    player1.stat[match.GameNow].removeLast() // убираем .
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + "!"
                    player2.ufe+=1 // считаем невынужденные ошибки второго
                }
                else {
                    player1.vsegoPodach+=1 // +1 подача первого
                    player2.ufe+=1 // считаем невынужденные ошибки второго
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + "/"
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + " "
                }
            }
            if (match.PodaetNow == 2) && ((sender as? UIButton)?.titleLabel?.text == "Ошибка" ) {
                
                player2.ufe+=1 // считаем невынужденные ошибки второго
                if match.Podacha == 2 {
                    player1.stat[match.GameNow].removeLast() // убираем " "
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + "/" }
                else {
                    player2.vsegoPodach+=1 // +1 подача второго
                    player1.stat[match.GameNow] = player1.stat[match.GameNow] + "/"
                    player2.stat[match.GameNow] = player2.stat[match.GameNow] + " " }
            }
            ChangePoints(p1: 1, p2: 0)
        }
        UpdatePointsDraw()
        SaveState()
    }
    
    @IBAction func FirstPlayerImageButtonPress(_ sender: Any) {
        FirstPlayerStatusLabel.text = "Игра"
        SecondPlayerStetusLabel.text = "Игра"
        Win1Button.setTitle("Виннер", for: .normal)
        Win2Button.setTitle("Виннер", for: .normal)
        Lose1Button.setTitle("Ошибка", for: .normal)
        Lose2Button.setTitle("Ошибка", for: .normal)
        FirstPlayerImage.image = UIImage(named: "img_stroke_left")
        SecondPlayerImage.image = UIImage(named: "img_stroke_right")
        SaveState()
    }
    
    @IBAction func UndoButtonPress(_ sender: Any) { // отменить последнее действие
        RestoreState()
        UpdatePointsDraw()
    }
    
    @IBAction func SwapButtonPress(_ sender: Any) { // поменять игроков местами
        
    }
}

