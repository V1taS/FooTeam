//
//  BGcompositionsMyTeamMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BGcompositionsMyTeamMainFooTeam: View {
    
    let backgroundColor: UIColor
    
    var body: some View {
        
        ZStack {
            BackgroundFooTeam(firstColor: Color(backgroundColor), centerColor: Color(backgroundColor), lastColor: Color(backgroundColor))
                .frame(width: 250, height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            ZStack {
                Color(backgroundColor).opacity(0.9)
                    .frame(width: 250, height: 2)
                } .offset(x: 0, y: -135)
            
            ZStack {
            Color(backgroundColor).opacity(0.9)
                .frame(width: 250, height: 2)
            } .offset(x: 0, y: -75)
        }
    }
    
}


struct BGcompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        BGcompositionsMyTeamMainFooTeam(backgroundColor: #colorLiteral(red: 0.3060370684, green: 0.3729676306, blue: 0.2559336424, alpha: 1))
    }
}
