//
//  ImageWellcomeFooTeamMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageWellcomeFooTeamMenu: View {
    
    @Binding var player: Players?
    
    var body: some View {
        WebImage(url: URL(string: player!.avatarStringURL))
        .onSuccess { image, data, cacheType in
            // Success
            // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
        }
        .resizable()
        .placeholder(Image(systemName: "photo")) // Placeholder Image
        .placeholder {
            Circle().foregroundColor(Color("Color"))
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.5)) // Fade Transition with duration
        .scaledToFill()
        .frame(width: 160, height: 160, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.green, lineWidth: 2))
    }
}

struct ImageWellcomeFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        ImageWellcomeFooTeamMenu(player: .constant(Players(name: "Виталий Сосин", email: "375693@mail.ru", avatarStringURL: "", whoAreYou: "Игрок", id: "12345", teamNumber: 0, payment: "500", iGo: true, subscription: true, rating: 0, position: "ФРВ", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: true)))
            .background(Color("Color").edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
    }
}
