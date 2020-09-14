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
    
    @ObservedObject var currentUser = CurrentUser()
    @ObservedObject var teamsListener = TeamsListener()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(teamsListener.teams, id: \.self) { team in
                        CellJoinTeamViewController(team: team, currentUser: self.currentUser)
                            .padding(.top)
                    }
                    
                    Spacer()
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
