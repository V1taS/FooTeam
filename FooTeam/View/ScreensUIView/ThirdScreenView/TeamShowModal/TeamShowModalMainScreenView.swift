//
//  TeamShowModalMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct TeamShowModalMainScreenView: View {
    
    @StateObject private var viewModel = TeamShowModalMainScreenViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var showAcceptPlayers: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Group {
                    HStack {
                        Spacer()
                        ImagePlayer(avatarStringURL: "\(viewModel.team.avatarStringURL)", avatarSize: 200)
                        Spacer()
                    }
                    
                    HStack {
                        Text(NSLocalizedString("TeamShowModalMainScreenViewTeamType", comment: "The command type"))
                            .foregroundColor(Color("BlackAndWhite"))
                        Spacer()
                        Text("\(TeamTypeFromIntToString.shared.setTeamType(from: viewModel.team.teamType))")
                            .foregroundColor(viewModel.team.teamType == "1" ? .red : .green)
                            .font(.headline)
                    }
                    
                    HStack {
                        Text(NSLocalizedString("TeamShowModalMainScreenViewFieldType", comment: "Field type"))
                            .foregroundColor(Color("BlackAndWhite"))
                        Spacer()
                        Text("\(FieldTypeFromIntToString.shared.setFieldType(from: viewModel.team.fieldType))")
                            .font(.headline)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                    
                    HStack {
                        Text(NSLocalizedString("TeamShowModalMainScreenViewTeam", comment: "Team"))
                            .foregroundColor(Color("BlackAndWhite"))
                        Spacer()
                        Text("\(viewModel.team.teamName)")
                            .font(.headline)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                }
                
                HStack {
                    Text(NSLocalizedString("TeamShowModalMainScreenViewCountry", comment: "A country"))
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.team.country)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text(NSLocalizedString("TeamShowModalMainScreenViewCity", comment: "City"))
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.team.location)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text(NSLocalizedString("TeamShowModalMainScreenViewBudgetTeam", comment: "The budget team"))
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.team.totalMoney)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                    Text("FCoin")
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text(NSLocalizedString("TeamShowModalMainScreenViewMonthlyPaymentPlayer", comment: "Monthly payment from the player"))
                    Spacer()
                    Text("\(viewModel.team.gameСosts)")
                        .font(.headline)
                    Text("FCoin")
                        .foregroundColor(Color("BlackAndWhite"))
                }

                HStack {
                    Text(NSLocalizedString("TeamShowModalMainScreenViewRating", comment: "Team rating"))
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.rating)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text(NSLocalizedString("TeamShowModalMainScreenViewPlayersInTeam", comment: "Players in the team"))
                    Spacer()
                    Text("\(viewModel.players.count)")
                        .foregroundColor(viewModel.players.count < viewModel.team.maxCountPlayersInTeam ? Color("BlackAndWhite") : .red)
                        .font(.headline)
                    Text("из")
                        .font(.headline)
                    Text("\(viewModel.team.maxCountPlayersInTeam)")
                        .foregroundColor(viewModel.players.count >= viewModel.team.maxCountPlayersInTeam ? .red : Color("BlackAndWhite"))
                        .font(.headline)
                }
                
                VStack {
                    ForEach(viewModel.getPlayTime, id: \.self) { time in
                        HStack {
                            Text(NSLocalizedString("TeamShowModalMainScreenViewGame", comment: "Game"))
                            Spacer()
                            Text("\(GetDayOfWeekFromNumber.shared.GetDayOfWeek(numberString: time.dayOfWeek))")
                                .font(.headline)
                                .foregroundColor(Color("BlackAndWhite"))
                            Text("\(GetDateStringFromDate.shared.GetDateString(date: time.date))")
                                .font(.headline)
                                .foregroundColor(Color("BlackAndWhite"))
                        }
                    }
                }
            }
            
            .navigationBarTitle(Text(NSLocalizedString("TeamShowModalMainScreenViewTeamCard", comment: "Team card")), displayMode: .inline)
            
            .navigationBarItems(
                leading:
                    HStack {
                        if FirestoreService.shared.currentUser.captain {
                            Button(action: { showAcceptPlayers.toggle() }) {
                                Image(systemName: "mail")
                                    .minimumScaleFactor(0.7)
                                    .font(.title)
                                    .foregroundColor(viewModel.playersWaitingAccept.isEmpty ? .gray : .green)
                            }
                        }
                    }
                ,
                trailing: VStack {
                    if FirestoreService.shared.currentUser.captain {
                        Button(action: {
                            self.viewModel.isPresentedEditTeam.toggle()
                            
                        }) {
                            Image(systemName: "pencil")
                                .font(.title)
                                .foregroundColor(Color("BlackAndWhite"))
                        }
                        .sheet(
                            isPresented: $viewModel.isPresentedEditTeam,
                            content: { TeamEditModalMainScreenView() }
                        )
                    }
                })
        }
    }
}

struct TeamShowModalMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamShowModalMainScreenView(showAcceptPlayers: .constant(false))
    }
}
