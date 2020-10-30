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
                    Color("WhiteAndBlack")
                        .frame(maxWidth: 150, idealHeight: 220, maxHeight: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20) .stroke(Color("BlackAndWhite")))
                    
                    VStack(alignment: .center) {
                        ImagePlayer(avatarStringURL: team.avatarStringURL, avatarSize: 100, placeholder: "team")
                            .padding(.top, 4)
                        
                        Text("\(team.teamName)")
                            .foregroundColor(Color("BlackAndWhite"))
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                        
                        Text("\(team.teamType)")
                            .font(.system(size: 20))
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .padding(.top, 1)
                            .minimumScaleFactor(0.7)
                        
                        Text("\(team.location)")
                            .foregroundColor(Color("BlackAndWhite"))
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.top, 1)
                            .minimumScaleFactor(0.7)
                        //                        Text("Игроков: \(countPlayersInTeam.players.count)")
                        //                            .foregroundColor(Color(colorText))
                        //                            .font(.system(size: 15))
                        //                            .lineLimit(1)
                    }
                    .frame(maxWidth: 160, idealHeight: 170, maxHeight: 170)
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
        } .padding(.top)
        .fullScreenCover(isPresented: $viewModel.isPresented) { WaitingForConfirmationView() }
    }
    
    struct CellJoinTeamViewController_Previews: PreviewProvider {
        static var previews: some View {
            CellJoinToTeamView(team: Team(avatarStringURL: "", teamName: "Teadfdfd", location: "Rus", teamType: "Type", rating: 80, countPlayersInTeam: 18))
        }
    }
}
