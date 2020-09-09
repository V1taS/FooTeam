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
    
    var iGolistPlayers: [Players] {
        playersListener.players.filter { $0.iGo }
    }
    
    @State var showModal: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                //                VStack {
                //                    Text("Всего игроков: \(playersListener.players.count)")
                //                    Text("Придут на игру: \(iGolistPlayers.count)")
                //                }
                
                List {
                    Section(header: Text("Основной состав")) {
                        ForEach(generalListPlayers, id: \.self) { player in
                            NavigationLink(destination: ProfileListPlayersFooTeam(player: player)) {
                                HStack {
                                    Text("\(player.name)")
                                    Spacer()
                                    Text("\(player.captain ? "Капитан" : "")")
                                        .font(.headline)
                                    Text("I-GO")
                                        .foregroundColor(player.iGo ? .green : .red)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Запасные игроки")) {
                        ForEach(reservListPlayers, id: \.self) { player in
                            NavigationLink(destination: ProfileListPlayersFooTeam(player: player)) {
                                HStack {
                                    Text("\(player.name)")
                                    Spacer()
                                    Text("\(player.captain ? "Капитан" : "")")
                                        .font(.headline)
                                    Text("I-GO")
                                        .foregroundColor(player.iGo ? .green : .red)
                                        .fontWeight(.bold)
                                    
                                }
                            }
                        }
                    }
                }
            } .onAppear { UITableView.appearance().tableFooterView = UIView() }
                .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                .navigationBarTitle(Text("Моя команда"))
                .navigationBarItems(trailing:
                    Button(action: { self.showModal.toggle() }) {
                        Image(systemName: "square.and.pencil").renderingMode(.original)
                            .font(.title)
                            .foregroundColor(Color.black)
                        
                })
            } .sheet(
                isPresented: $showModal,
                content: { AddListPlayersFooTeam(showModal: self.$showModal) }
            )
    }
}


struct ListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersFooTeam(player: .constant(Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: false, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
    }
}
