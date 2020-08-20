//
//  BackgroundMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct WellcomeFooTeamMenu: View {
    
    @Binding var player: Players?
    
    var body: some View {
        VStack {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.green, lineWidth: 2))
            Text("Привет,")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(player!.name)
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct BackgroundMenu_Previews: PreviewProvider {
    static var previews: some View {
        WellcomeFooTeamMenu(player: .constant(Players(name: "Виталий Сосин", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "12345", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
            .background(Color("Color").edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
    }
}
