//
//  MainFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct MainFooTeam: View {
    
    @State var isPresentedAlertSignOut = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    HeaderMainFooTeam()
                    
                    HStack {
                        Text("Панель управления")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    HStack {
                        ProfileMainFooTeam()
                        Spacer()
                        InformationMainFooTeam()
                    } . padding(.horizontal)
                    
                    HStack {
                        Text("Составы на игру")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    MyTeamMainFooTeam()
                    
                    HStack {
                        Text("TOP - Игроки")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    BoxTopPlayersFooTeam()
                    Spacer()
                }
                    
                .navigationBarItems(trailing:
                    OutButtonFooTeamMenu(isPresentedAlertSignOut: $isPresentedAlertSignOut))
                    
                    .navigationBarTitle("Главная", displayMode: .inline)
            }
        }
    }
}

struct MainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MainFooTeam()
    }
}
