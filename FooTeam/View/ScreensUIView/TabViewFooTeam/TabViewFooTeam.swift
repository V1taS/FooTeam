//
//  TabViewFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct TabViewFooTeam: View {
    
    @StateObject private var viewModel = TabViewFooTeamModel()
    
    var body: some View {
        ZStack {
            
            TabView {
                MainScreenView(showAcceptPlayers: $viewModel.showAcceptPlayers)
                    .tabItem {
                        Image(systemName: "rectangle.3.offgrid.bubble.left")
                        Text("Главная")
                    }
                
                ListPlayersSecondScreenView()
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text("Команда")
                    }
            }
            
            if FirestoreService.shared.currentUser.captain {
                if viewModel.showAcceptPlayers {
                    AcceptPlayersView(players: $viewModel.players, showAcceptPlayers: $viewModel.showAcceptPlayers)
                }
            }
        }
    }
}

struct TabViewFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TabViewFooTeam()
    }
}
