//
//  BackgroundFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BackgroundFooTeam: View {
    
    let centerColor: Color
    
    var body: some View {
        let colors = Gradient(
            colors: [Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)),
                     Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)),
                     Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))]
        )
        let gradient = LinearGradient(
            gradient: colors,
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
        return Rectangle()
            .fill(gradient)
    }
}

struct BackgroundFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundFooTeam(centerColor: Color(.blue))
    }
}
