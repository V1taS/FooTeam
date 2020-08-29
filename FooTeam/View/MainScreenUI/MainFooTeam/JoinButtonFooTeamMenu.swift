//
//  JoinButtonFooTeamMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct JoinButtonFooTeamMenu: View {
    
    @Binding var isPresentedAlertSignOut: Bool
    
    var body: some View {
        Button(action: {
            self.isPresentedAlertSignOut.toggle()
        }) {
            HStack(spacing: 25){
                Image(systemName: "timer")
                    .foregroundColor(Color.black)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .alert(isPresented: self.$isPresentedAlertSignOut) {
            Alert(title: Text("Внимание"),
                  message: Text("Вы хотите выбрать новую команду?"),
                  primaryButton: Alert.Button.default(Text("Отмена")),
                  secondaryButton: Alert.Button.destructive(
                    Text("Выбрать"), action: {
                        
                        let mainContentFooTeam = UIHostingController(rootView: BoxJoinTeamViewController())
                        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                        window?.rootViewController = mainContentFooTeam
                  }
                )
            )
        }
    }
}

struct JoinButtonFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        JoinButtonFooTeamMenu(isPresentedAlertSignOut: .constant(false))
    }
}
