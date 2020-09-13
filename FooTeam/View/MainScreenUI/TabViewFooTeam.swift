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
    
    @ObservedObject var playersListener = PlayersListener()
    @ObservedObject var teamsListener = TeamsListener()
    
    
    var body: some View {
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
    }
    
    
}

struct TabViewFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TabViewFooTeam()
    }
}
