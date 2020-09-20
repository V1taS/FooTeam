//
//  ListTeamsMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ListTeamsMainScreenView: View {
    
    @StateObject private var viewModel = ListTeamsMainScreenViewModel()
    @Binding var closeIsPresentedShowModal: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                
                CardsWithPlayersMainScreenView()
                    .padding(.top)
                
                Form {
                    
                    HStack {
                        Text("Кол-во игроков:")
                        Spacer()
                        Text("\(viewModel.iGoCount)")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Кол-во команд:")
                        Spacer()
                        Text("\(viewModel.countTeams)")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Игра состоится:")
                        Spacer()
                        Text("через \(viewModel.datePlay) в 21:30")
                            .font(.headline)
                    }
                    HStack {
                        Text("Погода на игру:")
                        Spacer()
                        Text("\(viewModel.temperatureString)°С")
                            .font(.headline)
                    }
                }
                
                Spacer()
                    .navigationBarTitle("Составы на игру", displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        self.closeIsPresentedShowModal = false
                    }) {
                        Image(systemName: "multiply")
                            .renderingMode(.original)
                            .font(.title)
                    })
                
            }
        }
    }
}

struct _ompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListTeamsMainScreenView(closeIsPresentedShowModal: .constant(false))
    }
}