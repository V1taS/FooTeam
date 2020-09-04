//
//  ListCompositionsMyTeamMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ListCompositionsMyTeamMainFooTeam: View {
    
    @ObservedObject var playersListener = PlayersListener()
    
    var teamOne: [Players] {
        playersListener.players.filter { $0.teamNumber == 1 }
    }
    
    var teamTwo: [Players] {
        playersListener.players.filter { $0.teamNumber == 2 }
    }
    
    var teamThree: [Players] {
        playersListener.players.filter { $0.teamNumber == 3 }
    }
    
    var teamFour: [Players] {
        playersListener.players.filter { $0.teamNumber == 4 }
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                ZStack {
                    BoxPositionsMyTeamMFT(teamnumber: 1, ratingTeam: 89, backgroundColor: #colorLiteral(red: 0.5169272423, green: 0.3713009357, blue: 0.09045822173, alpha: 1))
                    
                    VStack(alignment: .leading, spacing: 1) {
                        ForEach(teamOne, id: \.self) { player in
                            Text("\(player.name)")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.headline)
                                .padding(.top)
                        }
                    }
                }
                
                ZStack {
                    BoxPositionsMyTeamMFT(teamnumber: 2, ratingTeam: 93, backgroundColor: #colorLiteral(red: 0.3060370684, green: 0.3729676306, blue: 0.2559336424, alpha: 1))
                    
                    VStack(alignment: .leading, spacing: 1) {
                        ForEach(teamTwo, id: \.self) { player in
                            Text("\(player.name)")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.headline)
                                .padding(.top)
                        }
                    }
                }
                
                ZStack {
                    BoxPositionsMyTeamMFT(teamnumber: 3, ratingTeam: 90, backgroundColor: #colorLiteral(red: 0.1261743307, green: 0.3719377518, blue: 0.481738627, alpha: 1))
                    
                    VStack(alignment: .leading, spacing: 1) {
                        ForEach(teamThree, id: \.self) { player in
                            Text("\(player.name)")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.headline)
                                .padding(.top)
                        }
                    }
                }
                
                
            }
        }
        
        
        
        
    }
}

struct ListCompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListCompositionsMyTeamMainFooTeam()
    }
}
