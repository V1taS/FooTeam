//
//  TabViewFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct TabViewFooTeam: View {
    
    @StateObject private var viewModel = TabViewFooTeamModel()
    
    var body: some View {
        ZStack {
            
            TabView {
                MainScreenView()
                    .tabItem {
                        Image(systemName: "shield")
                        Text("Главная")
                    }
                
                ListPlayersSecondScreenView()
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text("Команда")
                    }
            }
            
            
            if FirestoreService.shared.currentUser.captain {
                if viewModel.showAcceptPlayers {
                    ZStack {
                        Color.black.opacity(0.8)
                            .edgesIgnoringSafeArea(.all)
                    ZStack {
                        
                        List {
                            Section(header: HStack {
                                Text("Ожидают добавления")
                                Spacer()
                                Button(action: {
                                    viewModel.showAcceptPlayers = false
                                }) {
                                    Image(systemName: "multiply")
                                        .renderingMode(.original)
                                        .font(.title)
                                }
                            } ) {
                                ForEach(viewModel.players, id: \.self) { player in
                                    
                                    HStack {
                                        ImagePlayer(avatarStringURL: player.avatarStringURL, avatarSize: 40)
                                            .padding(.trailing, 8)
                                        Text("\(player.name)")
                                            .lineLimit(1)
                                            .font(.headline)
                                            .frame(width: 140)
                                        Spacer()
                                        
                                        Button(action: {
                                            NoAcceptInvitation.shared.acceptInvitation(player: player, capitanPlayer: FirestoreService.shared.currentUser)
                                        }) {
                                            Text("❌")
                                                .padding(.trailing, 8)
                                        }
                                        Button(action: {
                                            AcceptInvitation.shared.acceptInvitation(player: player, capitanPlayer: FirestoreService.shared.currentUser)
                                        }) {
                                            Text("✅")
                                            
                                        }
                                    }
                                }
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .frame(width: 350, height: 250, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green)
                    ).offset(x: 0, y: -100)
                    }
                }
            }
        }
    }
}

struct TabViewFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TabViewFooTeam()
    }
}
