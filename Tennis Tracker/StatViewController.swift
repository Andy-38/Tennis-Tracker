//
//  StatViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 30.03.2025.
//

import UIKit

class StatViewController: UIViewController {
    
    @IBOutlet weak var TurnirNameLabel: UILabel! // название турнира
    @IBOutlet weak var Player1nameLabel: UILabel! // имя 1-го игрока
    @IBOutlet weak var Player2nameLabel: UILabel! // имя 2-го игрока
    @IBOutlet weak var Player1doubleFaultLabel: UILabel! // двойные ошибки 1-го
    @IBOutlet weak var Player2doubleFaultLabel: UILabel! // двойные ошибки 2-го
    @IBOutlet weak var Player1aceLabel: UILabel! // эйсы 1-го
    @IBOutlet weak var Player2aceLabel: UILabel! // эйсы 2-го
    @IBOutlet weak var Player1firstLabel: UILabel! // % первой подачи 1-го
    @IBOutlet weak var Player2firstLabel: UILabel! // % первой подачи 2-го
    @IBOutlet weak var Player1secondLabel: UILabel! // % второй подачи 1-го
    @IBOutlet weak var Player2secondLabel: UILabel! // % второй подачи 2-го
    @IBOutlet weak var Player1winnerLabel: UILabel! // виннеры 1-го
    @IBOutlet weak var Player2winnerLabel: UILabel! // виннеры 2-го
    @IBOutlet weak var Player1ufeLabel: UILabel! // невынужденные ошибки 1-го
    @IBOutlet weak var Player2ufeLabel: UILabel! // невынужденные ошибки 2-го
    @IBOutlet weak var Player1breakpointLabel: UILabel! // брейкпоинты 1-го
    @IBOutlet weak var Player2breakpointLabel: UILabel! // брейкпоинты 2-го
    @IBOutlet weak var Player1pointsLabel: UILabel! // очки 1-го
    @IBOutlet weak var Player2pointsLabel: UILabel! // очки 2-го
    @IBOutlet weak var ShareButton: UIButton! // кнопка поделиться
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // выполняется при отображении экрана
        TurnirNameLabel.text = match.TurnirName
        // игроки, победитель - зеленым цветом
        Player1nameLabel.text = player1.name
        Player2nameLabel.text = player2.name
        
        switch match.Winner {
        case 1: do {
            Player1nameLabel.textColor = .systemGreen
            Player2nameLabel.textColor = .white
        }
        case 2: do {
            Player1nameLabel.textColor = .white
            Player2nameLabel.textColor = .systemGreen
        }
        default: do {// если матч не закончился
            Player1nameLabel.textColor = .white
            Player2nameLabel.textColor = .white
        }
        }
        
        // двойные ошибки
        Player1doubleFaultLabel.text = String(player1.doubleFaults)
        Player2doubleFaultLabel.text = String(player2.doubleFaults)
        if player1.doubleFaults>player2.doubleFaults {
            Player1doubleFaultLabel.textColor = .white
            Player2doubleFaultLabel.textColor = .systemGreen
        }
        else if player1.doubleFaults<player2.doubleFaults
        {
            Player2doubleFaultLabel.textColor = .white
            Player1doubleFaultLabel.textColor = .systemGreen
        }
        else {
            Player2doubleFaultLabel.textColor = .white
            Player1doubleFaultLabel.textColor = .white
        }
        
        // эйсы
        Player1aceLabel.text = String(player1.aces)
        Player2aceLabel.text = String(player2.aces)
        if player1.aces>player2.aces {
            Player2aceLabel.textColor = .white
            Player1aceLabel.textColor = .systemGreen
        }
        else if player1.aces<player2.aces
        {
            Player1aceLabel.textColor = .white
            Player2aceLabel.textColor = .systemGreen
        }
        else {
            Player2aceLabel.textColor = .white
            Player1aceLabel.textColor = .white
        }
        
        // первые подачи
        Player1firstLabel.text = String(player1.percent1)
        Player2firstLabel.text = String(player2.percent1)
        if player1.percent1>player2.percent1 {
            Player2firstLabel.textColor = .white
            Player1firstLabel.textColor = .systemGreen
        }
        else if player1.percent1<player2.percent1
        {
            Player1firstLabel.textColor = .white
            Player2firstLabel.textColor = .systemGreen
        }
        else {
            Player2firstLabel.textColor = .white
            Player1firstLabel.textColor = .white
        }
        
        // вторые подачи
        Player1secondLabel.text = String(player1.percent2)
        Player2secondLabel.text = String(player2.percent2)
        if player1.percent2>player2.percent2 {
            Player2secondLabel.textColor = .white
            Player1secondLabel.textColor = .systemGreen
        }
        else if player1.percent2<player2.percent2
        {
            Player1secondLabel.textColor = .white
            Player2secondLabel.textColor = .systemGreen
        }
        else {
            Player2secondLabel.textColor = .white
            Player1secondLabel.textColor = .white
        }
        
        // виннерсы
        Player1winnerLabel.text = String(player1.winners)
        Player2winnerLabel.text = String(player2.winners)
        if player1.winners>player2.winners {
            Player2winnerLabel.textColor = .white
            Player1winnerLabel.textColor = .systemGreen
        }
        else if player1.winners<player2.winners
        {
            Player1winnerLabel.textColor = .white
            Player2winnerLabel.textColor = .systemGreen
        }
        else {
            Player2winnerLabel.textColor = .white
            Player1winnerLabel.textColor = .white
        }
        
        // невынужденные ошибки
        Player1ufeLabel.text = String(player1.ufe)
        Player2ufeLabel.text = String(player2.ufe)
        if player1.ufe > player2.ufe {
            Player1ufeLabel.textColor = .white
            Player2ufeLabel.textColor = .systemGreen
        }
        else if player1.ufe < player2.ufe
        {
            Player2ufeLabel.textColor = .white
            Player1ufeLabel.textColor = .systemGreen
        }
        else {
            Player2ufeLabel.textColor = .white
            Player1ufeLabel.textColor = .white
        }
        
        // очки
        let player1totalPoints = player1.totalPoints + player1.aces + player1.winners + player2.doubleFaults + player2.ufe
        let player2totalPoints = player2.totalPoints + player2.aces + player2.winners + player1.doubleFaults + player1.ufe
        Player1pointsLabel.text = String(player1totalPoints)
        Player2pointsLabel.text = String(player2totalPoints)
        if player1totalPoints>player2totalPoints {
            Player2pointsLabel.textColor = .white
            Player1pointsLabel.textColor = .systemGreen
        }
        else if player1totalPoints<player2totalPoints
        {
            Player1pointsLabel.textColor = .white
            Player2pointsLabel.textColor = .systemGreen
        }
        else {
            Player2pointsLabel.textColor = .white
            Player1pointsLabel.textColor = .white
        }
        
        // брейкпоинты
        Player1breakpointLabel.text = String(player1.breakpoint)
        Player2breakpointLabel.text = String(player2.breakpoint)
        if player1.breakpoint>player2.breakpoint {
            Player2breakpointLabel.textColor = .white
            Player1breakpointLabel.textColor = .systemGreen
        }
        else if player1.breakpoint<player2.breakpoint
        {
            Player1breakpointLabel.textColor = .white
            Player2breakpointLabel.textColor = .systemGreen
        }
        else {
            Player2breakpointLabel.textColor = .white
            Player1breakpointLabel.textColor = .white
        }
    }
    
    @IBAction func ShareButtonPress(_ sender: Any) { // поделиться статистикой
        ShareButton.isHidden = true // скрываем кнопку, чтоб не попала на скриншот
        //подготавливаем и получаем скриншот
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageRef = UIGraphicsGetImageFromCurrentImageContext() // получаем изображение с контекста
        UIGraphicsEndImageContext()
        // получили, дальше - делимся через системное меню "поделиться"
        let items:[Any] = [imageRef as Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
        ShareButton.isHidden = false // отображаем кнопку
    }
}
