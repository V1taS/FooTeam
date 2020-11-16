//
//  ProfileShowModalMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ProfileShowModalMainScreenView: View {
    
    @StateObject private var viewModel = ProfileShowModalMainScreenViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    CellTopPlayersFooTeam(
                        namePlayer: "\(viewModel.player.name)",
                        photoPlayer: "\(viewModel.player.avatarStringURL)",
                        ratingPlayer: "\(viewModel.player.rating)",
                        positionPlayer: PositionFromIntToString.shared.setPosition(
                            position: viewModel.player.position
                        ),
                        locationCountryImage: "",
                        logoTeamImage: viewModel.team.avatarStringURL ,
                        game: "\(viewModel.player.winGame + viewModel.player.losGame)",
                        goal: "\(viewModel.player.numberOfGoals)",
                        win: "\(viewModel.player.winGame)",
                        los: "\(viewModel.player.losGame)"
                    )
                    .padding(.vertical, 8)
                    Spacer()
                }
                
                HStack {
                    Text(
                        NSLocalizedString("ProfileShowModalMainScreenViewPlayingInTeam",
                                          comment: "Playing in a team")
                    )
                    Spacer()
                    Text("\(viewModel.team.teamName)")
                        .font(.headline)
                }
                
                HStack {
                    Text(
                        NSLocalizedString("ProfileShowModalMainScreenViewPersonalBalance",
                                          comment: "Personal balance")
                    )
                    Spacer()
                        .foregroundColor(Color.green)
                    Text("\(viewModel.player.payment) FCoin")
                        .font(.headline)
                }
                
                HStack {
                    Text(
                        NSLocalizedString("ProfileShowModalMainScreenViewMonthlySubscription",
                                          comment: "Monthly subscription")
                    )
                    Spacer()
                    Text("\(viewModel.player.subscription ? Text(NSLocalizedString("ProfileShowModalMainScreenViewActive", comment: "active")).foregroundColor(Color.green) : Text(NSLocalizedString("ProfileShowModalMainScreenViewNotActive", comment: "not active")).foregroundColor(Color.red))")
                        .font(.headline)
                }
                
                HStack {
                    Text(
                        NSLocalizedString("ProfileShowModalMainScreenViewImGoingToNextGame",
                                          comment: "I'm going to the next game")
                    )
                    Spacer()
                    Text("\(viewModel.player.iGo ? Text(NSLocalizedString("ProfileShowModalMainScreenViewYes", comment: "yes")).foregroundColor(Color.green) : Text(NSLocalizedString("ProfileShowModalMainScreenViewNo", comment: "no")).foregroundColor(Color.red))")
                        .font(.headline)
                }
                
                HStack {
                    Spacer()
                    Button(action: { viewModel.isPresentedAlert.toggle()} ) {
                        Text(
                            NSLocalizedString("ProfileShowModalMainScreenViewExit",
                                              comment: "Exit")
                        )
                        .font(.system(.headline, design: .serif))
                        .foregroundColor(Color.red)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .cornerRadius(5)
                    }
                    .fullScreenCover(isPresented: $viewModel.outFromTeam, content: {
                        JoinToTeamView()
                    })
                    Spacer()
                }
            } .alert(isPresented: self.$viewModel.isPresentedAlert) {
                Alert(
                    title: viewModel.player.captain ?
                        Text(NSLocalizedString("ProfileShowModalMainScreenViewAttentionBeDeleted",
                                               comment: "Attention!!! The command will be deleted!")) :
                        Text(NSLocalizedString("ProfileShowModalMainScreenViewAttention",
                                               comment: "Attention")),
                    message: viewModel.player.captain ?
                        Text(NSLocalizedString("ProfileShowModalMainScreenViewExitAndDeleteCommand",
                                               comment: "Do you want to exit and delete the team?")) :
                        Text(NSLocalizedString("ProfileShowModalMainScreenViewOutTheTeam",
                                               comment: "Do you want to leave the team?")),
                    primaryButton: Alert.Button.default(Text(
                        NSLocalizedString("ProfileShowModalMainScreenViewCancel",
                                          comment: "Cancel")
                    )),
                    secondaryButton: Alert.Button.destructive(
                        Text(
                            NSLocalizedString("ProfileShowModalMainScreenViewGoOut",
                                              comment: "Go out")
                        ), action: {
                            DeletePlayerFromTeam.shared.deletPlayerFromTeam(player: viewModel.player)
                            
                            if viewModel.player.captain {
                                viewModel.players.forEach { player in
                                    DeletePlayerFromTeam.shared.deletPlayerFromTeam(player: player)
                                }
                                RemoveExcessTime.shared.removeTime(
                                    gameInWeak: 10,
                                    ref: CollectionReferenceForFirebase.shared.converteference(
                                        idTeam: viewModel.team.id
                                    )
                                )
                                DeletTeam.shared.deletTeamInTeam(teamId: viewModel.player.idTeam)
                            }
                            viewModel.outFromTeam.toggle()
                        }
                    )
                )
            }
            
            .navigationBarTitle(Text(
                NSLocalizedString("ProfileShowModalMainScreenViewPersonalCard",
                                  comment: "Personal card")
            ), displayMode: .inline)
            
            .navigationBarItems(
                leading: Button(action: {
                    BufferIDplayer.shared.saveUserID(id: viewModel.player.id)
                    self.viewModel.isPresentedProfileEditor.toggle()
                    
                }) {
                    Image(systemName: "pencil")
                        .font(.title)
                        .foregroundColor(Color("BlackAndWhite"))
                }.sheet(
                    isPresented: $viewModel.isPresentedProfileEditor,
                    content: { PlayersProfileEditor(player: viewModel.player) }
                ),
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "multiply")
                        .font(.title)
                        .foregroundColor(Color("BlackAndWhite"))
                })
        }
    }
}

struct MyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileShowModalMainScreenView()
    }
}
