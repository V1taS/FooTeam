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
    
    var topPlayers: [Player] {
        playersListener.players.filter { $0.rating >= 50 }
    }
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(topPlayers, id: \.self) { player in
                        CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                              colorText: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                              backgroundColor: Color(#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)),
                                              namePlayer: player.name,
                                              photoPlayer: player.avatarStringURL,
                                              ratingPlayer: "\(player.rating)",
                            positionPlayer: player.position,
                            game: "\(player.numberOfGames)",
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