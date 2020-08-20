//
//  ButtonFooTeamMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ButtonFooTeamMenu: View {
    
    @Binding var index: Int
    @Binding var show: Bool
    
    let indexButton: Int
    let imageButton: String
    let textButton: String
    
    var body: some View {
        VStack {
            Button(action: {
                self.index = self.indexButton
                withAnimation{
                    self.show.toggle()
                }
            }) {
                HStack(spacing: 25){
                    Image(imageButton)
                        .foregroundColor(self.index == indexButton ? Color("Color1") : Color.white)
                    
                    Text(textButton)
                        .foregroundColor(self.index == indexButton ? Color("Color1") : Color.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(self.index == indexButton ? Color("Color1").opacity(0.2) : Color.clear)
                .cornerRadius(10)
            }
            .padding(.top,5)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ButtonFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFooTeamMenu(index: .constant(0), show: .constant(false), indexButton: 0, imageButton: "catalogue", textButton: "Главная")
    }
}
