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
    
    @State var isPresentedAlertSignOut = false
    
    let currentPlayer = FirestoreService.shared.currentUser

    @ObservedObject var teamsListener = TeamsListener()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(teamsListener.teams, id: \.self) { team in
                        CellJoinTeamViewController(team: team)
                            .padding(.top)
                    }
                    
                    Spacer()
                }.frame(width: 170, height: 200)
                .navigationBarTitle(Text("Присоединиться"))
            }
            .navigationBarItems(trailing:
            OutButtonFooTeamMenu(isPresentedAlertSignOut: $isPresentedAlertSignOut))
        }
    }
}

struct BoxJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        BoxJoinTeamViewController()
    }
}
