//
//  BoxPositionsMyTeamMFT.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxCardsWithPlayersMainScreenView: View {
    
    var teamnumber: Int
    var ratingTeam: Int
    let backgroundColor: UIColor
    
    var body: some View {
        ZStack {
            CellCardsWithPlayersMainScreenView(backgroundColor: backgroundColor)
            VStack {
                Text("КОМАНДА - \(teamnumber)")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.white)
                } .offset(x: 0, y: -107)
            
            VStack {
            Text("РЕЙТИНГ - \(ratingTeam)")
                .fontWeight(.bold)
                .font(.headline)
                .foregroundColor(.white)
            } .offset(x: 0, y: -64)
            
            
        } .padding(.leading)
    }
}

struct CellCardsWithPlayersMainScreenView: View {
    
    let backgroundColor: UIColor
    
    var body: some View {
        
        ZStack {
            BackgroundFooTeam(firstColor: Color(backgroundColor), centerColor: Color(backgroundColor), lastColor: Color(backgroundColor))
                .frame(width: 200, height: 270)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            ZStack {
                Color(backgroundColor).opacity(0.9)
                    .frame(width: 200, height: 2)
                } .offset(x: 0, y: -85)
            
            ZStack {
            Color(backgroundColor).opacity(0.9)
                .frame(width: 200, height: 2)
            } .offset(x: 0, y: -45)
        }
    }
    
}

struct BoxPositionsMyTeamMFT_Previews: PreviewProvider {
    static var previews: some View {
        BoxCardsWithPlayersMainScreenView(teamnumber: 2, ratingTeam: 89, backgroundColor: #colorLiteral(red: 0.3060370684, green: 0.3729676306, blue: 0.2559336424, alpha: 1))
    }
}
