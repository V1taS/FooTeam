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
                        Text(NSLocalizedString("MainScreenViewModelControlPanel", comment: "Control panel"))
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    HStack {
                        ProfileMainScreenView()
                        Spacer(minLength: 16)
                        InformationsMainScreenView()
                    } .padding(.horizontal)
                    
                    HStack {
                        Text(NSLocalizedString("MainScreenViewModelSquadForTheGame", comment: "Squad for the game"))
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    TeamMainScreenView()
                        .padding(.horizontal)
                    
                    HStack {
                        Text(NSLocalizedString("MainScreenViewModelTop", comment: "TOP Players"))
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    } .padding(.horizontal)
                    
                    TopPlayersScreenView()
                        
                    Spacer()
                }
                
                .navigationBarItems(trailing:
                                        OutButtonFooTeamMenu(isPresentedAlertSignOut: $viewModel.isPresentedAlertSignOut))
                
                .navigationBarTitle(NSLocalizedString("MainScreenViewModelHome", comment: "Home"), displayMode: .inline)
            }
            
        }
    }
}

struct MainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
