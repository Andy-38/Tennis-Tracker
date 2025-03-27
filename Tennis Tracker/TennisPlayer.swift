//
//  TennisPlayer.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 26.03.2025.
//

import Foundation


class TennisPlayer { // класс для описания игрока
    var point: Int = 0 // очки игрока в гейме
    var game: Int = 0 // геймы игрока
    var set: Int = 0 // сэты игрока
    var stat: [String] = [" ", " "] // статистика очков в гейме
    var gamesStat : [String] = ["", ""] // статистика геймов в сэте
    var setScore: String = "" // статистика сэтов в матче
    var name: String = "Игрок" // имя игрока
}

class TennisMatch { // класс для описания матча
    var MaxGame: Int = 6 // игра до 6 геймов в сэте
    var MaxSet: Int = 2 // игра до победы в 2-х сэтах
    var MaxPoint: Int = 4 // до 4-х очков в гейме 0/15/30/40
    var Podacha: Int = 1 // какая сейчас подача 1-я/2-я
    var PodaetNow: Int = 1 // кто сейчас подает 1/2 игрок
    var TieBreak7: Bool = false // идет ли сейчас тайбрейк в сэте
    var GameNow: Int = 1 // какой сейчас идет гейм
    var SetNow: Int = 1 // какой сейчас идет сет
    var TurnirName: String = "" // название турнира
    var MatchStart: Date = Date(timeIntervalSinceNow: 0)
    var MatchStop: Date = Date(timeIntervalSinceNow: 0)
    var MatchLength: Double = 0
    var Finished: Bool = false // матч окончен или нет
}
