//
//  AdminEditorMyProfileMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct AdminEditorMyProfileMainFooTeam: View {
    
    @Binding var player: Players?
    @Binding var showModal: Bool
    
    @State var selection = 0
    @State var newNumberOfGames = 0
    @State var subscription = true
    @State var iGo = true
    
    let positions = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                      colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                                      backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)),
                                      namePlayer: "\(player?.name ?? "noName")",
                    photoPlayer: "\(player?.avatarStringURL ?? "")",
                    ratingPlayer: "\(player?.rating ?? 0)",
                    positionPlayer: "\(player?.position ?? "")",
                    game: "\(player?.numberOfGames ?? 0)",
                    goal: "\(player?.numberOfGoals ?? 0)",
                    win: "\(player?.numberOfGoals ?? 0)",
                    los: "\(player?.losGame ?? 0)")
                
                
                
                Form {
                    
                    HStack {
                        Text("Позиция:")
                        Spacer()
                        Picker("dvdvd", selection: $selection) {
                            ForEach(0..<positions.count) {
                                Text(self.positions[$0])
                            }
                        } .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        Text("Имя:")
                        TextField("", text: .constant(player?.name ?? ""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Text("Игр сыграл:")
                        Stepper("\(player!.numberOfGames)", value: $newNumberOfGames)
                    }
                    
                    HStack {
                        Text("Игр выиграл:")
                        Stepper("\(player!.winGame)", value: $newNumberOfGames)
                    }
                    
                    HStack {
                        Text("Игр проиграл:")
                        Stepper("\(player!.losGame)", value: $newNumberOfGames)
                    }
                    
                    HStack {
                        Text("Мячей забил:")
                        Stepper("\(player!.numberOfGoals)", value: $newNumberOfGames)
                    }
                    
                    
                    HStack {
                        Text("Играет в команде:")
                        Spacer()
                        Text("убрать из")
                            .foregroundColor(.red)
                        Text("\(player?.nameTeam ?? "")")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Баланс:")
                        Spacer()
                        Text("изменить")
                            .foregroundColor(Color.green)
                        Text("\(player?.payment ?? "0") FCoin")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Месячнвя подписка:")
                        Spacer()
                        Toggle(isOn: $subscription) {
                            
                            Text("\(player?.subscription ?? false ? "активна" : "не активна")")
                                .font(.headline)
                        }
                    }
                    
                    HStack {
                        Text("Идет на след. игру:")
                        Spacer()
                        Toggle(isOn: $iGo) {
                            Text("\(player?.iGo ?? false ? "да" : "нет")")
                                .font(.headline)
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
                
                
                
                
            .navigationBarTitle(Text("Персональная карточка"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showModal = false
            }) {
                Image(systemName: "multiply")
                    .renderingMode(.original)
                    .font(.headline)
            })
        }
    }
}

struct EditorMyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        AdminEditorMyProfileMainFooTeam(player: .constant(Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 60, position: "ФРВ", numberOfGames: 30, numberOfGoals: 60, winGame: 20, losGame: 10, captain: true)), showModal: .constant(false))
    }
}
