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
    let player: Player
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                CellTopPlayersFooTeam(namePlayer: viewModel.player.name,
                                      photoPlayer: viewModel.player.avatarStringURL,
                                      ratingPlayer: "\(viewModel.player.rating)",
                                      positionPlayer: PositionFromIntToString.shared.setPosition(position: viewModel.player.position),
                                      locationCountryImage: "",
                                      logoTeamImage: viewModel.team.avatarStringURL,
                                      game: "\(viewModel.player.winGame + viewModel.player.losGame)",
                                      goal: "\(viewModel.player.numberOfGoals)",
                                      win: "\(viewModel.player.winGame)",
                                      los: "\(viewModel.player.losGame)")
                    .padding(.vertical, 8)
                Spacer()
            }

                HStack {
                    Text("Играю в команде:")
                    Spacer()
                    Text("\(viewModel.team.teamName)")
                        .font(.headline)
                    
                }
                
                HStack {
                    Text("Личный баланс:")
                    Spacer()
                        .foregroundColor(Color.green)
                    Text("\(viewModel.player.payment) FCoin")
                        .font(.headline)
                }
                
                HStack {
                    Text("Месячная подписка:")
                    Spacer()
                    Text("\(viewModel.player.subscription ? Text("активна").foregroundColor(Color.green) : Text("не активна").foregroundColor(Color.red))")
                        .font(.headline)
                }
                
                HStack {
                    Text("Иду на след. игру:")
                    Spacer()
                    Text("\(viewModel.player.iGo ? Text("да").foregroundColor(Color.green) : Text("нет").foregroundColor(Color.red))")
                        .font(.headline)
                }
        } .onAppear { viewModel.playerID = player.id }
        
        .navigationBarTitle(Text("Персональная карточка"), displayMode: .inline)
        
        .navigationBarItems(trailing:
                                VStack {
                                    if FirestoreService.shared.currentUser.captain {
                                        Button(action: { viewModel.isPresentedShowModal.toggle() }) {
                                            Image(systemName: "pencil")
                                                .font(.title)
                                                .foregroundColor(Color("BlackAndWhite"))
                                        }
                                    }
                                }
        )
        .sheet(
            isPresented: $viewModel.isPresentedShowModal,
            content: { PlayersProfileEditor(player: player) }
        )
    }
}

struct ListPlayersProfileShow_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersProfileShow(player: Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGoals: 0, winGame: 0, losGame: 9, captain: false))
    }
}
