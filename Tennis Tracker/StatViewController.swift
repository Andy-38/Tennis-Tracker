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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // выполняется при отображении экрана
        TurnirNameLabel.text = match.TurnirName
        Player1nameLabel.text = player1.name
        Player2nameLabel.text = player2.name
    }
    
}
