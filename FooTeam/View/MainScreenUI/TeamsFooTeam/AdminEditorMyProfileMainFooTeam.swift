//
//  AdminEditorMyProfileMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct AdminEditorMyProfileMainFooTeam: View {
    
    var currentUser: Players
    
    @Binding var showModal: Bool
    
    @State var newNumberOfGames = 0
    
    let whoAreYou = ["Игрок", "Зритель"]
    @State var selectionWhoAreYou = 0
    
    
    @State var dynamicName = ""
    @State var dynamicMail = ""
    @State var dynamicPayment = ""
    
    @State var dynamicNumberOfGames = 0
    @State var dynamicNumberOfGoals = 0
    @State var dynamicWinGame = 0
    @State var dynamicLosGame = 0
    
    @State var iGo = true
    @State var subscription = true
    
    let positions = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    @State var selection = 0
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                      colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                                      backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)),
                                      namePlayer: "\(currentUser.name)",
                    photoPlayer: "\(currentUser.avatarStringURL)",
                    ratingPlayer: "\(currentUser.rating)",
                    positionPlayer: "\(currentUser.position)",
                    game: "\(currentUser.numberOfGames)",
                    goal: "\(currentUser.numberOfGoals)",
                    win: "\(currentUser.winGame)",
                    los: "\(currentUser.losGame)")
                
                
                
                Form {
                    
                    VStack {
                        HStack {
                            Text("Кто ты?")
                            Picker("dvdvd", selection: $selectionWhoAreYou) {
                                ForEach(0..<whoAreYou.count) {
                                    Text(self.whoAreYou[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            Text("Имя:")
                            TextField("\(self.currentUser.name)",
                                text: $dynamicName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onAppear() {
                                    self.dynamicName = self.currentUser.name
                            }
                        }
                        
                        HStack {
                            Text("Электронная почта:")
                            TextField("\(currentUser.email)",
                                text: $dynamicMail)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onAppear() {
                                    self.dynamicMail = self.currentUser.email
                            }
                        }
                    }
                    
                    if selectionWhoAreYou == 0 {
                        HStack {
                            Text("Баланс:")
                            TextField("\(currentUser.payment)",
                                text: $dynamicPayment)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onAppear() {
                                    self.dynamicPayment = self.currentUser.payment
                            }
                            Text(" FCoin")
                                .font(.headline)
                        }
                        
                        HStack {
                            Text("Месячная подписка:")
                            Spacer()
                            Toggle(isOn: $subscription) {
                                Text("\(subscription ? "активна" : "не активна")")
                                    .onAppear() {
                                        self.subscription = self.currentUser.subscription
                                }
                                .font(.headline)
                            }
                        }
                        
                        HStack {
                            Text("Идет на след. игру:")
                            Toggle(isOn: $iGo) {
                                Text("\(self.iGo ? "да" : "нет")")
                                    .font(.headline)
                                    .onAppear() {
                                        self.iGo = self.currentUser.iGo
                                }
                            }
                        }
                        
                        HStack {
                            Text("Позиция:")
                            Picker("dvdvd", selection: $selection) {
                                ForEach(0..<positions.count) {
                                    Text(self.positions[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            Text("Игр сыграл:")
                            Stepper("\(dynamicNumberOfGames)", value: $dynamicNumberOfGames)
                                .onAppear() {
                                    self.dynamicNumberOfGames = self.currentUser.numberOfGames
                            }
                        }
                        
                        HStack {
                            Text("Игр выиграл:")
                            Stepper("\(dynamicWinGame)", value: $dynamicWinGame)
                                .onAppear() {
                                    self.dynamicWinGame = self.currentUser.winGame
                            }
                        }
                        
                        HStack {
                            Text("Мячей забил:")
                            Stepper("\(dynamicNumberOfGoals)", value: $dynamicNumberOfGoals)
                                .onAppear() {
                                    self.dynamicNumberOfGoals = self.currentUser.numberOfGoals
                            }
                        }
                        
                        HStack {
                            Text("Игр проиграл:")
                            Stepper("\(dynamicLosGame)", value: $dynamicLosGame)
                                .onAppear() {
                                    self.dynamicLosGame = self.currentUser.losGame
                            }
                        }
                        
                        
                        
                    }
                }
                
                Button(action: {
                    
                    EditPlayer.shared.editPlayerInTeam(
                        player: self.currentUser,
                        name: self.dynamicName,
                        avatarImage: nil,
                        email: self.dynamicMail,
                        whoAreYou: self.whoAreYou[self.selectionWhoAreYou],
                        teamNumber: self.currentUser.teamNumber,
                        payment: self.dynamicPayment,
                        iGo: self.iGo,
                        subscription: self.subscription,
                        rating: self.currentUser.rating,
                        position: self.positions[self.selection],
                        numberOfGames: self.dynamicNumberOfGames,
                        numberOfGoals: self.dynamicNumberOfGoals,
                        winGame: self.dynamicWinGame,
                        losGame: self.dynamicLosGame,
                        captain: self.currentUser.captain)
                    
                    self.showModal = false
                    
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
                self.showModal = false
            }) {
                Image(systemName: "multiply")
                    .renderingMode(.original)
                    .font(.title)
            })
        }
    }
}

struct EditorMyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        AdminEditorMyProfileMainFooTeam(currentUser: (Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 60, position: "ФРВ", numberOfGames: 30, numberOfGoals: 60, winGame: 20, losGame: 10, captain: true)), showModal: .constant(false))
    }
}
