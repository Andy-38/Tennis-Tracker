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
        GameControl.selectedSegmentIndex = 5
        LastSetControl.selectedSegmentIndex = 0
        AdvantageControl.selectedSegmentIndex = 0
    }
}
