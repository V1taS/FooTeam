//
//  ListPlayersProfileShow.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ListPlayersProfileShow: View {
    
    @StateObject private var viewModel = ListPlayersProfileShowViewModel()
    @ObservedObject var currentTeam = CurrentTeam()
    var player: Player
    @State var isPresentedShowModal = false
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                CellTopPlayersFooTeam(backgroundColor: Color(#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)),
                                      namePlayer: player.name,
                                      photoPlayer: player.avatarStringURL,
                                      ratingPlayer: "\(player.rating)",
                                      positionPlayer: player.position,
                                      locationCountryImage: "",
                                      logoTeamImage: currentTeam.team.avatarStringURL ?? "",
                                      game: "\(player.numberOfGames)",
                                      goal: "\(player.numberOfGoals)",
                                      win: "\(player.winGame)",
                                      los: "\(player.losGame)")
                    .padding(.vertical, 8)
                Spacer()
            }

                HStack {
                    Text("Играю в команде:")
                    Spacer()
                    Text("\(viewModel.nameTeam)")
                        .font(.headline)
                    
                }
                
                HStack {
                    Text("Личный баланс:")
                    Spacer()
                        .foregroundColor(Color.green)
                    Text("\(player.payment) FCoin")
                        .font(.headline)
                }
                
                HStack {
                    Text("Месячнвя подписка:")
                    Spacer()
                    Text("\(player.subscription ? "активна" : "не активна")")
                        .font(.headline)
                }
                
                HStack {
                    Text("Иду на след. игру:")
                    Spacer()
                    Text("\(player.iGo ? "да" : "нет")")
                        .font(.headline)
                }
                
        } .onAppear { BufferIDplayer.shared.saveUserID(id: player.id) }
        
        .navigationBarTitle(Text("Персональная карточка"), displayMode: .inline)
        
        .navigationBarItems(trailing:
                                VStack {
                                    if FirestoreService.shared.currentUser.captain {
                                        Button(action: { isPresentedShowModal.toggle() }) {
                                            Image(systemName: "pencil")
                                                .renderingMode(.original)
                                                .font(.title)
                                        }
                                    }
                                }
        )
        .sheet(
            isPresented: $isPresentedShowModal,
            content: { PlayersProfileEditor(closeIsPresentedShowModal: $isPresentedShowModal, player: player) }
        )
    }
}

struct ListPlayersProfileShow_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersProfileShow(player: Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false))
    }
}
