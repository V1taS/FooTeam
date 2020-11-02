//
//  RowCalendarforInfo.swift
//  FooTeam
//
//  Created by Виталий Сосин on 03.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct RowCalendarforInfo: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    CellCalendarforInfo(dayOfweak: "Пн", background: UIColor(named: "WhiteAndBlack")!)
                    CellCalendarforInfo(dayOfweak: "Вт", background: UIColor(named: "WhiteAndBlack")!)
                    CellCalendarforInfo(dayOfweak: "Ср", background: .green)
                    CellCalendarforInfo(dayOfweak: "Чт", background: UIColor(named: "WhiteAndBlack")!)
                }
                
                HStack {
                    CellCalendarforInfo(dayOfweak: "Пт", background: UIColor(named: "WhiteAndBlack")!)
                    CellCalendarforInfo(dayOfweak: "Сб", background: UIColor(named: "WhiteAndBlack")!)
                    CellCalendarforInfo(dayOfweak: "Вс", background: UIColor(named: "WhiteAndBlack")!)
                }
            } .frame(width: 135, height: 75, alignment: .center)
        }
    }
}

struct RowCalendarforInfo_Previews: PreviewProvider {
    static var previews: some View {
        RowCalendarforInfo()
    }
}
