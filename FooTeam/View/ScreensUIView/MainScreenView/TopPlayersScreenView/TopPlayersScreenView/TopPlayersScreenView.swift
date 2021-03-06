//
//  TopPlayersFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct TopPlayersScreenView: View {
    
    @ObservedObject private var viewModel = TopPlayersScreenViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 16) {
                ForEach(viewModel.players, id: \.self) { player in
                    CellTopPlayersFooTeam(
                        namePlayer: player.name,
                        photoPlayer: player.avatarStringURL,
                        ratingPlayer: "\(player.rating)",
                        positionPlayer: PositionFromIntToString.shared.setPosition(
                            position: player.position
                        ),
                        locationCountryImage: "",
                        logoTeamImage: viewModel.currentTeam.team.avatarStringURL ,
                        game: "\(player.winGame + player.losGame)",
                        goal: "\(player.numberOfGoals)",
                        win: "\(player.winGame)",
                        los: "\(player.losGame)"
                    )
                    .scaleEffect(0.7)
                    .frame(width: 140, height: 215)
                }
            }
            .padding(.horizontal)
        } .offset(x: 0, y: -5)
    }
}

struct TopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TopPlayersScreenView()
    }
}
