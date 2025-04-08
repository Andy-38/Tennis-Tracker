//
//  ProtocolViewController.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 26.03.2025.
//

import UIKit

class ProtocolViewController: UIViewController {
    
    @IBOutlet weak var ProtocolTextView: UITextView! // текстовое поле для протокола
    @IBOutlet weak var ShareButton: UIButton! // кнопка "Поделиться"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выполняется при запуске приложения
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // выполняется при отображении экрана
        ProtocolTextView.isEditable = true // разрешаем редактирование протокола
        ProtocolTextView.text = ""
        ProtocolTextView.text.append("Протокол матча: \n\n")
        ProtocolTextView.text.append("Турнир: "+match.TurnirName+"\n") // название турнира
        ProtocolTextView.text.append("Играли: (1)"+player[1].name+"  и (2)"+player[2].name+"\n\n") // имена игроков
        
        ProtocolTextView.text.append("Победитель матча: ") // показываем победителя матча
        switch match.Winner {
        case 1: do {
            ProtocolTextView.text.append(player[1].name)
        }
        case 2: do {
            ProtocolTextView.text.append(player[2].name)
        }
        default: ProtocolTextView.text.append("не определен") // если матч не закончился
        }
        ProtocolTextView.text.append("\n")
        
        ProtocolTextView.text.append("1: "+player[1].setScore+"\n") // показываем очки в сетах
        ProtocolTextView.text.append("2: "+player[2].setScore+"\n\n")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss" // форматируем время в понятный формат
        let dateStrStart = dateFormatter.string(from: match.MatchStart)
        ProtocolTextView.text.append("Начало матча: "+dateStrStart+"\n") // начало матча
        
        if match.Finished == false { // если матч еще идет - то конец матча это текущее время
            match.MatchStop = Date(timeIntervalSinceNow: 0) // время конца матча
            match.MatchLength = match.MatchStop.timeIntervalSince(match.MatchStart) // длительность матча
        }
        let dateStrStop =  dateFormatter.string(from: match.MatchStop)
        ProtocolTextView.text.append("Конец  матча: "+dateStrStop+"\n") // конец матча
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second] // длительность - часы/минуты/секунды
        ProtocolTextView.text.append("Длительность: "+formatter.string(from: match.MatchLength)!+"\n\n") // длительность матча
        
        ProtocolTextView.text.append("Формат матча:\n")
        if !match.TieBreak10 {
            ProtocolTextView.text.append("Выиграть сетов для победы - "+String(match.MaxSet)+"\n")
            ProtocolTextView.text.append("Геймов в сете - "+String(match.MaxGame)+"\n")
            
            if match.MaxSet>1 {
                if match.LastSetTieBreak10 {
                    ProtocolTextView.text.append("Решающий сет - тайбрейк до 10\n")}
                else {
                    ProtocolTextView.text.append("Решающий сет - обычный\n")
                }
            }
            
            if match.BolsheMenshe {
                ProtocolTextView.text.append("При счете 40:40 - больше/меньше\n\n")}
            else {
                ProtocolTextView.text.append("При счете 40:40 - решающее очко\n\n")
            }
        } else {
            ProtocolTextView.text.append("1 сет - тайбрейк до " + String(match.MaxPoint)+"\n\n")
        }
    
        ProtocolTextView.text.append("---------------------------------\n")
        ProtocolTextView.text.append("История сетов \n\n")
        if match.SetNow > 1 {
            for currentSet in 1...match.SetNow - 1 { // показываем все сеты по порядку
                ProtocolTextView.text.append("Сет №" + String(currentSet) + ":\n")
                //ProtocolTextView.text.append("Сет №" + String(currentSet) + " ("+String(match.gamesInSet[currentSet])+" геймов):\n")
                ProtocolTextView.text.append("1. " + player[1].gamesStat[currentSet] + "\n")
                ProtocolTextView.text.append("2. " + player[2].gamesStat[currentSet] + "\n\n")
            }
        }
        
        ProtocolTextView.text.append("---------------------------------\n")
        ProtocolTextView.text.append("История геймов \n\n")
        
        var currSet = 0
        if match.GameNow > 1 {
            for currentGame in 1...match.GameNow - 1 { // показываем все геймы по порядку
                //ProtocolTextView.text.append("Гейм №" + String(currentGame) + ":\n")
                if currentGame == match.gamesInSet[currSet]+1 {
                    currSet+=1
                    if currSet > 1 { // отделяем 2-й и последующий сеты
                        ProtocolTextView.text.append("---------------------------------\n")
                    }
                    ProtocolTextView.text.append("Сет №" + String(currSet) + ":\n\n")
                }
                ProtocolTextView.text.append("Гейм №" + String(currentGame-match.gamesInSet[currSet-1]) + ":\n")
                ProtocolTextView.text.append("1. " + player[1].stat[currentGame] + " [" + player[1].inGameScore[currentGame]+"] \n")
                ProtocolTextView.text.append("2. " + player[2].stat[currentGame] + " [" + player[2].inGameScore[currentGame]+"] \n\n")
            }
        }
        
        ProtocolTextView.isEditable = false // запрещаем редактирование протокола игры
    }
    
    @IBAction func ShareButtonPress(_ sender: Any) { // делиться протоколом через системное меню
        let items:[Any] = [ProtocolTextView.text ?? "Протокол матча:"]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }
}
