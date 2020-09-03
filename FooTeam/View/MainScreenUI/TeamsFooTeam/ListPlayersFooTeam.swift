//
//  ListPlayersFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListPlayersFooTeam: View {
    
    @Binding var player: Players?
    @ObservedObject var playersListener = PlayersListener()
    
    var generalListPlayers: [Players] {
        playersListener.players.filter { $0.subscription }
    }
    
    var reservListPlayers: [Players] {
        playersListener.players.filter { !$0.subscription }
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Основной состав")) {
                    ForEach(generalListPlayers, id: \.self) { curPlayer in
                        HStack {
                            Text("\(curPlayer.name)")
                            Text("I-GO")
                                .foregroundColor(curPlayer.iGo ? .green : .red)
                                .fontWeight(.bold)
                        }
                    }
                }
                
                Section(header: Text("Запасные игроки")) {
                    ForEach(reservListPlayers, id: \.self) { curPlayer in
                        HStack {
                            Text("\(curPlayer.name)")
                            Text("I-GO")
                                .foregroundColor(curPlayer.iGo ? .green : .red)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        } .onAppear { UITableView.appearance().tableFooterView = UIView() }
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
    }
}

struct ListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersFooTeam(player: .constant(Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: false, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
    }
}
