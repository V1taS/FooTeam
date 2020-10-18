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
            
            .navigationBarTitle(Text("Присоединиться"))
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
            Alert(title: Text("Внимание"),
                  message: Text("Вы хотите создать свою собственную команду?"),
                  primaryButton: Alert.Button.default(Text("Отмена")),
                  secondaryButton: Alert.Button.destructive(
                    Text("Создать"), action: {
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
