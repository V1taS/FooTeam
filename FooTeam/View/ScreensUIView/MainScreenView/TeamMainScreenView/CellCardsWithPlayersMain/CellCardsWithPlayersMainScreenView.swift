//
//  CellCardsWithPlayersMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellCardsWithPlayersMainScreenView: View {
    
    @ObservedObject private var viewModel = CellCardsWithPlayersMainScreenViewModel()
    @Binding var selectTeams: Int
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                if #available(iOS 14.0, *) {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 97,
                                                     maximum: 97))],
                        spacing: 0
                    ) {
                        ForEach(
                            viewModel.iGoPlayers.filter { $0.teamNumber == selectTeams },
                            id: \.self
                        ) { player in
                            CellTopPlayersFooTeam(namePlayer: player.name,
                                                  photoPlayer: player.avatarStringURL,
                                                  ratingPlayer: "\(player.rating)",
                                                  positionPlayer: PositionFromIntToString.shared.setPosition(
                                                    position: player.position
                                                  ),
                                                  locationCountryImage: "",
                                                  logoTeamImage: viewModel.currentTeam.team.avatarStringURL,                                          game: "\(player.winGame + player.losGame)",
                                                  goal: "\(player.numberOfGoals)",
                                                  win: "\(player.winGame)",
                                                  los: "\(player.losGame)")
                                .scaleEffect(0.5)
                                .frame(maxWidth: 50, idealHeight: 145, maxHeight: 145)
                                .padding(.vertical, 6)
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

struct BoxPositionsMyTeamMFT_Previews: PreviewProvider {
    static var previews: some View {
        CellCardsWithPlayersMainScreenView(selectTeams: .constant(0))
    }
}
