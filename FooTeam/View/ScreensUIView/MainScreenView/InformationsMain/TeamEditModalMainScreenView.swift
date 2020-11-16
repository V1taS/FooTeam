//
//  TeamEditModalMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 09.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct TeamEditModalMainScreenView: View {
    
    @StateObject private var viewModel = TeamEditModalMainScreenViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Group {
                        HStack {
                            Spacer()
                            ImagePlayer(
                                avatarStringURL: "\(viewModel.team.avatarStringURL)",
                                avatarSize: 200
                            )
                            Spacer()
                        } .onTapGesture { viewModel.isPresentedChangeAvatar.toggle() }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelTeamType",
                                                   comment: "The command type"))
                            Picker("", selection: $viewModel.selectionAvailabilityTeamType) {
                                ForEach(0..<viewModel.availabilityTeamType.count) {
                                    Text(self.viewModel.availabilityTeamType[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelFieldType",
                                                   comment: "Field type"))
                            Picker("", selection: $viewModel.selectionAvailabilityFieldType) {
                                ForEach(0..<viewModel.availabilityFieldType.count) {
                                    Text(self.viewModel.availabilityFieldType[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelTeamName",
                                                   comment: "Team"))
                            TextField("\(viewModel.team.teamName)",
                                      text: $viewModel.team.teamName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelCountry",
                                                   comment: "A country"))
                            TextField("\(viewModel.team.country)",
                                      text: $viewModel.team.country)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelCity",
                                                   comment: "City"))
                            TextField("\(viewModel.team.location)",
                                      text: $viewModel.team.location)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelHowManyGamesPerWeek",
                                                   comment: "How many games per week?"))
                            Picker("", selection: $viewModel.selectionGameInWeak) {
                                ForEach(0..<viewModel.gameInWeak.count) {
                                    Text(self.viewModel.gameInWeak[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        ForEach(0..<viewModel.selectionGameInWeak+1, id: \.self) { item in
                            VStack {
                                HStack {
                                    DatePicker("\(NSLocalizedString("TeamEditModalMainScreenViewModelGame", comment: "Game")) - \(item+1)",
                                    selection: $viewModel.calendarDetails[item],
                                    displayedComponents: [.hourAndMinute])
                                    
                                    Picker("", selection: $viewModel.selectionWeekday[item]) {
                                        ForEach(0..<viewModel.weekday[item].count) {
                                            Text(self.viewModel.weekday[item][$0])
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Group {
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelMaximumNumberOfPlayers",
                                                   comment: "Maximum number of players:"))
                            Stepper("\(viewModel.team.maxCountPlayersInTeam)",
                                    value: $viewModel.team.maxCountPlayersInTeam)
                        }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelHideFromGlobalSearch",
                                                   comment: "Hide from global search?"))
                            Toggle(isOn: $viewModel.team.isHidden) {
                                Text("\(viewModel.team.isHidden ? Text(NSLocalizedString("TeamEditModalMainScreenViewModelYes", comment: "yes")).foregroundColor(Color.red) : Text(NSLocalizedString("TeamEditModalMainScreenViewModelNo", comment: "no")).foregroundColor(Color.green))")
                                    .font(.headline)
                            }
                        }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelBudgetTeam",
                                                   comment: "The budget team"))
                            TextField("\(viewModel.team.totalMoney)",
                                      text: $viewModel.team.totalMoney)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                        HStack {
                            Text(NSLocalizedString("TeamEditModalMainScreenViewModelMonthlyPaymentFromPlayer",
                                                   comment: "Monthly payment from the player"))
                            TextField("\(viewModel.team.gameСosts)",
                                      text: $viewModel.team.gameСosts)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                for item in 0..<viewModel.selectionGameInWeak+1 {
                                    SaveTeamPlayTime.shared.saveDate(
                                        date: viewModel.calendarDetails[item],
                                        dayOfWeek: "\(viewModel.selectionWeekday[item])",
                                        idTeam: viewModel.team.id,
                                        gameNumber: item+1,
                                        gameInWeak: viewModel.selectionGameInWeak,
                                        getPlayTime: viewModel.getPlayTime
                                    )
                                }
                                
                                EditTeam.shared.editTeamInTeam(
                                    team: viewModel.team,
                                    teamName: viewModel.team.teamName,
                                    avatarImage: nil,
                                    location: viewModel.team.location,
                                    teamType: "\(viewModel.selectionAvailabilityTeamType)",
                                    maxCountPlayersInTeam: viewModel.team.maxCountPlayersInTeam,
                                    isHidden: viewModel.team.isHidden,
                                    currentCountPlayersInTeam: viewModel.players.count,
                                    fieldType: "\(self.viewModel.selectionAvailabilityFieldType)",
                                    country: viewModel.team.country,
                                    totalMoney: viewModel.team.totalMoney,
                                    gameСosts: viewModel.team.gameСosts,
                                    rating: viewModel.rating
                                )
                                
                                presentationMode.wrappedValue.dismiss()
                            } ) {
                                Text(NSLocalizedString("TeamEditModalMainScreenViewModelSave",
                                                       comment: "Save"))
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
                }
                
                .navigationBarTitle(Text(NSLocalizedString("TeamEditModalMainScreenViewModelEditingCommand",
                                                           comment: "Editing a command")), displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Image(systemName: "multiply")
                            .font(.title)
                            .foregroundColor(Color("BlackAndWhite"))
                    })
                
                if viewModel.isPresentedChangeAvatar {
                    ZStack {
                        Color.black.opacity(0.8)
                        ZStack {
                            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
                            EditPhotoViewTeam(team: viewModel.team,
                                              isPresentedChangeAvatar: $viewModel.isPresentedChangeAvatar,
                                              image: $viewModel.image)
                        }
                        .frame(width: 330, height: 330)
                        .cornerRadius(20)
                        .offset(x: 0, y: 220)
                    } .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}

struct TeamEditModalMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamEditModalMainScreenView()
    }
}
