//
//  ListPlayersFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListPlayersSecondScreenView: View {
    
    //    @StateObject private var viewModel = ListPlayersSecondScreenViewModel()
    
    @ObservedObject var currentUser = CurrentUser()
    @ObservedObject var playersListener = PlayersListener()
    
    @ObservedObject var actionsPlayers = ActionsPlayers()
    
    var reservListPlayers: [Players] {
        actionsPlayers.players.filter { !$0.subscription }
    }
    
    var iGolistPlayers: [Players] {
        actionsPlayers.players.filter { $0.iGo }
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
                        ForEach(actionsPlayers.players.filter { $0.subscription },
                                id: \.self) { player in
                                    NavigationLink(destination: ProfileShowModalMainScreenView(currentUser: self.currentUser, playersListener: self.playersListener, showModal: self.$showModal)) {
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
                            NavigationLink(destination: ProfileShowModalMainScreenView(currentUser: self.currentUser, playersListener: self.playersListener, showModal: self.$showModal)) {
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
                content: { ProfileAddPlayerView(showModal: self.$showModal) }
            )
    }
}


struct ListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersSecondScreenView()
    }
}
