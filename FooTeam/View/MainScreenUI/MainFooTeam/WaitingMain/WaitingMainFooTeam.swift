//
//  WaitingMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct WaitingMainFooTeam: View {
    
    @ObservedObject var waitingPlayers = WaitingPlayers()
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(waitingPlayers.players, id: \.self) { player in
                        
                        PlayerWaitingMainFooTeam(player: player)
                            .padding(.leading)
                    }
                    
                    } .frame(height: 170)
                
        }
    }
}

struct WaitingMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        WaitingMainFooTeam()
    }
}
