//
//  BoxButtonFooTeamMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxButtonFooTeamMenu: View {
    
    @Binding var index: Int
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            ButtonFooTeamMenu(index: $index, show: $show, indexButton: 0, imageButton: "catalogue", textButton: "Главная")
            ButtonFooTeamMenu(index: $index, show: $show, indexButton: 1, imageButton: "cart", textButton: "Чат с командой")
            ButtonFooTeamMenu(index: $index, show: $show, indexButton: 2, imageButton: "fav", textButton: "Контакты")
            ButtonFooTeamMenu(index: $index, show: $show, indexButton: 3, imageButton: "orders", textButton: "О нас")
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct BoxButtonFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        BoxButtonFooTeamMenu(index: .constant(1), show: .constant(false))
    }
}
