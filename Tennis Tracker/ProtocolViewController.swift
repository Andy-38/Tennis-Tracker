//
//  ProtocolViewController.swift
//  Tennis Tracker
//
//  Created by Андрей on 26.03.2025.
//

import UIKit

class ProtocolViewController: UIViewController {
    
    @IBOutlet weak var ProtocolTextView: UITextView! // текстовое поле для протокола
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
        ProtocolTextView.text = ""
        ProtocolTextView.text.append("Протокол матча:")
        ProtocolTextView.text.append(player1.setScore)
    }
    
    //override func viewDidAppear(_ animated: Bool) {
    //    super.viewDidAppear(animated)
        // выполняется при отображении экрана
        
    //}
}
