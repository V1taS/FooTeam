//
//  MainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct MainScreenView: View {
    
    @StateObject private var viewModel = MainScreenViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    HeaderMainScreenView()
                    HStack {
                        Text("Панель управления")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    HStack {
                        ProfileMainScreenView()
                        Spacer()
                        InformationsMainScreenView()
                    } . padding(.horizontal)
                    
                    HStack {
                        Text("Составы на игру")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    TeamMainScreenView()
                    
                    HStack {
                        Text("TOP - Игроки")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    TopPlayersScreenView()
                    Spacer()
                }
                
                .navigationBarItems(trailing:
                                        OutButtonFooTeamMenu(isPresentedAlertSignOut: $viewModel.isPresentedAlertSignOut))
                
                .navigationBarTitle("Главная", displayMode: .inline)
            }
        }
    }
}

struct MainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
