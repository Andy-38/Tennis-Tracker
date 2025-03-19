//
//  ViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 18.04.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // TurnirTextField.delegate = self
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
    }
    
    @IBAction func Lose1ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 1-го игрока
    }
    
    @IBAction func Win2ButtonPress(_ sender: Any) {
        // при нажатии кнопки победы 2-го игрока
    }
    
    @IBAction func Lose2ButtonPress(_ sender: Any) {
        // при нажатии кнопки проигрыша 2-го игрока
    }
}

