//
//  MainWaitingMainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct MainWaitingMainFooTeam: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Ожидают подтверждения")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            WaitingMainFooTeam()
            
            Spacer()
        }
    }
}

struct MainWaitingMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MainWaitingMainFooTeam()
    }
}
