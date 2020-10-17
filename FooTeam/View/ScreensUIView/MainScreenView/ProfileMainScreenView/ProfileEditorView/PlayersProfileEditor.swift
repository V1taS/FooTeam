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
                                                  positionPlayer: "\(viewModel.player.position)",
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
                            Text("Кто ты?")
                            Picker("dvdvd", selection: $viewModel.selectionWhoAreYou) {
                                ForEach(0..<viewModel.whoAreYou.count) {
                                    Text(self.viewModel.whoAreYou[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            Text("Имя:")
                            TextField("\(self.viewModel.player.name)",
                                      text: $viewModel.player.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Электронная почта:")
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
                                Text("Баланс:")
                                TextField("\(viewModel.player.payment)",
                                          text: $viewModel.player.payment)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Text(" FCoin")
                                    .font(.headline)
                            }
                        }
                        
                        if FirestoreService.shared.currentUser.captain {
                            HStack {
                                Text("Месячная подписка:")
                                Spacer()
                                Toggle(isOn: $viewModel.player.subscription) {
                                    Text("\(viewModel.player.subscription ? "активна" : "не активна")")
                                        .font(.headline)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Идет на след. игру:")
                            Toggle(isOn: $viewModel.player.iGo) {
                                Text("\(self.viewModel.player.iGo ? "да" : "нет")")
                                    .font(.headline)
                            }
                        }
                        
                        HStack {
                            Text("Позиция:")
                            Picker("dvdvd", selection: $viewModel.selectionPositions) {
                                ForEach(0..<viewModel.positions.count) {
                                    Text(self.viewModel.positions[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        if FirestoreService.shared.currentUser.captain {
                            
                            HStack {
                                Text("Игр выиграл:")
                                Stepper("\(viewModel.player.winGame)", value: $viewModel.player.winGame)
                            }
                            
                            HStack {
                                Text("Игр проиграл:")
                                Stepper("\(viewModel.player.losGame)", value: $viewModel.player.losGame)
                            }
                            
                            HStack {
                                Text("Мячей забил:")
                                Stepper("\(viewModel.player.numberOfGoals)", value: $viewModel.player.numberOfGoals)
                            }
                            
                            HStack {
                                Text("Сделать капитаном команды?")
                                Toggle(isOn: $viewModel.player.captain) {
                                    Text("\(viewModel.player.captain ? "да" : "нет")")
                                        .font(.headline)
                                }
                            }
                            
                            HStack {
                                Text("Удалить игрока из команды?")
                                Toggle(isOn: $viewModel.deletPlayer) {
                                    Text("\(viewModel.deletPlayer ? "да" : "нет")")
                                        .font(.headline)
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
                                    whoAreYou: self.viewModel.whoAreYou[self.viewModel.selectionWhoAreYou],
                                    teamNumber: nil,
                                    payment: self.viewModel.player.payment,
                                    iGo: self.viewModel.player.iGo,
                                    subscription: self.viewModel.player.subscription,
                                    rating: RatingOfPlayers.shared.setRating(
                                        position: viewModel.player.position,
                                        winGame: viewModel.player.winGame,
                                        losGame: viewModel.player.losGame,
                                        numberOfGoals: viewModel.player.numberOfGoals),
                                    position: self.viewModel.positions[self.viewModel.selectionPositions],
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
                            Text("Сохранить")
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
                
                .navigationBarTitle(Text("Редактирование"), displayMode: .inline)
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
                            EditPhotoView(player: viewModel.player, isPresentedChangeAvatar: $viewModel.isPresentedChangeAvatar, image: $viewModel.image)
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
