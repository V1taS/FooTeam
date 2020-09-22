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
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
                    ForEach(viewModel.playersMain, id: \.self) { player in
                        
                        CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), colorText: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), backgroundColor: Color(#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)), namePlayer: player.name, photoPlayer: player.avatarStringURL, ratingPlayer: "\(player.rating)", positionPlayer: "\(player.position)", game: "\(player.numberOfGames)", goal: "\(player.numberOfGoals)", win: "\(player.winGame)", los: "\(player.losGame)")
                    }
                }
                .frame(width: 200, height: 300)
            }
        }
    }
}

struct TopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TopPlayersScreenView()
    }
}
