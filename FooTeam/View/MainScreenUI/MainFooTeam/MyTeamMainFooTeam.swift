//
//  MyTeamMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct MyTeamMainFooTeam: View {
    
    @Binding var player: Players?
    @Binding var listPlayers: [Players]?
    
    var iGolistPlayers: [Players] {
        listPlayers?.filter { $0.iGo } ?? []
    }
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .frame(width: 380, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                Image("teamCount")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                
                Spacer()
                
                VStack {
                    Text("Моя команда")
                        .font(.title)
                        .foregroundColor(Color(.red))
                    
                    Text("Всего игроков: \(listPlayers?.count ?? 0)")
                    Text("Придут на игру: \(iGolistPlayers.count)")
                }
            }.padding(.horizontal, 36)
        }
    }
}

struct MyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MyTeamMainFooTeam(player: .constant(Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: false, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)), listPlayers: .constant([Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)]))
    }
}
