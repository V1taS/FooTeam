//
//  ProfileEditorView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ProfileEditorView: View {
    
    @StateObject private var viewModel = ProfileEditorViewModel()
    @Binding var closeIsPresentedShowModal: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                      colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                                      backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)),
                                      namePlayer: "\(viewModel.name)",
                                      photoPlayer: "\(viewModel.avatarStringURL)",
                                      ratingPlayer: "\(viewModel.rating)",
                                      positionPlayer: "\(viewModel.position)",
                                      game: "\(viewModel.numberOfGames)",
                                      goal: "\(viewModel.numberOfGoals)",
                                      win: "\(viewModel.winGame)",
                                      los: "\(viewModel.losGame)")
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
                        HStack {
                            Text("Баланс:")
                            TextField("\(viewModel.payment)",
                                      text: $viewModel.payment)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text(" FCoin")
                                .font(.headline)
                        }
                        
                        HStack {
                            Text("Месячная подписка:")
                            Spacer()
                            Toggle(isOn: $viewModel.subscription) {
                                Text("\(viewModel.subscription ? "активна" : "не активна")")
                                    .font(.headline)
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
                        
                        
                        
                    }
                }
                
                Button(action: {
                    
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

//struct EditorMyProfileMainFooTeam_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminEditorMyProfileMainFooTeam(currentUser: (Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 60, position: "ФРВ", numberOfGames: 30, numberOfGoals: 60, winGame: 20, losGame: 10, captain: true)), showModal: .constant(false))
//    }
//}
