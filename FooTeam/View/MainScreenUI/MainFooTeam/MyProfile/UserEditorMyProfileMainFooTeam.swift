//
//  UserEditorMyProfileMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct UserEditorMyProfileMainFooTeam: View {
    
    @Binding var showModal: Bool
    let currentUser: CurrentUser
    
    @State var dynamicName = ""
    @State var iGo = true
    
    let positions = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    @State var selection = 0
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                      colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                                      backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)),
                                      namePlayer: "\(currentUser.player?.name ?? "Игрок")",
                    photoPlayer: "\(currentUser.player?.avatarStringURL ?? "")",
                    ratingPlayer: "\(currentUser.player?.rating ?? 99)",
                    positionPlayer: "\(currentUser.player?.position ?? "ФРВ")",
                    game: "\(currentUser.player?.numberOfGames ?? 10)",
                    goal: "\(currentUser.player?.numberOfGoals ?? 20)",
                    win: "\(currentUser.player?.winGame ?? 9)",
                    los: "\(currentUser.player?.losGame ?? 1)")
                
                
                
                Form {
                    
                    HStack {
                        Text("Позиция:")
                        Picker("dvdvd", selection: $selection) {
                            ForEach(0..<positions.count) { Text(self.positions[$0]) }
                        } .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        Text("Имя:")
                        TextField("\(currentUser.player?.name ?? "")",
                            text: $dynamicName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onAppear() {
                                self.dynamicName = self.currentUser.player?.name ?? ""
                        }
                    }
                    
                    HStack {
                        Text("Идет на след. игру:")
                        Spacer()
                        Toggle(isOn: $iGo) {
                            Text("\(self.iGo ? "да" : "нет")")
                                .font(.headline)
                                .onAppear() {
                                    self.iGo = self.currentUser.player?.iGo ?? false
                            }
                        }
                    }
                }
                
                
                Button(action: {
                    EditPlayer.shared.editPlayerInTeam(
                        player: self.currentUser.player!,
                        name: self.dynamicName,
                        avatarImage: nil,
                        email: self.currentUser.player!.email,
                        whoAreYou: self.currentUser.player!.whoAreYou,
                        teamNumber: self.currentUser.player!.teamNumber,
                        payment: self.currentUser.player!.payment,
                        iGo: self.iGo,
                        subscription: self.currentUser.player!.subscription,
                        rating: self.currentUser.player!.rating,
                        position: self.positions[self.selection],
                        numberOfGames: self.currentUser.player!.numberOfGames,
                        numberOfGoals: self.currentUser.player!.numberOfGoals,
                        winGame: self.currentUser.player!.winGame,
                        losGame: self.currentUser.player!.losGame,
                        captain: self.currentUser.player!.captain)
                    
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

struct UserEditorMyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        UserEditorMyProfileMainFooTeam(showModal: .constant(false),
                                       currentUser: CurrentUser())
    }
}
