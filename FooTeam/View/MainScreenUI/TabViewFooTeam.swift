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
    
    @State var player = FirestoreService.shared.currentUser
    @State var listPlayers = FirestoreService.shared.listPlayers
    
    var body: some View {
        TabView {
            MainFooTeam(player: $player, listPlayers: $listPlayers)
                .tabItem {
                    Image(systemName: "shield")
                    Text("Главная")
            }
            
            ListPlayersFooTeam(player: $player, listPlayers: $listPlayers)
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Составы ")
            }
            
            Text("Second Content")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Чат")
            }
            
            Text("Second Content")
                .tabItem {
                    Image(systemName: "4.circle")
                    Text("Спонсоры")
            }
            
            Text("Second Content")
                .tabItem {
                    Image(systemName: "5.circle")
                    Text("Клуб")
            }
        }
    }
}

struct TabViewFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TabViewFooTeam()
    }
}
