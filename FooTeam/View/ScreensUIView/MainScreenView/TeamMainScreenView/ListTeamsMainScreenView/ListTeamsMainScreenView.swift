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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Выбери команду")) {
                    
                    HStack {
                        Picker("", selection: $viewModel.selectionTeams) {
                            ForEach(0..<viewModel.countTeams, id: \.self) { index in
                                Text("Команда - \(index + 1)")
                            }
                        } .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    CellCardsWithPlayersMainScreenView(selectTeams: $viewModel.selectionTeams)
                    HStack {
                        Spacer()
                        Button(action: {
                            if viewModel.iGoCount >= 10 {
                                let countT = NumberOfTeams.shared.numberOfTeams(countPlauers: viewModel.iGoCount)
                                viewModel.countTeams = countT
                                InWhichTeam.shared.setNumberInWhichTeam(players: viewModel.iGoPlayers, countNumbers: viewModel.countTeams)
                            }
                        } ) {
                            Text("Создать составы")
                                .font(.system(.headline, design: .serif))
                                .foregroundColor(Color.black)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.green)
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                }
                Section(header: Text("Информация")) {
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
                        Text("\(viewModel.datePlay) в 21:30")
                            .font(.headline)
                    }
                    HStack {
                        Text("Погода на игру:")
                        Spacer()
                        Text("\(viewModel.temperatureString)°С")
                            .font(.headline)
                    }
                }
                
            }
            .navigationBarTitle("Составы на игру", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "multiply")
                    .renderingMode(.original)
                    .font(.title)
            })
        }
    }
}

struct _ompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListTeamsMainScreenView()
    }
}
