//
//  CardsWithPlayersMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CardsWithPlayersMainScreenView: View {
    
    //    @StateObject private var viewModel = CardsWithPlayersMainScreenViewModel()
    
    @ObservedObject var playersListener = PlayersListener()
    
    var teamOne: [Player] {
        playersListener.players.filter { $0.teamNumber == 0 }
    }
    
    var teamTwo: [Player] {
        playersListener.players.filter { $0.teamNumber == 1 }
    }
    
    var teamThree: [Player] {
        playersListener.players.filter { $0.teamNumber == 2 }
    }
    
    var teamFour: [Player] {
        playersListener.players.filter { $0.teamNumber == 3 }
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                ZStack {

                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(teamOne, id: \.self) { player in
                            Text("-  \(player.name)")
                                .foregroundColor(.white)
                                .font(.headline)
                                .offset(x: 0, y: 40)
                        }
                    }
                }
                
                ZStack {

                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(teamTwo, id: \.self) { player in
                            Text("-  \(player.name)")
                                .foregroundColor(.white)
                                .font(.headline)
                                .offset(x: 0, y: 40)
                        }
                    }
                }
                
                ZStack {

                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(teamThree, id: \.self) { player in
                            Text("-  \(player.name)")
                                .foregroundColor(.white)
                                .font(.headline)
                                .offset(x: 0, y: 40)
                        }
                    }
                }
            }
        }
    }
}

struct ListCompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        CardsWithPlayersMainScreenView()
    }
}
