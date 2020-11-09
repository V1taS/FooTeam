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
                Section(header: Text(NSLocalizedString("ListTeamsMainScreenViewChooseTeam", comment: "Choose a team"))) {
                    
                    HStack {
                        if viewModel.iGoCount < 10 {
                            HStack() {
                                Spacer()
                                Text(NSLocalizedString("ListTeamsMainScreenViewNotEnoughPlayers", comment: "The number of players is not enough for distribution into teams"))
                                    .font(.headline)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        } else {
                            Picker("", selection: $viewModel.selectionTeams) {
                                ForEach(0..<viewModel.countTeams, id: \.self) { index in
                                    Text("\(NSLocalizedString("ListTeamsMainScreenViewTeam", comment: "Team")) - \(index + 1)")
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
                                if viewModel.team.fieldType == "0" {
                                    let countT = NumberOfTeamsMini.shared.numberOfTeams(countPlauers: viewModel.iGoCount)
                                    viewModel.countTeams = countT
                                } else {
                                    let countT = NumberOfTeamsFullField.shared.numberOfTeams(countPlauers: viewModel.iGoCount)
                                    viewModel.countTeams = countT
                                }
                                InWhichTeam.shared.setNumberInWhichTeam(players: viewModel.iGoPlayers, countNumbers: viewModel.countTeams)
                            }
                        } ) {
                            Text(NSLocalizedString("ListTeamsMainScreenViewCreateTeam", comment: "To create the compositions"))
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
                Section(header: Text(NSLocalizedString("ListTeamsMainScreenViewInfo", comment: "Information"))) {
                    HStack {
                        Text(NSLocalizedString("ListTeamsMainScreenViewFieldType", comment: "Type of football field"))
                        Spacer()
                        
                        Text("\(FieldTypeFromIntToString.shared.setFieldType(from: viewModel.team.fieldType))")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text(NSLocalizedString("ListTeamsMainScreenViewNumberPlayers", comment: "Number of players"))
                        Spacer()
                        Text("\(viewModel.iGoCount)")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text(NSLocalizedString("ListTeamsMainScreenViewNumberTeams", comment: "Number of teams"))
                        Spacer()
                        Text("\(viewModel.countTeams)")
                            .font(.headline)
                    }
                }
                
            }
            .navigationBarTitle(NSLocalizedString("ListTeamsMainScreenViewTeamToPlay", comment: "Lineups for the game"), displayMode: .automatic)
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
