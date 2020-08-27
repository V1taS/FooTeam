//
//  MainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct MainFooTeam: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        ZStack {
                        Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                            .frame(height: 30)
                            
                            HStack {
                                Text("Баланс:")
                                .padding(.leading)
                                Spacer()
                                Text("100 000 руб")
                                    .padding(.trailing)
                            }
                        }
                    }
                    
                    HStack {
                        
                        ZStack {
                            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                                .frame(width: 180, height: 230)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack {
                                Text("ПРОФИЛЬ")
                                    .font(.headline)
                                    .foregroundColor(Color(.red))
                                Text("Сосин Виталий")
                                    .font(.subheadline)
                                
                                Image("Сосин Виталий")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 125, height: 125)
                                    .cornerRadius(20)
                            }
                        }
                        
                        Spacer()
                        
                        
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
                                            Text("Клуб: ФК Химки")
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
                        
                        
                    } . padding(.horizontal)
                    
                    
                    
                    ZStack {
                        Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                            .frame(width: 380, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        HStack {
                            Image("teamCount")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                            
                            Spacer()
                            
                            VStack {
                                Text("Моя команда")
                                    .font(.title)
                                    .foregroundColor(Color(.red))
                                
                                Text("Всего игроков: 32")
                                Text("Придут на игру: 15")
                            }
                        }.padding(.horizontal, 36)
                    }
                    
                    
                    
                    
                    Spacer()
                }
                    
                    
                    
                .navigationBarTitle("Главная", displayMode: .inline)
                    
                .navigationBarItems(leading: Button(action: { print("")} ) {
                    Image(systemName: "2.circle")
            })
            }
        }
    }
}

struct MainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MainFooTeam()
    }
}
