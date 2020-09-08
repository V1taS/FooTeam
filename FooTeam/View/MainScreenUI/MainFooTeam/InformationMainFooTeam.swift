//
//  InformationMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct InformationMainFooTeam: View {
    
    @Binding var player: Players?
    @ObservedObject var weather = NetworkWeatherManager()
    @ObservedObject var calendarFooTeam = CalendarFooTeam()
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
                        Text("\(player?.nameTeam ?? "нет")")
                        .font(.headline)
                    }
                    
                    HStack {
                        
                        Toggle(isOn: $iGo) {
                            Text("Иду на игру:")
                            } .frame(width: 160)
                    }
                }
                
                DividerFooTeamMenu()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    HStack {
                        Text("Игра через:")
                        Text("\(calendarFooTeam.datePlay)")
                        .font(.headline)
                    }

                    HStack {
                        Text("Температура:")
                        Text("\(weather.weather.first?.temperatureString ?? "")°С")
                        .font(.headline)
                    }
                }
            }
        }
    }
}

struct InformationMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        InformationMainFooTeam(player: .constant(Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: true, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
    }
}
