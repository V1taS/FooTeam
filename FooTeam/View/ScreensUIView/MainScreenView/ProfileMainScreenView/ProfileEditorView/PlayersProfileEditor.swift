//
//  ListPlayersProfileEditor.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct PlayersProfileEditor: View {
    
    @StateObject private var viewModel = PlayersProfileEditorViewModel()
    @Environment(\.presentationMode) var presentationMode
    var player: Player
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    HStack {
                        Spacer()
                        CellTopPlayersFooTeam(namePlayer: "\(viewModel.player.name)",
                                              photoPlayer: "\(viewModel.player.avatarStringURL)",
                                              ratingPlayer: "\(viewModel.player.rating)",
                                              positionPlayer: PositionFromIntToString.shared.setPosition(position: viewModel.player.position),
                                              locationCountryImage: "",
                                              logoTeamImage: viewModel.team.avatarStringURL,
                                              game: "\(viewModel.player.winGame + viewModel.player.losGame)",
                                              goal: "\(viewModel.player.numberOfGoals)",
                                              win: "\(viewModel.player.winGame)",
                                              los: "\(viewModel.player.losGame)")
                            .padding(.vertical, 8)
                        Spacer()
                    } .onTapGesture { viewModel.isPresentedChangeAvatar.toggle() }
                    
                    VStack {
                        HStack {
                            Text(NSLocalizedString("PlayersProfileEditorWhoAreYou", comment: "Who are you?"))
                            Picker("", selection: $viewModel.selectionWhoAreYou) {
                                ForEach(0..<viewModel.whoAreYou.count) {
                                    Text(self.viewModel.whoAreYou[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("PlayersProfileEditorName", comment: "Name"))
                            TextField("\(self.viewModel.player.name)",
                                      text: $viewModel.player.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("PlayersProfileEditorMail", comment: "Email"))
                            TextField("\(viewModel.player.email)",
                                      text: $viewModel.player.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        //                        HStack {
                        //                            Text("Пароль:")
                        //                            TextField("\(viewModel.passwordPlayer)",
                        //                                      text: $viewModel.passwordPlayer)
                        //                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        //                        }
                    }
                    
                    if viewModel.selectionWhoAreYou == 0 {
                        if FirestoreService.shared.currentUser.captain {
                            HStack {
                                Text(NSLocalizedString("PlayersProfileEditorBalance", comment: "Balance"))
                                TextField("\(viewModel.player.payment)",
                                          text: $viewModel.player.payment)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Text(" FCoin")
                                    .font(.headline)
                            }
                        }
                        
                        if FirestoreService.shared.currentUser.captain {
                            HStack {
                                Text(NSLocalizedString("PlayersProfileEditorMonthlySubscription", comment: "Monthly subscription"))
                                Spacer()
                                Toggle(isOn: $viewModel.player.subscription) {
                                    Text("\(viewModel.player.subscription ? Text(NSLocalizedString("PlayersProfileEditorActive", comment: "active")).foregroundColor(Color.green) : Text(NSLocalizedString("PlayersProfileEditorNotActive", comment: "not active")).foregroundColor(Color.red))")
                                        .font(.headline)
                                }
                            }
                        }
                        
                        HStack {
                            Text(NSLocalizedString("PlayersProfileEditorGoesToNextGame", comment: "Goes to the next game"))
                            Toggle(isOn: $viewModel.player.iGo) {
                                Text("\(self.viewModel.player.iGo ? Text(NSLocalizedString("PlayersProfileEditorYes", comment: "yes")).foregroundColor(Color.green) : Text(NSLocalizedString("PlayersProfileEditorNo", comment: "no")).foregroundColor(Color.red))")
                                    .font(.headline)
                            }
                        }
                        
                        HStack {
                            Text(NSLocalizedString("PlayersProfileEditorPosition", comment: "Position"))
                            Picker("", selection: $viewModel.selectionPositions) {
                                ForEach(0..<viewModel.positions.count) {
                                    Text(self.viewModel.positions[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        if FirestoreService.shared.currentUser.captain {
                            
                            HStack {
                                Text(NSLocalizedString("PlayersProfileEditorGamesWon", comment: "Games won"))
                                Stepper("\(viewModel.player.winGame)", value: $viewModel.player.winGame)
                            }
                            
                            HStack {
                                Text(NSLocalizedString("PlayersProfileEditorGamesLost", comment: "Games lost"))
                                Stepper("\(viewModel.player.losGame)", value: $viewModel.player.losGame)
                            }
                            
                            HStack {
                                Text(NSLocalizedString("PlayersProfileEditorGoalsScored", comment: "Goals scored"))
                                Stepper("\(viewModel.player.numberOfGoals)", value: $viewModel.player.numberOfGoals)
                            }
                            
                            if FirestoreService.shared.currentUser.captain != viewModel.player.captain {
                                HStack {
                                    Text(NSLocalizedString("PlayersProfileEditorMakeTeamCaptain", comment: "Make a team captain?"))
                                    Toggle(isOn: $viewModel.player.captain) {
                                        Text("\(viewModel.player.captain ? Text(NSLocalizedString("PlayersProfileEditorYes", comment: "yes")).foregroundColor(Color.red) : Text(NSLocalizedString("PlayersProfileEditorNo", comment: "no")).foregroundColor(Color.green))")
                                            .font(.headline)
                                    }
                                }
                                
                                HStack {
                                    Text(NSLocalizedString("PlayersProfileEditorRemovePlayerFromTeam", comment: "Remove a player from the team?"))
                                    Toggle(isOn: $viewModel.deletPlayer) {
                                        Text("\(viewModel.deletPlayer ? Text(NSLocalizedString("PlayersProfileEditorYes", comment: "yes")).foregroundColor(Color.red) : Text(NSLocalizedString("PlayersProfileEditorNo", comment: "no")).foregroundColor(Color.green))")
                                            .font(.headline)
                                    }
                                }
                            }
                            
                            
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            
                            if viewModel.deletPlayer {
                                DeletePlayerFromTeam.shared.deletPlayerFromTeam(player: player)
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                EditPlayer.shared.editPlayerInTeam(
                                    player: self.viewModel.player,
                                    players: self.viewModel.players,
                                    name: self.viewModel.player.name,
                                    avatarImage: self.viewModel.image,
                                    email: self.viewModel.player.email,
                                    whoAreYou: "\(self.viewModel.selectionWhoAreYou)",
                                    teamNumber: nil,
                                    payment: self.viewModel.player.payment,
                                    iGo: self.viewModel.player.iGo,
                                    subscription: self.viewModel.player.subscription,
                                    rating: RatingOfPlayers.shared.setRating(
                                        position: "\(viewModel.selectionPositions)",
                                        winGame: viewModel.player.winGame,
                                        losGame: viewModel.player.losGame,
                                        numberOfGoals: viewModel.player.numberOfGoals),
                                    position: "\(viewModel.selectionPositions)",
                                    numberOfGoals: self.viewModel.player.numberOfGoals,
                                    winGame: self.viewModel.player.winGame,
                                    losGame: self.viewModel.player.losGame,
                                    captain: self.viewModel.player.captain)
                                
                                if player.email != viewModel.player.email {
                                    AuthService.shared.updatingUserEmail(getEmailAddres: viewModel.player.email)
                                }
                                
                                //                                if !viewModel.passwordPlayer.isEmpty {
                                //                                    AuthService.shared.updatingUserPassword(getPassword: viewModel.passwordPlayer)
                                //                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        } ) {
                            Text(NSLocalizedString("PlayersProfileEditorSave", comment: "Save"))
                                .font(.system(.headline, design: .serif))
                                .foregroundColor(Color.black)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.green)
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                }
                
                .navigationBarTitle(Text(NSLocalizedString("PlayersProfileEditorEditing", comment: "Editing")), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply")
                        .font(.title)
                        .foregroundColor(Color("BlackAndWhite"))
                })
                
                if viewModel.isPresentedChangeAvatar {
                    ZStack {
                        Color.black.opacity(0.8)
                        ZStack {
                            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
                            EditPhotoViewPlayer(player: viewModel.player, isPresentedChangeAvatar: $viewModel.isPresentedChangeAvatar, image: $viewModel.image)
                        }
                        .frame(width: 330, height: 330)
                        .cornerRadius(20)
                        .offset(x: 0, y: 220)
                    } .edgesIgnoringSafeArea(.all)
                    
                }
            }
        }
    }
}

struct ListPlayersProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        PlayersProfileEditor(player: Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGoals: 0, winGame: 0, losGame: 9, captain: false))
    }
}
