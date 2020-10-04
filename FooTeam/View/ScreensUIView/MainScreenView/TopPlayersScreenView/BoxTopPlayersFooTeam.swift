//
//  BoxTopPlayersFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxTopPlayersFooTeam: View {
    
    @ObservedObject var playersListener = PlayersListener()
    @ObservedObject var currentTeam = CurrentTeam()
    
    var topPlayers: [Player] {
        playersListener.players.filter { $0.rating >= 50 }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(topPlayers, id: \.self) { player in
                    CellTopPlayersFooTeam(backgroundColor: Color(#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)),
                                          namePlayer: player.name,
                                          photoPlayer: player.avatarStringURL,
                                          ratingPlayer: "\(player.rating)",
                                          positionPlayer: player.position,
                                          locationCountryImage: "",
                                          logoTeamImage: currentTeam.team.avatarStringURL ?? "",
                                          game: "\(player.winGame + player.losGame)",
                                          goal: "\(player.numberOfGoals)",
                                          win: "\(player.winGame)",
                                          los: "\(player.losGame)")
                }
                
            } .frame(height: 300)
            
        }
    }
}

struct BoxTopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        BoxTopPlayersFooTeam()
    }
}
