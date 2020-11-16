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
                CellTopPlayersFooTeam(
                    namePlayer: viewModel.player.name,
                    photoPlayer: viewModel.player.avatarStringURL,
                    ratingPlayer: "\(viewModel.player.rating)",
                    positionPlayer: PositionFromIntToString.shared.setPosition(
                        position: viewModel.player.position
                    ),
                    locationCountryImage: "",
                    logoTeamImage: viewModel.team.avatarStringURL,
                    game: "\(viewModel.player.winGame + viewModel.player.losGame)",
                    goal: "\(viewModel.player.numberOfGoals)",
                    win: "\(viewModel.player.winGame)",
                    los: "\(viewModel.player.losGame)"
                )
                .padding(.vertical, 8)
                Spacer()
            }
            
            HStack {
                Text(NSLocalizedString("ListPlayersProfileShowPlayingInTeam",
                                       comment: "Playing in a team:"))
                Spacer()
                Text("\(viewModel.team.teamName)")
                    .font(.headline)
                
            }
            
            HStack {
                Text(NSLocalizedString("ListPlayersProfileShowPersonalBalance",
                                       comment: "Personal balance"))
                Spacer()
                    .foregroundColor(Color.green)
                Text("\(viewModel.player.payment) FCoin")
                    .font(.headline)
            }
            
            HStack {
                Text(NSLocalizedString("ListPlayersProfileShowMonthlySubscription",
                                       comment: "Monthly subscription"))
                Spacer()
                Text("\(viewModel.player.subscription ? Text(NSLocalizedString("ListPlayersProfileShowActive", comment: "active")).foregroundColor(Color.green) : Text(NSLocalizedString("ListPlayersProfileShowNotActive", comment: "not active")).foregroundColor(Color.red))")
                    .font(.headline)
            }
            
            HStack {
                Text(NSLocalizedString("ListPlayersProfileShowImGoingToNextGame",
                                       comment: "Going to the next game:"))
                Spacer()
                Text("\(viewModel.player.iGo ? Text(NSLocalizedString("ListPlayersProfileShowYes", comment: "yes")).foregroundColor(Color.green) : Text(NSLocalizedString("ListPlayersProfileShowNo", comment: "no")).foregroundColor(Color.red))")
                    .font(.headline)
            }
        } .onAppear { viewModel.playerID = player.id }
        
        .navigationBarTitle(Text(NSLocalizedString("ListPlayersProfileShowPersonalCard",
                                                   comment: "Personal card")), displayMode: .inline)
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
        ListPlayersProfileShow(player: DefaultPlayer.shared.player)
    }
}
