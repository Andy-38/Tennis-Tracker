//
//  TennisPlayer.swift
//  Tennis Tracker
//
//  Created by Andy Dvoytsov on 26.03.2025.
//

import Foundation


struct TennisPlayer { // класс для описания игрока
    var point: Int = 0 // очки игрока в гейме
    var game: Int = 0 // геймы игрока
    var set: Int = 0 // сэты игрока
    var stat: [String] = [" ", " "] // статистика очков в гейме
    var inGameScore: [String] = ["0","0"] // очки после окончания каждого гейма
    var gamesStat: [String] = ["", ""] // статистика геймов в сэте
    var setScore: String = "" // статистика сэтов в матче
    var name: String = "Игрок" // имя игрока
    var doubleFaults: Int = 0 // количество двойных ошибок в матче
    var aces: Int = 0 // количество эйсов в матче
    var winners: Int = 0// количество виннеров в матче
    var ufe: Int = 0 // количество невынужденных ошибок в матче
    var breakpoint: Int = 0 // количество брейкпоинтов в матче
    var totalPoints: Int = 0 // общее количество выигранных очков в матче
    var vsegoPodach : Int = 0 // общее количество подач
    var podach2: Int = 0 // количество вторых подач
    var podach1 : Int { // количество первых подач
        get {
            return vsegoPodach - podach2
        }
    }
    var percent1: Int { // процент первых подач
        get {
            if vsegoPodach == 0 { return 0 }
            else {
                let percent: Float = (Float(podach1) / Float(vsegoPodach))*100
                return Int(percent.rounded())
            }
        }
    }
    var percent2: Int { // процент вторых подач
        get {
            if podach2 == 0 { return 0 }
            else {
                let percent: Float = (1 - Float(doubleFaults) / Float(podach2))*100
                return Int(percent.rounded())
            }
        }
    }
}

struct TennisMatch { // класс для описания матча
    var MaxGame: Int = 6 // игра до 6 геймов в сэте
    var MaxSet: Int = 2 // игра до победы в 2-х сэтах
    var MaxPoint: Int = 4 // до 4-х очков в гейме 0/15/30/40
    var Podacha: Int = 1 // какая сейчас подача 1-я/2-я
    var PodaetNow: Int = 1 // кто сейчас подает 1/2 игрок
    var TieBreak7: Bool = false // идет ли сейчас тайбрейк в сэте
    var TieBreak10: Bool = false // идет ли сейчас решающий тайбрейк
    var TieBreakPoint: Int = 0 // какой по счету розыгрыш на тайбрейке
    var TieBreakPodacha: Int = 1 // с чьей подачи начался тайбрейк
    var LastSetTieBreak10: Bool = false // есть ли тайбрейк до 10 вместо последнего сэта
    var GameNow: Int = 1 // какой сейчас идет гейм
    var SetNow: Int = 1 // какой сейчас идет сет
    var gamesInSet: [Int] = [0, 0, 0, 0, 0, 0] // количество геймов в каждом сете
    var TurnirName: String = "" // название турнира
    var MatchStart: Date = Date(timeIntervalSinceNow: 0) // время начала матча
    var MatchStop: Date = Date(timeIntervalSinceNow: 0) // время окончания матча
    var MatchLength: Double = 0 // длительность матча
    var Finished: Bool = false // матч окончен или нет
    var Winner: Int = 0 // победитель матча 1 или 2, 0 - не определено
    var BolsheMenshe: Bool = true // есть ли больше-меньше в гейме
}

struct MatchState { // класс для запоминания текущего состояния матча
    var player1: TennisPlayer = TennisPlayer()
    var player2: TennisPlayer = TennisPlayer()
    var match: TennisMatch = TennisMatch()
}
