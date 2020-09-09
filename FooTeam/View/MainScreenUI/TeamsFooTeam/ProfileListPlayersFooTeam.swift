//
//  ProfileListPlayersFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ProfileListPlayersFooTeam: View {
    
    let player: Players
    @State var adminEditorShow = false
    
    var body: some View {
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
                HStack {
                    Text("Играет в команде:")
                    Spacer()
                    Text("\(player.nameTeam)")
                        .font(.headline)
                }
                
                HStack {
                    Text("Баланс:")
                    Spacer()
                    Text("\(player.payment) FCoin")
                        .font(.headline)
                }
                
                HStack {
                    Text("Месячнвя подписка:")
                    Spacer()
                    Text("\(player.subscription ? "активна" : "не активна")")
                        .font(.headline)
                }
                
                HStack {
                    Text("Идет на след. игру:")
                    Spacer()
                    Text("\(player.iGo ? "да" : "нет")")
                        .font(.headline)
                }
                
            }
                
            .navigationBarTitle(Text("Персональная карточка"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.adminEditorShow.toggle()
            }) {
                Image(systemName: "pencil").renderingMode(.original)
                    .font(.title)
                    .foregroundColor(Color.black)
            })
        } .sheet(
            isPresented: $adminEditorShow,
            content: { AdminEditorMyProfileMainFooTeam(player: self.player, showModal: self.$adminEditorShow) }
        )
        
    }
}

struct ProfileListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListPlayersFooTeam(player: Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: false, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true))
    }
}
