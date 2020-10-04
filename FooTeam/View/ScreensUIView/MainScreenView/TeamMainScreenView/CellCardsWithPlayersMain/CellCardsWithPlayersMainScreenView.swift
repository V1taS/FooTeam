//
//  CellCardsWithPlayersMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellCardsWithPlayersMainScreenView: View {
    
    @StateObject private var viewModel = CellCardsWithPlayersMainScreenViewModel()
    @ObservedObject var currentTeam = CurrentTeam()
    
    @Binding var selectTeams: Int
    
    @State var viewState = CGSize.zero
    @State var show = false
    
    var body: some View {
        
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 190))], spacing: 0) {
                    ForEach(viewModel.teamsNumber.filter { $0.teamNumber == selectTeams }, id: \.self) { player in
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
                            .scaleEffect(0.52)
                            .frame(width: 50, height: 145)
                            .padding(.vertical, 8)
                    }
                }
            }
            .frame(height: 330)
        }
    }
}

struct BoxPositionsMyTeamMFT_Previews: PreviewProvider {
    static var previews: some View {
        CellCardsWithPlayersMainScreenView(selectTeams: .constant(0))
    }
}
