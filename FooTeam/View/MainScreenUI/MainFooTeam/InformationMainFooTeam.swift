//
//  InformationMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct InformationMainFooTeam: View {
    
    @Binding var player: Players?
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .frame(width: 180, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack {
                Text("ИНФОРМАЦИЯ")
                    .font(.headline)
                    .foregroundColor(Color(.red))
                
                ZStack {
                    Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
                        .frame(width: 180, height: 50)
                    
                    HStack {
                        
                        Color(.black)
                            .frame(width: 1, height: 30)
                        
                        VStack {
                            Text("Клуб: \(player?.nameTeam ?? "нет")")
                                .font(.subheadline)
                            
                            Text("Иду на игру: 🟢")
                                .font(.subheadline)
                        }
                        
                        Color(.black)
                            .frame(width: 1, height: 30)
                    }
                }
                
        
                ZStack {
                    Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
                        .frame(width: 180, height: 80)
                    
                    HStack {
                        
                        Color(.black)
                            .frame(width: 1, height: 60)
                        
                        VStack {
                            Text("Игра через 1 день")
                                .font(.subheadline)
                            
                            Text("Погода: хорошая")
                                .font(.subheadline)
                            
                            Text("Температура: 15С")
                                .font(.subheadline)
                        }
                        
                        Color(.black)
                            .frame(width: 1, height: 60)
                    }
                }
                
                
            }
        }
    }
}

struct InformationMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        InformationMainFooTeam(player: .constant(Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
    }
}
