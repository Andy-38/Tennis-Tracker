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
    var MaxPoint: Int = 4 // до 4-х очков в гейме 0/15/30/40
    var Podacha: Int = 1 // какая сейчас подача 1/2
    var player1point: Int = 0 // очки 1-го игрока
    var player2point: Int = 0 // очки 2-го игрока
    var player1game: Int = 0 // геймы 1-го игрока
    var player2game: Int = 0 // геймы 2-го игрока
    var player1set: Int = 0 // сэты 1-го игрока
    var player2set: Int = 0 // сэты 2-го игрока
    var TieBreak7: Bool = false // идет ли сейчас тайбрейк в сэте
    
    @IBOutlet weak var TurnirTextField: UITextField! // поле ввода названия турнира
    @IBOutlet weak var FirstPlayerNameTextField: UITextField! // поле ввода имени 1-го игрока
    @IBOutlet weak var SecondPlayerNameTextField: UITextField! // поле ввода имени 2-го игрока
    
    @IBOutlet weak var Win1Button: UIButton! // кнопка победы 1-го игрока
    @IBOutlet weak var Lose1Button: UIButton! // кнопка проигрыша 1-го игрока
    @IBOutlet weak var Win2Button: UIButton! // кнопка победы 2-го игрока
    @IBOutlet weak var Lose2Button: UIButton! // кнопка проигрыша 2-го игрока
    
    @IBOutlet weak var Set1Label: UILabel! // количество сетов 1-го игрока
    @IBOutlet weak var Set2Label: UILabel! // количество сетов 2-го игрока
    @IBOutlet weak var Game1Label: UILabel! // количество геймов 1-го игрока
    @IBOutlet weak var Game2Label: UILabel! // количество геймов 2-го игрока
    @IBOutlet weak var Point1Label: UILabel! // количество очков 1-го игрока
    @IBOutlet weak var Point2Label: UILabel! // количество очков 2-го игрока
    @IBOutlet weak var ScoreLabel: UILabel! // индикатор очков 0/15/30/40 или тайбрейка
    @IBOutlet weak var FirstPlayerStatusLabel: UILabel! // подача или прием у 1-го игрока
    @IBOutlet weak var BallLabel: UILabel! // один или два мячика - ндикатор подачи
    
    
    
    func ChangeGames( g1: Int, g2: Int) { // g1, g2 - изменение геймов 1-го и 2-го игроков
        // функция для пересчета геймов
        player1game = player1game + g1
        player2game = player2game + g2
        if (player1game>=MaxGame)&&(player1game - player2game >= 2) {
            // игрок 1 набрал 6 или больше геймов с разницей в 2 гейма
            player1set+=1
            player1game = 0
            player2game = 0
        }
        if (player2game>=MaxGame)&&(player2game - player1game >= 2) {
            // игрок 2 набрал 6 или больше геймов с разницей в 2 гейма
            player2set+=1
            player1game = 0
            player2game = 0
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
            player1game = 0
            player2game = 0
        }
    }
    
    func ChangePoints( p1: Int, p2 : Int) { // p1, p2 - изменение очков 1-го и 2-го игроков
        // функция для пересчета счета
        player1point = player1point + p1
        player2point = player2point + p2
        Podacha = 1 // снова первая подача
        
        if (player1point >= MaxPoint)&&(player1point - player2point >= 2) { // если игрок 1 набрал больше 40 очков, а у 2-го меньше 30 то
            //player1game+=1
            ChangeGames(g1: 1, g2: 0) // игрок 1 выиграл +1 гейм
            player1point = 0 // обнуляем очки 1-го
            player2point = 0 // и 2-го игроков чтоб следующий гнейм начался с нуля
        }
        
        if (player2point >= MaxPoint)&&(player2point - player1point >= 2) { // если игрок 2 набрал больше 40 очков, а у 1-го меньше 30 то
            //player2game+=1 // игрок 2 выиграл +1 гейм
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
        FirstPlayerStatusLabel.text = String(Podacha)+" подача"
        if Podacha == 1 { BallLabel.text = "🎾"}
        else { BallLabel.text = "🎾🎾"}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // TurnirTextField.delegate = self
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
        ChangePoints(p1: 1, p2: 0)
        UpdatePoints()
    }
    
    @IBAction func Lose1ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 1-го игрока
        if Podacha == 1 {
            Podacha = 2 // 2-я подача
        }
        else {
            ChangePoints(p1: 0, p2: 1) // ошибка на 2-й подаче = выигранное очко
        }
        UpdatePoints()
    }
    
    @IBAction func Win2ButtonPress(_ sender: Any) {
        // при нажатии кнопки победы 2-го игрока
        ChangePoints(p1: 0, p2: 1)
        UpdatePoints()
    }
    
    @IBAction func Lose2ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 2-го игрока
        ChangePoints(p1: 1, p2: 0)
        UpdatePoints()
    }
}

