//
//  CalendarFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class CalendarFooTeam: ObservableObject {
    
    @Published var datePlay: String = ""

    init() {
        timeFoot()
    }
    
    func timeFoot() {
            let date = Date()
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: date)
            
            switch weekday {
            case 1:
                //            print("Сегодня Воскресенье")
                datePlay = "через 3 дня"
            case 2:
                //            print("Сегодня Понедельник")
                datePlay = "через 2 дня"
            case 3:
                //            print("Сегодня Вторник")
                datePlay = "через 1 день"
            case 4:
                //            print("Сегодня Среда")
                datePlay = "сегодня"
            case 5:
                //            print("Сегодня Четверг")
                datePlay = "через 6 дней"
            case 6:
                //            print("Сегодня Пятница")
                datePlay = "через 5 дней"
            case 7:
                //            print("Сегодня Суббота")
                datePlay = "через 4 дня"
            default:
                print("Error")
            }
        }
}
