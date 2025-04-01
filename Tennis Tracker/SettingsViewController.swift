//
//  SettingsViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 01.04.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var DefaulButton: UIButton! // кнопка стандартных настроек
    
    @IBOutlet weak var SetControl: UISegmentedControl! // контроллер выбора числа сетов в матче
    @IBOutlet weak var GameControl: UISegmentedControl! // контроллер выбора числа геймов в сете
    @IBOutlet weak var LastSetControl: UISegmentedControl! // контроллер последнего сета
    @IBOutlet weak var AdvantageControl: UISegmentedControl! // контроллер больше-меньше в гейме
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // выполняется при отображении экрана
    }
    
    @IBAction func DafaultButtonPress(_ sender: Any) {
        SetControl.selectedSegmentIndex = 1
        match.MaxSet = 2 // 3 сета в матче, надо выиграть 2
        
        GameControl.selectedSegmentIndex = 5
        match.MaxGame = 6 // 6 геймов в матче
        
        LastSetControl.selectedSegmentIndex = 0
        match.TieBreak10 = false // нет тайбрейка в третьем сете
        
        AdvantageControl.selectedSegmentIndex = 0
        match.BolsheMenshe = true // больше-меньше
    }
    
    @IBAction func SetControllerChange(_ sender: Any) {
        // меняем количество сетов в матче: 1, 3, 5, или тайбрейк до 7 или до 10
        switch SetControl.selectedSegmentIndex {
        case 0: do {
            match.MaxSet = 1 // 1 сет в матче, надо выиграть 1
        }
        case 1: do {
            match.MaxSet = 2 // 3 сета в матче, надо выиграть 2
        }
        case 2: do {
            match.MaxSet = 3 // 5 сетов в матче, надо выиграть 3
        }
        default: match.MaxSet = 2
        }
    }
    
    @IBAction func GameControllerChange(_ sender: Any) {
        // меняем количество геймов в сете
        match.MaxGame = GameControl.selectedSegmentIndex + 1
    }
    
    @IBAction func LastSetControlleChange(_ sender: Any) {
        // меняем тип последнего сета: "обычный" или "тайбрейк до 10"
        switch LastSetControl.selectedSegmentIndex {
        case 0: do {
            match.TieBreak10 = false
        }
        case 1: do {
            match.TieBreak10 = true
        }
        default: match.TieBreak10 = false
        }
    }
    
    @IBAction func AdvantadgeControllerChange(_ sender: Any) {
        // меняем "больше-меньше" или "решающее очко" при счете 40:40
        switch AdvantageControl.selectedSegmentIndex {
        case 0: do {
            match.BolsheMenshe = true
        }
        case 1: do {
            match.BolsheMenshe = false
        }
        default: match.BolsheMenshe = true
        }
    }
}
