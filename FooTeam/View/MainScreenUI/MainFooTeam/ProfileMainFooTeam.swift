//
//  ProfileMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileMainFooTeam: View {
    
    @Binding var player: Players?
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .frame(width: 180, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                Text("ПРОФИЛЬ")
                    .font(.headline)
                    .foregroundColor(Color(.red))
                Text(player?.name ?? "Игрок")
                    .font(.subheadline)
                
                WebImage(url: URL(string: player?.avatarStringURL ?? ""))
                    .onSuccess { image, data, cacheType in }
                    .resizable()
                    .placeholder(Image("player"))
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: 125, height: 125, alignment: .center)
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}


struct ProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainFooTeam(player: .constant(Players(name: "Sosin Vitalii", nameTeam: "ФК Химки", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
    }
}
