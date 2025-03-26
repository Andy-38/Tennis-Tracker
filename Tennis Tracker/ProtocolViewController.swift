//
//  ProtocolViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 26.03.2025.
//

import UIKit

class ProtocolViewController: UIViewController {
    
    @IBOutlet weak var ProtocolTextView: UITextView! // текстовое поле для протокола
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // выполняется при отображении экрана
        ProtocolTextView.isEditable = true
        ProtocolTextView.text = ""
        ProtocolTextView.text.append("Протокол матча: \n\n")
        ProtocolTextView.text.append("Играли: (1) "+player1.name+"  и (2) "+player2.name+"\n\n")
        //ProtocolTextView.text.append(player1.setScore+":"+player2.setScore)
        for currentGame in 1...GameNow-1 {
            ProtocolTextView.text.append("Гейм №"+String(currentGame)+":\n")
            ProtocolTextView.text.append("1. "+player1.stat[currentGame]+"\n")
            ProtocolTextView.text.append("2. "+player2.stat[currentGame]+"\n\n")
        }
        ProtocolTextView.isEditable = false
    }
}
