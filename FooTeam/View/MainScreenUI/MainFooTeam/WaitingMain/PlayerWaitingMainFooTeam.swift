//
//  PlayerWaitingMainFooTeam.swift.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlayerWaitingMainFooTeam: View {
    
    var player: Players
    
    @ObservedObject var teamsListener = TeamsListener()
    
    var team: [Teams] {
        teamsListener.teams.filter { $0.id == player.idTeam }
    }
    
    @State var showAlert = false
    
    var body: some View {
        
        Button(action: { self.showAlert.toggle() } ) {
            
            ZStack {
                BackgroundFooTeam(firstColor: .gray, centerColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)), lastColor: .gray)
                    .frame(width: 150, height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack {
                    
                    ZStack {
                        WebImage(url: URL(string: player.avatarStringURL))
                            .renderingMode(.original)
                            .onSuccess { image, data, cacheType in }
                            .resizable()
                            .placeholder(Image("player"))
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                            .frame(width: 125, height: 125, alignment: .center)
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fill)
                    }
                    
                    Text("\(player.name)")
                        .foregroundColor(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 140)
                        .lineLimit(1)
                }
            } .alert(isPresented: $showAlert) {
                Alert(title: Text("Добавить игрока в команду?"),
                      primaryButton: .destructive(Text("Отмена")),
                      secondaryButton: .default(Text("Добавить")) {
                        
                        AcceptInvitation.shared.acceptInvitation(player: self.player, team: self.team.first!)
                        
                    } )
            }
        }
    }
}

struct PlayerWaitingMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        PlayerWaitingMainFooTeam(player: Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: true, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true))
    }
}
