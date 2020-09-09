//
//  AdminEditorMyProfileMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct AdminEditorMyProfileMainFooTeam: View {
    
    var player: Players
    
    @Binding var showModal: Bool
    
    @State var selection = 0
    @State var newNumberOfGames = 0
    @State var subscription = true
    @State var iGo = true
    @State var playInTeam = true
    
    @State var selectionWhoAreYou = 0
    let whoAreYou = ["Игрок", "Зритель"]
    
    let positions = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                      colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                                      backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)),
                                      namePlayer: "\(player.name)",
                    photoPlayer: "\(player.avatarStringURL)",
                    ratingPlayer: "\(player.rating)",
                    positionPlayer: "\(player.position)",
                    game: "\(player.numberOfGames)",
                    goal: "\(player.numberOfGoals)",
                    win: "\(player.numberOfGoals)",
                    los: "\(player.losGame)")
                
                
                
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
                            TextField("", text: .constant(player.name))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Электронная почта:")
                            TextField("\(player.email)", text: .constant(player.email))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    
                    if selectionWhoAreYou == 0 {
                        HStack {
                            Text("Баланс:")
                            Spacer()
                            TextField("\(player.payment)", text: .constant(player.payment))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text(" FCoin")
                                .font(.headline)
                        }
                        
                        HStack {
                            Text("Играет в команде:")
                            Spacer()
                            Toggle(isOn: $playInTeam) {
                                Text("\(player.nameTeam)")
                                    .font(.headline)
                            }
                        }
                        
                        HStack {
                            Text("Месячная подписка:")
                            Spacer()
                            Toggle(isOn: $subscription) {
                                
                                Text("\(player.subscription ? "активна" : "не активна")")
                                    .font(.headline)
                            }
                        }
                        
                        HStack {
                            Text("Идет на след. игру:")
                            Spacer()
                            Toggle(isOn: $iGo) {
                                Text("\(player.iGo ? "да" : "нет")")
                                    .font(.headline)
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
                            Stepper("\(player.numberOfGames)", value: $newNumberOfGames)
                        }
                        
                        HStack {
                            Text("Игр выиграл:")
                            Stepper("\(player.winGame)", value: $newNumberOfGames)
                        }
                        
                        HStack {
                            Text("Игр проиграл:")
                            Stepper("\(player.losGame)", value: $newNumberOfGames)
                        }
                        
                        HStack {
                            Text("Мячей забил:")
                            Stepper("\(player.numberOfGoals)", value: $newNumberOfGames)
                        }
                        
                    }
                }
                
                
                
                
                
                
                
                VStack {
                    Text("Сохранить")
                        .font(.headline)
                        .padding(.horizontal)
                        .background(Color.green)
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
        AdminEditorMyProfileMainFooTeam(player: (Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 60, position: "ФРВ", numberOfGames: 30, numberOfGoals: 60, winGame: 20, losGame: 10, captain: true)), showModal: .constant(false))
    }
}
