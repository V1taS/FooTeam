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
    
    @ObservedObject private var viewModel = CellJoinToTeamViewModel()
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    private var viewController: UIViewController? {
        self.viewControllerHolder!
    }
    
    var team: Team
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.showAlertAccept.toggle()
            } ) {
                ZStack {
                    Color("WhiteAndBlack")
                        .frame(maxWidth: 150, idealHeight: 220, maxHeight: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("BlackAndWhite")))
                    
                    VStack(alignment: .center, spacing: 4) {
                        ImagePlayer(
                            avatarStringURL: team.avatarStringURL,
                            avatarSize: 100,
                            placeholder: "team"
                        )
                        .padding(.top, 4)
                        
                        Text("\(team.teamName)")
                            .foregroundColor(Color("BlackAndWhite"))
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                        
                        HStack {
                            Text(
                                NSLocalizedString("CellJoinToTeamViewModelPlayers",
                                                  comment: "Players")
                            )
                            .foregroundColor(Color("BlackAndWhite"))
                            .font(.footnote)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            
                            Text("\(team.currentCountPlayersInTeam)")
                                .foregroundColor(
                                    team.currentCountPlayersInTeam < team.maxCountPlayersInTeam ?
                                        Color("BlackAndWhite") :
                                        .red
                                )
                                .font(.footnote)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                            
                            Text(
                                NSLocalizedString("CellJoinToTeamViewModelFrom",
                                                  comment: "from")
                            )
                            .foregroundColor(Color("BlackAndWhite"))
                            .fontWeight(.bold)
                            .font(.footnote)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            
                            Text("\(team.maxCountPlayersInTeam)")
                                .foregroundColor(
                                    team.currentCountPlayersInTeam >= team.maxCountPlayersInTeam ?
                                        .red :
                                        Color("BlackAndWhite")
                                )
                                .font(.footnote)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        
                        Text("\(TeamTypeFromIntToString.shared.setTeamType(from: team.teamType))")
                            .font(.system(size: 20))
                            .foregroundColor(team.teamType == "1" ? .red : .green)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.7)
                        
                        Text("\(team.location)")
                            .foregroundColor(Color("BlackAndWhite"))
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.7)
                    }
                    .frame(maxWidth: 140, idealHeight: 170, maxHeight: 170)
                }
                
                .alert(isPresented: $viewModel.showAlertAccept) {
                    Alert(title: Text(
                        NSLocalizedString("CellJoinToTeamViewModelSendRequestToTheTeam",
                                          comment: "Send a request to the team?")
                    ),
                    primaryButton: .default(Text(
                        NSLocalizedString("CellJoinToTeamViewModelSendRequest",
                                          comment: "Send a request")
                    )) {
                        JoinTheTeam.shared.joinToTeam(
                            player: FirestoreService.shared.currentUser,
                            team: team
                        )
                        UserDefaults.standard.set(true, forKey: "waiting")
                        
                        self.viewController?.present(style: .fullScreen) {
                            WaitingForConfirmationView()
                        }
                        
                    },
                    secondaryButton: .destructive(Text(
                        NSLocalizedString("CellJoinToTeamViewModelCancel",
                                          comment: "Cancel")
                    )))
                }
            }
        } .padding(.top)
    }
    
    struct CellJoinTeamViewController_Previews: PreviewProvider {
        static var previews: some View {
            CellJoinToTeamView(team: DefaultTeam.shared.team)
        }
    }
}
