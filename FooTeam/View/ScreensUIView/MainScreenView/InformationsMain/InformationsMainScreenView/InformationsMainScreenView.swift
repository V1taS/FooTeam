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
                .frame(maxWidth: 180, idealHeight: 230, maxHeight: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10) .stroke(Color("BlackAndWhite")))
            
            VStack {
                Text("ИНФОРМАЦИЯ")
                    .font(.headline)
                    .foregroundColor(Color(.red))
                    .offset(x: 0, y: 11)
                DividerFooTeamMenu()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    HStack {
                        Text("Клуб:")
                            .foregroundColor(Color("BlackAndWhite"))
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                        Text("\(viewModel.nameTeam)")
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                    
                    HStack {
                        Text("Иду на игру:")
                            .minimumScaleFactor(0.9)
                            .lineLimit(1)
                            .foregroundColor(Color("BlackAndWhite"))
                        Text("\(viewModel.iGo ? Text("да").foregroundColor(Color("BlackAndWhite")) : Text("нет").foregroundColor(Color.red))")
                            .font(.headline)
                            .foregroundColor(Color("BlackAndWhite"))
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                    }
                }
                
                DividerFooTeamMenu()
                    .offset(x: 0, y: -5)
                
                VStack(alignment: .center, spacing: 1) {
                    Text("Календарь игр")
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .frame(maxWidth: 150)
                        .foregroundColor(Color("BlackAndWhite"))
                    
                    RowCalendarforInfo()   
                } .offset(x: 0, y: -11)
                
            }
        }
    }
}

struct InformationMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        InformationsMainScreenView()
    }
}
