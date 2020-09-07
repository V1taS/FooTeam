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
                Text("КОМАНДА - \(teamnumber)")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.white)
                } .offset(x: 0, y: -99)
            
            VStack {
            Text("РЕЙТИНГ - \(ratingTeam)")
                .fontWeight(.bold)
                .font(.headline)
                .foregroundColor(.white)
            } .offset(x: 0, y: -59)
            
            
        } .padding(.leading)
    }
}

struct BoxPositionsMyTeamMFT_Previews: PreviewProvider {
    static var previews: some View {
        BoxPositionsMyTeamMFT(teamnumber: 2, ratingTeam: 89, backgroundColor: #colorLiteral(red: 0.3060370684, green: 0.3729676306, blue: 0.2559336424, alpha: 1))
    }
}
