//
//  TennisPlayer.swift
//  Tennis Tracker
//
//  Created by Андрей on 26.03.2025.
//


class TennisPlayer {
    var point: Int = 0 // очки игрока в гейме
    var game: Int = 0 // геймы игрока
    var set: Int = 0 // сэты игрока
    var stat: [String] = [" ", " "] // статистика очков в гейме
    var gamesStat : [String] = ["", ""] // статистика геймов в сэте
    var setScore: String = "" // статистика сэтов в матче
    var name: String = "Игрок" // имя игрока
}