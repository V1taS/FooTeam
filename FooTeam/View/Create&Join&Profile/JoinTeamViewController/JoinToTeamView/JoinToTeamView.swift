//
//  JoinToTeamView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct JoinToTeamView: View {
    
    @StateObject private var viewModel = JoinToTeamViewModel()
    
    @StateObject private var currentUser = CurrentUser()
    
    @State var isPresentedAlertSignOut = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 190))], spacing: 10) {
                    ForEach(viewModel.teams, id: \.self) { team in
                        CellJoinToTeamView(team: team)
                            .padding(.top)
                            .frame(width: 170, height: 200)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .navigationBarTitle(Text("Присоединиться"))
            .navigationBarItems(trailing:
                                    OutButtonFooTeamMenu(isPresentedAlertSignOut: $isPresentedAlertSignOut))
        }
    }
}

struct BoxJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        JoinToTeamView()
    }
}
