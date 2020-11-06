//
//  AcceptPlayersView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct AcceptPlayersView: View {
    
    @Binding var players: [Player]
    @Binding var showAcceptPlayers: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showAcceptPlayers = false
                }
            ZStack {
                List {
                    Section(header: HStack {
                        Text("Ожидают добавления")
                        Spacer()
                        Button(action: {
                            showAcceptPlayers = false
                        }) {
                            Image(systemName: "multiply")
                                .font(.title)
                                .foregroundColor(Color("BlackAndWhite"))
                        }
                    } ) {
                        ForEach(players, id: \.self) { player in
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

//struct AcceptPlayersView_Previews: PreviewProvider {
//    static var previews: some View {
//        AcceptPlayersView(players: .constant(<#T##value: [Player]##[Player]#>), showAcceptPlayers: <#Binding<Bool>#>)
//    }
//}
