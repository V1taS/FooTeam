//
//  ContentFooTeamMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import FirebaseAuth
import SwiftUI

struct ContentFooTeam: View {
    
    @State var index = 0
    @State var show = false
    @State var isPresentedAlertSignOut = false
    
    @State var player = FirestoreService.shared.currentUser
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 12) {
                    WellcomeFooTeamMenu(player: $player)
                    BoxButtonFooTeamMenu(index: $index, show: $show)
                        .padding(.top)
                    DividerFooTeamMenu()
                    OutButtonFooTeamMenu(isPresentedAlertSignOut: $isPresentedAlertSignOut)
                }
                .offset(x: 0, y: -50)
                .padding(.horizontal,20)
                Spacer(minLength: 0)
            }
            
            MainContentFooTeam(index: $index, show: $show)
            
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentFooTeam(index: 0, show: false, isPresentedAlertSignOut: false,  player: Players(name: "Виталий Сосин", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "12345", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true))
    }
}
