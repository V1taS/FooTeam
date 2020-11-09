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
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 190))], spacing: 10) {
                    ForEach(viewModel.teams, id: \.self) { team in
                        CellJoinToTeamView(team: team)
                    }
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .center)
            
            .navigationBarTitle(Text(NSLocalizedString("JoinToTeamViewModelJoin", comment:"Join")))
            .navigationBarItems(trailing:
                                    OutButtonFooTeamMenu(isPresentedAlertSignOut: $viewModel.isPresentedAlertSignOut))
            .navigationBarItems(
                leading: OutButtonFooTeamMenu(isPresentedAlertSignOut: $viewModel.isPresentedAlertSignOut),
                trailing: Button(action: { viewModel.isPresentedCreateTeam.toggle() }) {
                    Image(systemName: "person.badge.plus")
                        .renderingMode(.original)
                        .font(.title)
                })
        }
        .alert(isPresented: self.$viewModel.isPresentedCreateTeam) {
            Alert(title: Text(NSLocalizedString("JoinToTeamViewModelAttention", comment:"Attention")),
                  message: Text(NSLocalizedString("JoinToTeamViewModelCreateYourOwnTeam", comment:"Do you want to create your own team?")),
                  primaryButton: Alert.Button.default(Text(NSLocalizedString("JoinToTeamViewModelCancel", comment: "Cancel"))),
                  secondaryButton: Alert.Button.destructive(
                    Text(NSLocalizedString("JoinToTeamViewModelCancelCreate", comment: "Create")), action: {
                        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                        window?.rootViewController = CreateTeamViewController(
                            currentPlayer: FirestoreService.shared.currentUser,
                            currentUser: Auth.auth().currentUser!)
                  }
                )
            )
        }
    }
}

struct BoxJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        JoinToTeamView()
    }
}
