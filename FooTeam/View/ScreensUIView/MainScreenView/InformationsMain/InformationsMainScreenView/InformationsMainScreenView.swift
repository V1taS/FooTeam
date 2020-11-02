//
//  InformationsMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct InformationsMainScreenView: View {
    
    @StateObject private var viewModel = InformationsMainScreenViewModel()
    
    var body: some View {
        ZStack {
            Color("WhiteAndBlack")
                .frame(maxWidth: 180, idealHeight: 210, maxHeight: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10) .stroke(Color("BlackAndWhite")))
            
            VStack {
                Text("ИНФОРМАЦИЯ")
                    .font(.headline)
                    .foregroundColor(Color(.red))
                
                DividerFooTeamMenu()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    HStack {
                        Text("Клуб:")
                            .foregroundColor(Color("BlackAndWhite"))
                            .minimumScaleFactor(0.7)
                        Text("\(viewModel.nameTeam)")
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                    
                    HStack {
                        Text("Иду на игру:")
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color("BlackAndWhite"))
                        Text("\(viewModel.iGo ? Text("да").foregroundColor(Color("BlackAndWhite")) : Text("нет").foregroundColor(Color.red))")
                            .font(.headline)
                            .foregroundColor(Color("BlackAndWhite"))
                            .minimumScaleFactor(0.7)
                    }
                }
                .padding(.leading, 8)
                .frame(width: 160, alignment: .leading)
                
                DividerFooTeamMenu()
                
                VStack(alignment: .leading, spacing: 1) {
                    RowCalendarforInfo()
//                    VStack {
//                        Text("Ближайшие игры:")
//                            .font(.headline)
//                            .foregroundColor(Color("BlackAndWhite"))
//                            .minimumScaleFactor(0.7)
//                            .lineLimit(1)
//                        ForEach(viewModel.getPlayTime, id: \.self) { time in
//                            HStack {
//                                Text("\(GetDayOfWeekFromNumber.shared.GetDayOfWeek(numberString: time.dayOfWeek))")
//                                    .font(.headline)
//                                    .foregroundColor(Color("BlackAndWhite"))
//                                    .minimumScaleFactor(0.7)
//                                    .lineLimit(1)
//                                Text("в")
//                                    .font(.headline)
//                                    .foregroundColor(Color("BlackAndWhite"))
//                                    .minimumScaleFactor(0.7)
//                                    .lineLimit(1)
//                                Text("\(GetDateStringFromDate.shared.GetDateString(date: time.date))")
//                                    .font(.headline)
//                                    .foregroundColor(Color("BlackAndWhite"))
//                                    .minimumScaleFactor(0.7)
//                                    .lineLimit(1)
//                            }
//                        }
//                    }
                    
//                    HStack {
//                        Text("Температура:")
//                            .foregroundColor(Color("BlackAndWhite"))
//                            .minimumScaleFactor(0.7)
//                            .lineLimit(1)
//                        Text("\(viewModel.temperatureString)°С")
//                            .font(.headline)
//                            .minimumScaleFactor(0.7)
//                            .foregroundColor(Color("BlackAndWhite"))
//                            .lineLimit(1)
//                    }
                } .frame(width: 150, alignment: .leading)
            }
        }
    }
}

struct InformationMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        InformationsMainScreenView()
    }
}
