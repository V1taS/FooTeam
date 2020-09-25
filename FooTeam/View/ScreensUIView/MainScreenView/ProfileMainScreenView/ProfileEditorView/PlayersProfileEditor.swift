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
    @Binding var closeIsPresentedShowModal: Bool
    var player: Player
    @State var deletPlayer = false
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(backgroundColor: Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)),
                                      namePlayer: "\(viewModel.name)",
                                      photoPlayer: "\(viewModel.avatarStringURL)",
                                      ratingPlayer: "\(viewModel.rating)",
                                      positionPlayer: "\(viewModel.position)",
                                      game: "\(viewModel.numberOfGames)",
                                      goal: "\(viewModel.numberOfGoals)",
                                      win: "\(viewModel.winGame)",
                                      los: "\(viewModel.losGame)")
                    .padding(.vertical)
                Form {
                    
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
                            TextField("\(self.viewModel.name)",
                                      text: $viewModel.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Электронная почта:")
                            TextField("\(viewModel.email)",
                                      text: $viewModel.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    
                    
                    if viewModel.selectionWhoAreYou == 0 {
                        if FirestoreService.shared.currentUser.captain {
                            HStack {
                                Text("Баланс:")
                                TextField("\(viewModel.payment)",
                                          text: $viewModel.payment)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Text(" FCoin")
                                    .font(.headline)
                            }
                        }
                        
                        if FirestoreService.shared.currentUser.captain {
                            HStack {
                                Text("Месячная подписка:")
                                Spacer()
                                Toggle(isOn: $viewModel.subscription) {
                                    Text("\(viewModel.subscription ? "активна" : "не активна")")
                                        .font(.headline)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Идет на след. игру:")
                            Toggle(isOn: $viewModel.iGo) {
                                Text("\(self.viewModel.iGo ? "да" : "нет")")
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
                                Text("Игр сыграл:")
                                Stepper("\(viewModel.numberOfGames)", value: $viewModel.numberOfGames)
                            }
                            
                            HStack {
                                Text("Игр выиграл:")
                                Stepper("\(viewModel.winGame)", value: $viewModel.winGame)
                            }
                            
                            HStack {
                                Text("Мячей забил:")
                                Stepper("\(viewModel.numberOfGoals)", value: $viewModel.numberOfGoals)
                            }
                            
                            HStack {
                                Text("Игр проиграл:")
                                Stepper("\(viewModel.losGame)", value: $viewModel.losGame)
                            }
                            
                            HStack {
                                Text("Удалить игрока из команды?")
                                Toggle(isOn: $deletPlayer) {
                                    Text("\(self.deletPlayer ? "да" : "нет")")
                                        .font(.headline)
                                }
                            }
                        }
                        
                    }
                }
                
                Button(action: {
                    
                    if deletPlayer {
                        DeletPlayer.shared.deletPlayerInTeam(playerID: player.id)
                        self.closeIsPresentedShowModal = false
                    } else {
                        
                        EditPlayer.shared.editPlayerInTeam(
                            player: self.viewModel.currentPlayer,
                            players: self.viewModel.currentPlayers,
                            name: self.viewModel.name,
                            avatarImage: nil,
                            email: self.viewModel.email,
                            whoAreYou: self.viewModel.whoAreYou[self.viewModel.selectionWhoAreYou],
                            teamNumber: nil,
                            payment: self.viewModel.payment,
                            iGo: self.viewModel.iGo,
                            subscription: self.viewModel.subscription,
                            rating: self.viewModel.rating,
                            position: self.viewModel.positions[self.viewModel.selectionPositions],
                            numberOfGames: self.viewModel.numberOfGames,
                            numberOfGoals: self.viewModel.numberOfGoals,
                            winGame: self.viewModel.winGame,
                            losGame: self.viewModel.losGame,
                            captain: self.viewModel.captain)
                        
                        self.closeIsPresentedShowModal = false
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
            }
            
            .navigationBarTitle(Text("Редактирование"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.closeIsPresentedShowModal = false
            }) {
                Image(systemName: "multiply")
                    .renderingMode(.original)
                    .font(.title)
            })
        }
    }
}

struct ListPlayersProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        PlayersProfileEditor(closeIsPresentedShowModal: .constant(false), player: Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false))
    }
}
