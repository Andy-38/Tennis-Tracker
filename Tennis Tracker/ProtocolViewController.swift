//
//  ProtocolViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 26.03.2025.
//

import UIKit

class ProtocolViewController: UIViewController {
    
    var stroka1: String = ""
    var stroka2: String = ""
    
    @IBOutlet weak var ProtocolTextView: UITextView! // текстовое поле для протокола
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
        //ProtocolTextView.setContentSize(<#T##CGSize#>, animated: <#T##Bool#>)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // выполняется при отображении экрана
        ProtocolTextView.isEditable = true
        ProtocolTextView.text = ""
        ProtocolTextView.text.append("Протокол матча: \n\n")
        ProtocolTextView.text.append("Играли: (1) "+player1.name+"  и (2) "+player2.name+"\n\n")
        //ProtocolTextView.text.append(player1.setScore+":"+player2.setScore)
        stroka1 = "1. |"
        stroka2 = "2. |"
        if match.GameNow > 1 {
            for currentGame in 1...match.GameNow - 1 {
                stroka1 = stroka1 + player1.stat[currentGame] + " |"
                stroka2 = stroka2 + player2.stat[currentGame] + " |"
            }
        }
        ProtocolTextView.text.append(stroka1 + "\n")
        ProtocolTextView.text.append(stroka2 + "\n")
        /*if GameNow > 1 {
            for currentGame in 1...GameNow - 1 {
                ProtocolTextView.text.append("Гейм №" + String(currentGame) + ":\n")
                ProtocolTextView.text.append("1. " + player1.stat[currentGame] + "\n")
                ProtocolTextView.text.append("2. " + player2.stat[currentGame] + "\n\n")
            }
        }*/
        
        ProtocolTextView.isEditable = false
    }
}
