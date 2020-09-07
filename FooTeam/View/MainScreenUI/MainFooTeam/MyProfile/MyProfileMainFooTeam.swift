//
//  MyProfileMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyProfileMainFooTeam: View {
    
    @Binding var player: Players?
    @Binding var showModal: Bool
    
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
                        Text("Играю в команде:")
                        Spacer()
                        Text("\(player?.nameTeam ?? "")")
                            .font(.headline)
                        Text("выйти")
                            .foregroundColor(.red)
                    }
                    
                    HStack {
                        Text("Личный баланс:")
                        Spacer()
                        Text("\(player?.payment ?? "0") FCoin")
                            .font(.headline)
                        Text("пополнить")
                            .foregroundColor(Color.green)
                    }
                    
                    HStack {
                        Text("Месячнвя подписка:")
                        Spacer()
                        Text("\(player?.subscription ?? false ? "активна" : "не активна")")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Иду на след. игру:")
                        Spacer()
                        Text("\(player?.iGo ?? false ? "да" : "нет")")
                            .font(.headline)
                    }
                    
                }
                
                
                VStack {
                    Text("Редактировать")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(player?.captain ?? false ? "КАПИТАН" : "")")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .background(Color.yellow)
                    
                    
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

struct MyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileMainFooTeam(player: .constant(Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 60, position: "ФРВ", numberOfGames: 30, numberOfGoals: 60, winGame: 20, losGame: 10, captain: true)), showModal: .constant(false))
    }
}
