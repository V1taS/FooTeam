//
//  ListPlayersProfileShow.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ListPlayersProfileShow: View {
    
    var player: Player
    
    @State var isPresentedShowModal = false
    
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
                                  win: "\(player.winGame)",
                                  los: "\(player.losGame)")
            
            Form {
                HStack {
                    Text("Играю в команде:")
                    Spacer()
                    Text("выйти")
                        .foregroundColor(.red)
                    Text("\(player.nameTeam)")
                        .font(.headline)
                    
                }
                
                HStack {
                    Text("Личный баланс:")
                    Spacer()
                        .foregroundColor(Color.green)
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
                    Text("Иду на след. игру:")
                    Spacer()
                    Text("\(player.iGo ? "да" : "нет")")
                        .font(.headline)
                }
            }
        }
        .navigationBarTitle(Text("Персональная карточка"), displayMode: .inline)
        
        .navigationBarItems(trailing: Button(action: { isPresentedShowModal.toggle() }) {
            Image(systemName: "pencil")
                .renderingMode(.original)
                .font(.title)
        })
        .sheet(
            isPresented: $isPresentedShowModal,
            content: { ListPlayersProfileEditor(closeIsPresentedShowModal: $isPresentedShowModal) }
        )
    }
}

struct ListPlayersProfileShow_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersProfileShow(player: Player(name: "Default player", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false))
    }
}
