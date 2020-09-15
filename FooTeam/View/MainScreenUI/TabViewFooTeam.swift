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
    
    
    @State var viewState = CGSize.zero
    
    @ObservedObject var playersListener = PlayersListener()
    @ObservedObject var teamsListener = TeamsListener()
    
    @ObservedObject var waitingPlayers = WaitingPlayers()
    
    @State var showeWaitingPlayer = 0
    
    var body: some View {
        ZStack {
            
            TabView {
                MainFooTeam()
                    .tabItem {
                        Image(systemName: "shield")
                        Text("Главная")
                }
                
                ListPlayersFooTeam()
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text("Команда")
                }
                
                BoxJoinTeamViewController()
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text("Присоединиться")
                }
                
                MainWaitingMainFooTeam()
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text("Ожидают подтверждение")
                }
                
            }
            
            VStack {
                Spacer()
                PopapCard(showeWaitingPlayer: $showeWaitingPlayer)
                    .offset(y: CGFloat(!waitingPlayers.players.isEmpty ? showeWaitingPlayer : 1000))
                    .offset(y: viewState.height)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    .gesture(
                        DragGesture().onChanged { value in
                            self.viewState = value.translation
                            if self.viewState.height > 50 {
                                self.showeWaitingPlayer = 1000
                            }
                        }
                        .onEnded { value in
                            self.viewState = .zero
                        }
                )
            }
        }
    }
    
    
}

struct TabViewFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TabViewFooTeam()
    }
}
