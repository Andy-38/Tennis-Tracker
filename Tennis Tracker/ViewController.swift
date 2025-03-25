//
//  ViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 18.04.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let GamePoints = ["0", "15", "30", "40", "AD", "0"] // счет
    let MaxGame = 6 // игра до 6 геймов в сэте
    let MaxSet = 2 // игра до победы в 2-х сэтах
    
    var MaxPoint: Int = 4 // до 4-х очков в гейме 0/15/30/40
    var Podacha: Int = 1 // какая сейчас подача 1-я/2-я
    var PodaetNow: Int = 1 // кто сейчас подает 1/2 игрок
    var player1point: Int = 0 // очки 1-го игрока
    var player2point: Int = 0 // очки 2-го игрока
    var player1game: Int = 0 // геймы 1-го игрока
    var player2game: Int = 0 // геймы 2-го игрока
    var player1set: Int = 0 // сэты 1-го игрока
    var player2set: Int = 0 // сэты 2-го игрока
    var TieBreak7: Bool = false // идет ли сейчас тайбрейк в сэте
    var GameNow: Int = 1 // какой сейчас идет гейм
    var SetNow: Int = 1 // какой сейчас идет сет
    var player1stat: [String] = [" ", " "] // статистика очков 1-го игрока
    var player2stat: [String] = [" ", " "] // статистика очков 2-го игрока
    var player1gamesStat: [String] = ["", ""] // статистика геймов 1-го игрока
    var player2gamesStat: [String] = ["", ""] // статистика геймов 2-го игрока
    var player1setScore: String = "" // статистика геймов в сете для 1-го игрока
    var player2setScore: String = "" // статистика геймов в сете для 2-го игрока
    
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
    }
    
    func showWinAlert(playerName : String) { // показывает сообщение о победе игрока
        let alertController = UIAlertController(title: "Матч окончен", message: "Победитель матча: "+playerName, preferredStyle: .alert) // создаем алерт-контроллер
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil) // создаем действие "ОК"
        alertController.addAction(defaultAction) // добавляем действие к алерт-контроллеру
        present(alertController, animated: true, completion: nil) // отображаем алерт-контроллер
    }
    
    func SmenaPodachi () { // при смене подачи
        switch PodaetNow {
        case 1: do {
            BallLabel.frame.origin.x = Point1Label.frame.origin.x + Point1Label.frame.width - 30
            FirstPlayerStatusLabel.text = String(Podacha)+" подача"
            SecondPlayerStetusLabel.text = "Прием"
            Win1Button.setTitle("Эйс", for: .normal)
            Win2Button.setTitle("Виннер", for: .normal)
            FirstPlayerImage.image = UIImage(named: "img_serve_left")
            SecondPlayerImage.image = UIImage(named: "img_return_right")
        }
        case 2: do {
            BallLabel.frame.origin.x = Point2Label.frame.origin.x
            SecondPlayerStetusLabel.text = String(Podacha)+" подача"
            FirstPlayerStatusLabel.text = "Прием"
            Win2Button.setTitle("Эйс", for: .normal)
            Win1Button.setTitle("Виннер", for: .normal)
            SecondPlayerImage.image = UIImage(named: "img_serve_right")
            FirstPlayerImage.image = UIImage(named: "img_return_left")
        }
        default: BallLabel.frame.origin.x = Point1Label.frame.origin.x
        }
    }
    
    func NextSet() { // начало следующего сета
        SetNow+=1
        player1gamesStat.append("")
        player2gamesStat.append("")
        player1setScore = player1setScore + String(player1game) + " "
        player2setScore = player2setScore + String(player2game) + " "
        player1game = 0
        player2game = 0
    }
    
    func ChangeGames( g1: Int, g2: Int) { // g1, g2 - изменение геймов 1-го и 2-го игроков
        // функция для пересчета геймов
        player1game = player1game + g1
        player2game = player2game + g2
        if (PodaetNow == 1) { PodaetNow = 2}
        else { PodaetNow = 1} // смена подачи
        SmenaPodachi()
        
        if (player1game>=MaxGame)&&(player1game - player2game >= 2) {
            // игрок 1 набрал 6 или больше геймов с разницей в 2 гейма
            player1set+=1
            NextSet()
            /*
            SetNow+=1
            player1gamesStat.append("")
            player2gamesStat.append("")
            player1game = 0
            player2game = 0
            */
            if player1set>=MaxSet { // если 1-й игрок выиграл 2 сета - сообщение о победе
                showWinAlert(playerName: FirstPlayerNameTextField.text ?? "Игрок1")
                FinishGame()
            }
        }
        if (player2game>=MaxGame)&&(player2game - player1game >= 2) {
            // игрок 2 набрал 6 или больше геймов с разницей в 2 гейма
            player2set+=1
            NextSet()
            /*
            SetNow+=1
            player1gamesStat.append("")
            player2gamesStat.append("")
            player1game = 0
            player2game = 0
            */
            if player2set>=MaxSet { // если 2-й игрок выиграл 2 сета - сообщение о победе
                showWinAlert(playerName: SecondPlayerNameTextField.text ?? "Игрок2")
                FinishGame()
            }
        }
        if (player1game == MaxGame) && (player2game == MaxGame) {
            // при счете 6:6 по сэтам начинается тайбрейк
            TieBreak7 = true
            ScoreLabel.text = "ТБ(7)"
            MaxPoint = 7 // до 7 очков тайбрейк
        }
        if (player1game + player2game == 2 * MaxGame + 1) {
            // при счете 7:6 или 6:7 по сэтам заканчивается тайбрейк
            TieBreak7 = false
            ScoreLabel.text = "Очки"
            MaxPoint = 4 // до 4-х очков гейм 0/15/30/40
            player1set = player1set + (player1game - MaxGame)
            player2set = player2set + (player2game - MaxGame)
            NextSet()
            /*
            SetNow+=1
            player1gamesStat.append("")
            player2gamesStat.append("")
            player1game = 0
            player2game = 0
            */
            
            if player1set>=MaxSet { // если 1-й игрок выиграл 2 сета - сообщение о победе
                showWinAlert(playerName: FirstPlayerNameTextField.text ?? "Игрок1")
                FinishGame()
            }
            if player2set>=MaxSet { // если 2-й игрок выиграл 2 сета - сообщение о победе
                showWinAlert(playerName: SecondPlayerNameTextField.text ?? "Игрок2")
                FinishGame()
            }
        }
        GameNow+=1 // начинаем следующий гейм
        player1stat.append(" ")
        player2stat.append(" ")
    }
    
    func ChangePoints( p1: Int, p2 : Int) { // p1, p2 - изменение очков 1-го и 2-го игроков
        // функция для пересчета счета
        player1point = player1point + p1
        player2point = player2point + p2
        Podacha = 1 // снова первая подача
        
        if (player1point >= MaxPoint)&&(player1point - player2point >= 2) { // если игрок 1 набрал больше 40 очков, а у 2-го меньше 30 то
            player1gamesStat[SetNow] = player1gamesStat[SetNow] + "o"
            player2gamesStat[SetNow] = player2gamesStat[SetNow] + " "
            ChangeGames(g1: 1, g2: 0) // игрок 1 выиграл +1 гейм
            player1point = 0 // обнуляем очки 1-го
            player2point = 0 // и 2-го игроков чтоб следующий гнейм начался с нуля
        }
        
        if (player2point >= MaxPoint)&&(player2point - player1point >= 2) { // если игрок 2 набрал больше 40 очков, а у 1-го меньше 30 то
            player1gamesStat[SetNow] = player1gamesStat[SetNow] + " "
            player2gamesStat[SetNow] = player2gamesStat[SetNow] + "o"
            ChangeGames(g1: 0, g2: 1) // игрок 1 выиграл +1 гейм
            player1point = 0 // обнуляем очки 1-го
            player2point = 0 // и 2-го игроков чтоб следующий гнейм начался с нуля
        }
        
        if (player1point == MaxPoint)&&(player2point == MaxPoint)&&(TieBreak7 == false) { // если не тайбрейк, у кого то было больше и он проиграл очко, то счет 40:40
            player1point = 3
            player2point = 3
        }
    }
    
    func UpdatePoints() {
        // отображаем на экране текущие очки, геймы, сэты
        if TieBreak7 {
            Point1Label.text = String(player1point)
            Point2Label.text = String(player2point)
        } else {
            Point1Label.text = GamePoints[player1point]
            Point2Label.text = GamePoints[player2point]
        }
        Game1Label.text = String(player1game)
        Game2Label.text = String(player2game)
        Set1Label.text = String(player1set)
        Set2Label.text = String(player2set)
        Stat1Label.text = player1stat[GameNow]
        Stat2Label.text = player2stat[GameNow]
        GameStat1Label.text = player1gamesStat[SetNow]
        GameStat2Label.text = player2gamesStat[SetNow]
        Player1SetScoreLabel.text = player1setScore
        Player2SetScoreLabel.text = player2setScore
        switch Podacha { // какая подача (1/2) - столько и мячиков на экране
        case 1: BallLabel.text = "🎾"
        case 2: BallLabel.text = "🎾🎾"
        default: BallLabel.text = ""
        }
        
        switch PodaetNow { // чья подача - тому и рисуем мячики
        case 1: do {
        //   BallLabel.frame.origin.x = Point1Label.frame.origin.x + Point1Label.frame.width - 30
            FirstPlayerStatusLabel.text = String(Podacha)+" подача"
        //    SecondPlayerStetusLabel.text = "Прием"
        //    Win1Button.setTitle("Эйс", for: .normal)
        //    Win2Button.setTitle("Виннер", for: .normal)
        //    FirstPlayerImage.image = UIImage(named: "img_serve_left")
        //    SecondPlayerImage.image = UIImage(named: "img_return_right")
        }
        case 2: do {
        //    BallLabel.frame.origin.x = Point2Label.frame.origin.x
            SecondPlayerStetusLabel.text = String(Podacha)+" подача"
        //    FirstPlayerStatusLabel.text = "Прием"
        //    Win2Button.setTitle("Эйс", for: .normal)
        //    Win1Button.setTitle("Виннер", for: .normal)
        //    SecondPlayerImage.image = UIImage(named: "img_serve_right")
        //    FirstPlayerImage.image = UIImage(named: "img_return_left")
        }
        default: BallLabel.frame.origin.x = Point1Label.frame.origin.x
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
        BallLabel.translatesAutoresizingMaskIntoConstraints = true // чтоб можно было двигать метку
        BallLabel.frame.origin.x = Point1Label.frame.origin.x + Point1Label.frame.width - 30 // выставляем мячики первому игроку
        UpdatePoints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // вызывается когда пользователь коснулся экрана
        super.touchesBegan(touches, with: event)
        view.endEditing(true) // убираем клавиатуру
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // вызывается при нажатии кнопки "готово"
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func Win1ButtonPress(_ sender: Any) {
        // при нажатии кнопки победы 1-го игрока
        if (PodaetNow == 1) && (Podacha == 2) {
            // вторая подача - заменяем символ
            player1stat[GameNow].removeLast() // убираем .
            player2stat[GameNow].removeLast()
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player1stat[GameNow] = player1stat[GameNow] + "Ạ" // игрок 1 подал эйс на 2-й подаче
            }
            else {
                player1stat[GameNow] = player1stat[GameNow] + "!" // игрок 1 выиграл 2-ю подачу после проигранной 1-й
            }
            player2stat[GameNow] = player2stat[GameNow] + " "
        }
        else {
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player1stat[GameNow] = player1stat[GameNow] + "A" // игрок 1 подал эйс на 1-й подаче
                player2stat[GameNow] = player2stat[GameNow] + " "
            }
            else {
                if Podacha == 1 {
                    player1stat[GameNow] = player1stat[GameNow] + "/" // игрок 1 просто выиграл розыгрыш
                    player2stat[GameNow] = player2stat[GameNow] + " "
                }
                else {
                    player1stat[GameNow].removeLast()
                    player1stat[GameNow] = player1stat[GameNow] + "/"
                }
            }
        }
        //player2stat[GameNow] = player2stat[GameNow] + " "
        ChangePoints(p1: 1, p2: 0)
        UpdatePoints()
    }
    
    @IBAction func Lose1ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 1-го игрока
        if (PodaetNow == 1) && (Podacha == 1) { // если подает 1-й и ошибка на подаче то
            Podacha = 2 // 2-я подача
            player1stat[GameNow] = player1stat[GameNow] + "."
            player2stat[GameNow] = player2stat[GameNow] + " "
        }
        else { // ошибка 1-го на 2-й подаче = выигранное очко 2-го
            if (PodaetNow == 1) {
                player2stat[GameNow].removeLast()
                player2stat[GameNow] = player2stat[GameNow] + "D" // двойная ошибка
            }
            if (PodaetNow == 2) {
                if Podacha == 2 {
                    player2stat[GameNow].removeLast() // убираем .
                    player2stat[GameNow] = player2stat[GameNow] + "!"
                }
                else {
                    player2stat[GameNow] = player2stat[GameNow] + "/"
                    player1stat[GameNow] = player1stat[GameNow] + " "
                }
                
                //player2stat = player2stat + "/"
                //player1stat = player1stat + " "
            }
            ChangePoints(p1: 0, p2: 1)
        }
        UpdatePoints()
    }
    
    @IBAction func Win2ButtonPress(_ sender: Any) {
        // при нажатии кнопки победы 2-го игрока
        if (PodaetNow == 2) && (Podacha == 2) {
            // вторая подача - заменяем символ
            player2stat[GameNow].removeLast() // убираем .
            player1stat[GameNow].removeLast()
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player2stat[GameNow] = player2stat[GameNow] + "Ạ" // игрок 2 подал эйс на 2-й подаче
            }
            else {
                player2stat[GameNow] = player2stat[GameNow] + "!" // игрок 2 выиграл 2-ю подачу после проигранной 1-й
            }
            player1stat[GameNow] = player1stat[GameNow] + " "
        }
        else {
            if (sender as? UIButton)?.titleLabel?.text == "Эйс" {
                player2stat[GameNow] = player2stat[GameNow] + "A" // игрок 2 подал эйс на 1-й подаче
                player1stat[GameNow] = player1stat[GameNow] + " "
            }
            else {
                if Podacha == 1 {
                    player2stat[GameNow] = player2stat[GameNow] + "/" // игрок 2 просто выиграл розыгрыш
                    player1stat[GameNow] = player1stat[GameNow] + " "
                } else {
                    player2stat[GameNow].removeLast()
                    player2stat[GameNow] = player2stat[GameNow] + "/"
                }
            }
        }
        //player1stat[GameNow] = player1stat[GameNow] + " "
        
        ChangePoints(p1: 0, p2: 1)
        //player2stat = player2stat + "/"
        //player1stat = player1stat + " "
        UpdatePoints()
    }
    
    @IBAction func Lose2ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 2-го игрока
        if (PodaetNow == 2) && (Podacha == 1) { // если подает 2-й и ошибка на подаче то
            Podacha = 2 // 2-я подача
            player2stat[GameNow] = player2stat[GameNow] + "."
            player1stat[GameNow] = player1stat[GameNow] + " "
        }
        else {
            // ошибка 2-го на 2-й подаче = выигранное очко 1-го
            if (PodaetNow == 2) {
                player1stat[GameNow].removeLast()
                player1stat[GameNow] = player1stat[GameNow] + "D" // двойная ошибка
            }
            if (PodaetNow == 1) {
                if Podacha == 2 {
                    player1stat[GameNow].removeLast() // убираем .
                    player1stat[GameNow] = player1stat[GameNow] + "!"
                }
                else {
                    player1stat[GameNow] = player1stat[GameNow] + "/"
                    player2stat[GameNow] = player2stat[GameNow] + " "
                }
            }
            ChangePoints(p1: 1, p2: 0)
        }
        UpdatePoints()
    }
    
    @IBAction func SwapButtonPress(_ sender: Any) { // поменять игроков местами
       // "Data to share".share()
        let items = ["Протокол матча"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(ac, animated: true, completion: nil)
    }
}

