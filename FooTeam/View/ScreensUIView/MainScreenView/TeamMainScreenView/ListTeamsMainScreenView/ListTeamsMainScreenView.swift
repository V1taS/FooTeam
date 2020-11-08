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
                        if viewModel.iGoCount < 10 {
                            HStack() {
                                Spacer()
                                Text("Количество игроков не хватает для распределения на команды")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        } else {
                            Picker("", selection: $viewModel.selectionTeams) {
                                ForEach(0..<viewModel.countTeams, id: \.self) { index in
                                    Text("Команда - \(index + 1)")
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    
                    CellCardsWithPlayersMainScreenView(selectTeams: $viewModel.selectionTeams)
                        .frame(maxHeight: 330)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            if viewModel.iGoCount >= 10 {
                                if viewModel.team.fieldType == "Мини" {
                                    let countT = NumberOfTeamsMini.shared.numberOfTeams(countPlauers: viewModel.iGoCount)
                                    viewModel.countTeams = countT
                                } else {
                                    let countT = NumberOfTeamsFullField.shared.numberOfTeams(countPlauers: viewModel.iGoCount)
                                    viewModel.countTeams = countT
                                }
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
                        Text("Тип футбольного поля:")
                        Spacer()
                        
                        Text("\(FieldTypeFromIntToString.shared.setFieldType(from: viewModel.team.fieldType))")
                            .font(.headline)
                    }
                    
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
                }
                
            }
            .navigationBarTitle("Составы на игру", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "multiply")
                    .font(.title)
                    .foregroundColor(Color("BlackAndWhite"))
            })
        }
    }
}

struct _ompositionsMyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListTeamsMainScreenView()
    }
}
