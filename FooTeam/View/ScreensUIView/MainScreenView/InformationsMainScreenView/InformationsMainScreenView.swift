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
    
    @ObservedObject var networkWeather = NetworkWeatherManager()
    
    @State var iGo = true
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
                .frame(width: 180, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke()
                )
            
            VStack {
                Text("ИНФОРМАЦИЯ")
                    .font(.headline)
                    .foregroundColor(Color(.red))
                
                DividerFooTeamMenu()
                
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    HStack {
                        Text("Клуб:")
                        Text("\(viewModel.nameTeam)")
                            .font(.headline)
                            .lineLimit(1)
                    }
                    
                    HStack {
                        Text("Иду на игру:")
                        Text("\(viewModel.iGo ? "да" : "нет")")
                            .font(.headline)
                    }
                } .frame(width: 160, alignment: .leading)
                
                DividerFooTeamMenu()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    HStack {
                        Text("Игра:")
                        Text("\(viewModel.datePlay)")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Температура:")
                        Text("\(viewModel.temperatureString)°С")
                            .font(.headline)
                    }
                } .frame(width: 160, alignment: .leading)
            }
        }
    }
}

struct InformationMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        InformationsMainScreenView()
    }
}
