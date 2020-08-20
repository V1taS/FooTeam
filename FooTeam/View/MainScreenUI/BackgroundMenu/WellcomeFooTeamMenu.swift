//
//  BackgroundMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct WellcomeFooTeamMenu: View {
    var body: some View {
        VStack {
            Image("alexAva")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
                .clipShape(Circle())
            .overlay(Circle().stroke(Color.green, lineWidth: 2))
            Text("Привет,")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("Сосин Виталий")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct BackgroundMenu_Previews: PreviewProvider {
    static var previews: some View {
        WellcomeFooTeamMenu()
    }
}
