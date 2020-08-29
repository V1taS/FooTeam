//
//  HeaderMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct HeaderMainFooTeam: View {
    
    @Binding var player: Players?
    
    var body: some View {
        HStack {
            ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .frame(height: 30)
                
                HStack {
                    Text("Баланс:")
                    .padding(.leading)
                    Spacer()
                    Text("\(player?.payment ?? "0") FCoin")
                        .padding(.trailing)
                }
            }
        }
    }
}

struct HeaderMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        HeaderMainFooTeam(player: .constant(Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
    }
}
