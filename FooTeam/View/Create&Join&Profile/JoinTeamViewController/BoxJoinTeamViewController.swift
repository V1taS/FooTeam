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
    
    @ObservedObject var currentUser = CurrentUser()
    
    @ObservedObject var teamsListener = TeamsListener()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(teamsListener.teams, id: \.self) { team in
                        Button(action: { self.showAlert.toggle() } ) {
                            CellJoinTeamViewController(team: team)
                                .padding(.top)
                        }
                    }
                    
                    Spacer()
                    
                } .alert(isPresented: $showAlert) {
                    Alert(title: Text("Отправить запрос команде?"),
                          primaryButton: .default(Text("Отправить запрос")) {
                            
                            JoinTheTeam.shared.SaveIDinTeam(player: self.currentUser.player!, team: self.teamsListener.teams.first!)
                            
                        },
                          secondaryButton: .destructive(Text("Отмена")))
                }
                    
                .navigationBarTitle(Text("Присоединиться"))
            }
        }
    }
}

struct BoxJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        BoxJoinTeamViewController()
    }
}
