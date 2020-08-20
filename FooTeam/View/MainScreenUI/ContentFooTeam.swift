//
//  ContentFooTeamMenu.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import FirebaseAuth
import SwiftUI

struct ContentFooTeam: View {
    
    @State var index = 0
    @State var show = false
    @State var isPresentedAlertSignOut = false
    
    @State var player = FirestoreService.shared.currentUser
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 12) {
                    WellcomeFooTeamMenu()
                    BoxButtonFooTeamMenu(index: $index, show: $show)
                    DividerFooTeamMenu()
                    OutButtonFooTeamMenu(isPresentedAlertSignOut: $isPresentedAlertSignOut)
                }
                .padding(.top,25)
                .padding(.horizontal,20)
                
                Spacer(minLength: 0)
            }
             
            MainContentFooTeam(index: $index, show: $show)
            
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentFooTeamMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentFooTeam()
    }
}
