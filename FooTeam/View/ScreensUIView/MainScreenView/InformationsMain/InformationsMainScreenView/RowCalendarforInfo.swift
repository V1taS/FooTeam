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
                    CellCalendarforInfo(dayOfweak: "Пн", background: .white)
                    CellCalendarforInfo(dayOfweak: "Вт", background: .white)
                    CellCalendarforInfo(dayOfweak: "Ср", background: .green)
                    CellCalendarforInfo(dayOfweak: "Чт", background: .white)
                }
                
                HStack {
                    CellCalendarforInfo(dayOfweak: "Пт", background: .white)
                    CellCalendarforInfo(dayOfweak: "Сб", background: .white)
                    CellCalendarforInfo(dayOfweak: "Вс", background: .white)
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
