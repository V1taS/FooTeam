//
//  PositionsMyTeamMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct PositionsMyTeamMainFooTeam: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Количество команд на игру: 3")
                        .font(.title)
                        .padding(.top)
                    ListCompositionsMyTeamMainFooTeam()
                    
                }
                VStack {
                    Text("Игра состоится: в среду в 21:30")
                        .font(.title)
                    Text("Погода на игру: 23С")
                        .font(.title)
                }
                Spacer()
                    .navigationBarTitle("Составы на игру", displayMode: .inline)
                
            }
        }
    }
}

struct _ompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        PositionsMyTeamMainFooTeam()
    }
}
