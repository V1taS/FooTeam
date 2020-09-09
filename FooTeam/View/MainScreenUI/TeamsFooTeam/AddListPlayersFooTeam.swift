//
//  AddListPlayersFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct AddListPlayersFooTeam: View {
    
    @Binding var showModal: Bool
    
    var player = Players(name: "Виталий", nameTeam: "Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "500", iGo: false, subscription: false, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)
    
    @State var name = ""
    @State var email = ""
    @State var selectionWhoAreYou = 0
    let whoAreYou = ["Игрок", "Зритель"]
    @State var payment = "0"
    let positions = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    @State var selectionPositions = 0
        
        var body: some View {
            NavigationView {
                VStack {
                    VStack {
                        WebImage(url: URL(string: player.avatarStringURL))
                        .onSuccess { image, data, cacheType in }
                        .resizable()
                        .placeholder(Image("player"))
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 125, height: 125, alignment: .center)
                        .cornerRadius(20)
                        .aspectRatio(contentMode: .fill)
     
                        Text("Загрузить")
                        .padding(.horizontal)
                        .background(Color.green)
                    } .padding(.top)
                    
                    Form {
                        
                        
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
                            TextField("Иванов Иван", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Электронная почта:")
                            TextField("e-mail", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        if selectionWhoAreYou == 0 {
                            HStack {
                                Text("Баланс:")
                                TextField("Баланс", text: $payment)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            }.disabled(true)
                  
                        
                            HStack {
                                Text("Позиция:")
                                Picker("dvdvd", selection: $selectionPositions) {
                                    ForEach(0..<positions.count) {
                                        Text(self.positions[$0])
                                    }
                                } .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            HStack {
                                Text("Играет в команде:")
                                Spacer()
                                Text("\(player.nameTeam)")
                                    .font(.headline)
                            }
                        }
                        
                        
                        
                        HStack {
                            Spacer()
                            Text("Сохранить")
                                .padding(.horizontal)
                                .background(Color.green)
                                
                            Spacer()
                        }
                    }
                }
                    
                .navigationBarTitle(Text("Добавить игрока"), displayMode: .automatic)
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


struct AddListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        AddListPlayersFooTeam(showModal: .constant(false))
    }
}
