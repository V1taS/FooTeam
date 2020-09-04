//
//  BoxPositionsMyTeamMFT.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxPositionsMyTeamMFT: View {
    
    var teamnumber: Int
    var ratingTeam: Int
    let backgroundColor: UIColor
    
    var body: some View {
        ZStack {
            BGcompositionsMyTeamMainFooTeam(backgroundColor: backgroundColor)
            VStack {
                Text("Команда - \(teamnumber)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                } .offset(x: 0, y: -165)
            
            VStack {
            Text("Рейтинг - \(ratingTeam)")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
            } .offset(x: 0, y: -105)
            
            
        } .padding(.leading)
    }
}

struct BoxPositionsMyTeamMFT_Previews: PreviewProvider {
    static var previews: some View {
        BoxPositionsMyTeamMFT(teamnumber: 2, ratingTeam: 89, backgroundColor: #colorLiteral(red: 0.3060370684, green: 0.3729676306, blue: 0.2559336424, alpha: 1))
    }
}
