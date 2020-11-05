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
                                        background: viewModel.monday ? UIColor(named: "darkGreen")! : UIColor(named: "lightGreen")!,
                                        textColor: viewModel.monday ? UIColor(named: "lightGreen")! : UIColor(named: "darkGreen")!,
                                        cornerColor: viewModel.currentWeekday == 1 ? UIColor(named: "BlackAndWhite")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Вт",
                                        background: viewModel.tuesday ? UIColor(named: "darkGreen")! : UIColor(named: "lightGreen")!,
                                        textColor: viewModel.tuesday ? UIColor(named: "lightGreen")! : UIColor(named: "darkGreen")!,
                                        cornerColor: viewModel.currentWeekday == 2 ? UIColor(named: "BlackAndWhite")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Ср",
                                        background: viewModel.wednesday ? UIColor(named: "darkGreen")! : UIColor(named: "lightGreen")!,
                                        textColor: viewModel.wednesday ? UIColor(named: "lightGreen")! : UIColor(named: "darkGreen")!,
                                        cornerColor: viewModel.currentWeekday == 3 ? UIColor(named: "BlackAndWhite")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Чт",
                                        background: viewModel.thursday ? UIColor(named: "darkGreen")! : UIColor(named: "lightGreen")!,
                                        textColor: viewModel.thursday ? UIColor(named: "lightGreen")! : UIColor(named: "darkGreen")!,
                                        cornerColor: viewModel.currentWeekday == 4 ? UIColor(named: "BlackAndWhite")! : UIColor.gray)
                }
                
                HStack {
                    
                    CellCalendarforInfo(dayOfweak: "Пн",
                                        background: viewModel.friday ? UIColor(named: "darkGreen")! : UIColor(named: "lightGreen")!,
                                        textColor: viewModel.friday ? UIColor(named: "lightGreen")! : UIColor(named: "darkGreen")!,
                                        cornerColor: viewModel.currentWeekday == 5 ? UIColor(named: "BlackAndWhite")! : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Сб",
                                        background: viewModel.saturday ? UIColor(named: "darkGreen")! : UIColor(named: "lightGreen")!,
                                        textColor: viewModel.saturday ? UIColor(named: "lightGreen")! : UIColor(named: "darkGreen")!,
                                        cornerColor: viewModel.currentWeekday == 6 ? UIColor.red : UIColor.gray)
                    
                    CellCalendarforInfo(dayOfweak: "Вс",
                                        background: viewModel.sunday ? UIColor(named: "darkGreen")! : UIColor(named: "lightGreen")!,
                                        textColor: viewModel.sunday ? UIColor(named: "lightGreen")! : UIColor(named: "darkGreen")!,
                                        cornerColor: viewModel.currentWeekday == 7 ? UIColor.red : UIColor.gray)
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
