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
    @Binding var listPlayers: [Players]?
    
    var iGolistPlayers: [Players] {
        listPlayers?.filter { $0.subscription } ?? []
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Основной состав")) {
                    ForEach(listPlayers ?? [], id: \.self) { curPlayer in
                        HStack {
                            VStack {
                                WebImage(url: URL(string: curPlayer.avatarStringURL))
                                .onSuccess { image, data, cacheType in }
                                .resizable()
                                .placeholder(Image("player"))
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFill()
                                .frame(width: 50, height: 50, alignment: .center)
                                .cornerRadius(20)
                                .aspectRatio(contentMode: .fill)
                                Text("\(curPlayer.name)")
                            }
                            VStack(alignment: .leading, spacing: 1) {
                                Text("I-GO \(curPlayer.iGo ? "🟢" : "🔴")")
                                Text("Подписка \(curPlayer.subscription ? "🟢" : "🔴")")
                                
                            }
                        }
                    }
                }
                
                Section(header: Text("Запасные игроки")) {
                    ForEach(listPlayers ?? [], id: \.self) { curPlayer in
                        HStack {
                            VStack {
                                WebImage(url: URL(string: curPlayer.avatarStringURL))
                                .onSuccess { image, data, cacheType in }
                                .resizable()
                                .placeholder(Image("player"))
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFill()
                                .frame(width: 50, height: 50, alignment: .center)
                                .cornerRadius(20)
                                .aspectRatio(contentMode: .fill)
                                Text("\(curPlayer.name)")
                            }
                            VStack(alignment: .leading, spacing: 1) {
                                Text("I-GO \(curPlayer.iGo ? "🟢" : "🔴")")
                                Text("Подписка \(curPlayer.subscription ? "🟢" : "🔴")")
                                
                            }
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
        ListPlayersFooTeam(player: .constant(Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: false, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)), listPlayers: .constant([Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true), Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)]))
    }
}
