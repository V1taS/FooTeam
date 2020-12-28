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
    
    @ObservedObject private var viewModel = TabViewFooTeamModel()
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    private var viewController: UIViewController? {
        self.viewControllerHolder!
    }
    
    var body: some View {
        ZStack {
            TabView {
                MainScreenView()
                    .tabItem {
                        Image(systemName: "rectangle.3.offgrid.bubble.left")
                        Text(NSLocalizedString("TabViewFooTeamMain",
                                               comment: "Main"))
                    }
                
                ListPlayersSecondScreenView()
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text(NSLocalizedString("TabViewFooTeamListPlayers",
                                               comment: "List of players"))
                    }
                
                TeamShowModalMainScreenView(showAcceptPlayers: $viewModel.showAcceptPlayers)
                    .tabItem {
                        Image(systemName: "dot.arrowtriangles.up.right.down.left.circle")
                        Text(NSLocalizedString("TabViewFooTeamTeam",
                                               comment: "Team"))
                    }
                
            }
            
            if FirestoreService.shared.currentUser.captain {
                if viewModel.showAcceptPlayers {
                    AcceptPlayersView(
                        players: $viewModel.players,
                        showAcceptPlayers: $viewModel.showAcceptPlayers
                    )
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
