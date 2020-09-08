//
//  PositionsMyTeamMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct PositionsMyTeamMainFooTeam: View {
    
    @ObservedObject var weather = NetworkWeatherManager()
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                
                ListCompositionsMyTeamMainFooTeam()
                    .padding(.top)
                
                Form {
                    
                    HStack {
                        Text("Кол-во игроков:")
                        Spacer()
                        Text("15")
                        .font(.headline)
                    }
                    
                    HStack {
                        Text("Кол-во команд:")
                        Spacer()
                        Text("3")
                        .font(.headline)
                    }
                    
                    HStack {
                        Text("Игра состоится:")
                        Spacer()
                        Text("в среду в 21:30")
                        .font(.headline)
                    }
                    HStack {
                        Text("Погода на игру:")
                        Spacer()
                        Text("\(weather.weather.first?.temperatureString ?? "")°С")
                        .font(.headline)
                    }
                }
                
                Spacer()
                    .navigationBarTitle("Составы на игру", displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        self.showModal = false
                    }) {
                        Image(systemName: "multiply")
                            .renderingMode(.original)
                            .font(.headline)
                    })
                
            }
        }
    }
}

struct _ompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        PositionsMyTeamMainFooTeam(showModal: .constant(false))
    }
}
