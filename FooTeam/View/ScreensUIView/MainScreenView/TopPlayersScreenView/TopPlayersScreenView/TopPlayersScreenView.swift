//
//  TopPlayersFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct TopPlayersScreenView: View {
    
    @StateObject private var viewModel = TopPlayersScreenViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
                ForEach(viewModel.playersMain, id: \.self) { player in
                    
                    CellTopPlayersFooTeam(backgroundColor: Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)), namePlayer: player.name, photoPlayer: player.avatarStringURL, ratingPlayer: "\(player.rating)", positionPlayer: "\(player.position)", game: "\(player.numberOfGames)", goal: "\(player.numberOfGoals)", win: "\(player.winGame)", los: "\(player.losGame)")
                        .padding(.vertical, 1)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct TopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TopPlayersScreenView()
    }
}
