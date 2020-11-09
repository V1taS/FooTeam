//
//  OutButtonFooTeamMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct OutButtonFooTeamMenu: View {
    
    @Binding var isPresentedAlertSignOut: Bool
    
    var body: some View {
        Button(action: {
            self.isPresentedAlertSignOut.toggle()
        }) {
            HStack(spacing: 25){
                Image(systemName: "greetingcard")
                    .foregroundColor(Color("BlackAndWhite"))
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .alert(isPresented: self.$isPresentedAlertSignOut) {
            Alert(title: Text(NSLocalizedString("OutButtonFooTeamMenuAttention", comment: "Attention")),
                  message: Text(NSLocalizedString("OutButtonFooTeamMenuExitApp", comment: "Do you want to exit the app?")),
                  primaryButton: Alert.Button.default(Text(NSLocalizedString("OutButtonFooTeamMenuCancel", comment: "Cancel"))),
                  secondaryButton: Alert.Button.destructive(
                    Text(NSLocalizedString("OutButtonFooTeamMenuGoOut", comment: "Go out")), action: {
                        do {
                            try Auth.auth().signOut()
                            
                            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                            window?.rootViewController = AuthViewController()
                            
                        } catch {
                            print("Error signing out: \(error.localizedDescription)")
                        }
                  }
                )
            )
        }
    }
}

struct OutButtonFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        OutButtonFooTeamMenu(isPresentedAlertSignOut: .constant(false))
            .background(Color(.white).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}
