//
//  CellJoinToTeamView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth


struct CellJoinToTeamView: View {
    
    @StateObject private var viewModel = CellJoinToTeamViewModel()
    var team: Team
    
    var body: some View {
        
        VStack {
            Button(action: { viewModel.showAlertAccept.toggle() } ) {
                ZStack {
                    BackgroundFooTeam(centerColor: Color.black)
                        .frame(width: 170, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack(alignment: .center) {
                        ImagePlayer(avatarStringURL: team.avatarStringURL, avatarSize: 100, placeholder: "team")
                        
                        Text("\(team.teamName)")
                            .foregroundColor(Color(viewModel.colorText))
                            .font(.headline)
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                        
                        Text("\(team.teamType)")
                            .font(.system(size: 15))
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .padding(.top, 1)
                        
                        Text("\(team.location)")
                            .foregroundColor(Color(viewModel.colorText))
                            .font(.system(size: 15))
                            .padding(.top, 1)
                        //                        Text("Игроков: \(countPlayersInTeam.players.count)")
                        //                            .foregroundColor(Color(colorText))
                        //                            .font(.system(size: 15))
                        //                            .lineLimit(1)
                    }
                    .frame(width: 160, height: 170)
                }
                
                .alert(isPresented: $viewModel.showAlertAccept) {
                    Alert(title: Text("Отправить запрос команде?"),
                          primaryButton: .default(Text("Отправить запрос")) {
                            JoinTheTeam.shared.SaveIDinTeam(player: FirestoreService.shared.currentUser, team: team)
                            viewModel.isPresented = true
                          },
                          secondaryButton: .destructive(Text("Отмена")))
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.isPresented) { WaitingForConfirmationView() }
    }
    
    struct CellJoinTeamViewController_Previews: PreviewProvider {
        static var previews: some View {
            CellJoinToTeamView(team: Team(avatarStringURL: "", teamName: "Teadfdfd", location: "Rus", teamType: "Type", rating: 80))
        }
    }
}
