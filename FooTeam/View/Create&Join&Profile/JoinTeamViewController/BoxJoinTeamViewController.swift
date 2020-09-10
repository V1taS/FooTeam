//
//  BoxJoinTeamViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct BoxJoinTeamViewController: View {
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    @State var showAlert = false
    
    let player: Players
    @ObservedObject var teamsListener = TeamsListener()
    @ObservedObject var playersListener = PlayersListener()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: { self.showAlert.toggle() } ) {
                    CellJoinTeamViewController()
                        .padding(.top)
                }
                Spacer()
                
            } .alert(isPresented: $showAlert) {
                Alert(title: Text("Отправить запрос команде?"),
                      primaryButton: .default(Text("Отправить запрос")) {
                        
                        JoinTheTeam.shared.SaveIDinTeam(player: self.player, team: self.teamsListener.teams.first!)
                        
                    },
                      secondaryButton: .destructive(Text("Отмена")))
            }
                
                .navigationBarTitle(Text("Присоединиться"))
        }
    }
}

struct BoxJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        BoxJoinTeamViewController( player: Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: true, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true))
    }
}
