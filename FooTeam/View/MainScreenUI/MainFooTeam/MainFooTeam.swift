//
//  MainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct MainFooTeam: View {
    
    @Binding var player: Players?
    @State var isPresentedAlertSignOut = false
    @State var isPresentedAlertJoinTeam = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HeaderMainFooTeam(player: $player)
                    
                    HStack {
                        ProfileMainFooTeam(player: $player)
                        Spacer()
                        InformationMainFooTeam(player: $player)
                    } . padding(.horizontal)
                    
                    MyTeamMainFooTeam(player: $player)
                    
                    Spacer()
                }
                    
                .navigationBarItems(trailing:
                    OutButtonFooTeamMenu(isPresentedAlertSignOut: $isPresentedAlertSignOut))
                    
                    .navigationBarTitle("Главная", displayMode: .inline)
            }
        }
    }
}

struct MainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MainFooTeam(player: .constant(Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
    }
}
