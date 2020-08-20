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
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .clipShape(Circle())
            Text("Привет,")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            Text("player!.name")
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
