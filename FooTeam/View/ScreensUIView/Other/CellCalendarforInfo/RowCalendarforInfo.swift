//
//  RowCalendarforInfo.swift
//  FooTeam
//
//  Created by Виталий Сосин on 03.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct RowCalendarforInfo: View {
    
    @StateObject private var viewModel = RowCalendarforInfoViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    CellCalendarforInfo(dayOfweak: "Пн",
                                        background: viewModel.monday ? UIColor(named: "darkCalendar")! : UIColor(named: "lightCalendar")!,
                                        textColor: viewModel.monday ? UIColor(named: "textCalendarTrue")! : UIColor(named: "textCalendarFalse")!,
                                        cornerColor: viewModel.currentWeekday == 2 ? UIColor(named: "currentCalendar")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Вт",
                                        background: viewModel.tuesday ? UIColor(named: "darkCalendar")! : UIColor(named: "lightCalendar")!,
                                        textColor: viewModel.tuesday ? UIColor(named: "textCalendarTrue")! : UIColor(named: "textCalendarFalse")!,
                                        cornerColor: viewModel.currentWeekday == 3 ? UIColor(named: "currentCalendar")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Ср",
                                        background: viewModel.wednesday ? UIColor(named: "darkCalendar")! : UIColor(named: "lightCalendar")!,
                                        textColor: viewModel.wednesday ? UIColor(named: "textCalendarTrue")! : UIColor(named: "textCalendarFalse")!,
                                        cornerColor: viewModel.currentWeekday == 4 ? UIColor(named: "currentCalendar")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Чт",
                                        background: viewModel.thursday ? UIColor(named: "darkCalendar")! : UIColor(named: "lightCalendar")!,
                                        textColor: viewModel.thursday ? UIColor(named: "textCalendarTrue")! : UIColor(named: "textCalendarFalse")!,
                                        cornerColor: viewModel.currentWeekday == 5 ? UIColor(named: "currentCalendar")! : UIColor.gray)
                }
                
                HStack {
                    
                    CellCalendarforInfo(dayOfweak: "Пт",
                                        background: viewModel.friday ? UIColor(named: "darkCalendar")! : UIColor(named: "lightCalendar")!,
                                        textColor: viewModel.friday ? UIColor(named: "textCalendarTrue")! : UIColor(named: "textCalendarFalse")!,
                                        cornerColor: viewModel.currentWeekday == 6 ? UIColor(named: "currentCalendar")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Сб",
                                        background: viewModel.saturday ? UIColor(named: "darkCalendar")! : UIColor(named: "lightCalendar")!,
                                        textColor: viewModel.saturday ? UIColor(named: "textCalendarTrue")! : UIColor(named: "textCalendarFalse")!,
                                        cornerColor: viewModel.currentWeekday == 7 ? UIColor(named: "currentCalendar")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Вс",
                                        background: viewModel.sunday ? UIColor(named: "darkCalendar")! : UIColor(named: "lightCalendar")!,
                                        textColor: viewModel.sunday ? UIColor(named: "textCalendarTrue")! : UIColor(named: "textCalendarFalse")!,
                                        cornerColor: viewModel.currentWeekday == 1 ? UIColor(named: "currentCalendar")! : UIColor.gray)
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
