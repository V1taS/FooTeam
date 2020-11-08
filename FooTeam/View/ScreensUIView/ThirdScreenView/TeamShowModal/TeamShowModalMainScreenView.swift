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
                        Text("Тип команды")
                            .foregroundColor(Color("BlackAndWhite"))
                        Spacer()
                        Text("\(viewModel.teamType)")
                            .foregroundColor(viewModel.teamType == "Закрытая" ? .red : .green)
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Тип поля")
                            .foregroundColor(Color("BlackAndWhite"))
                        Spacer()
                        Text("\(FieldTypeFromIntToString.shared.setFieldType(from: viewModel.team.fieldType))")
                            .font(.headline)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                    
                    HStack {
                        Text("Команда")
                            .foregroundColor(Color("BlackAndWhite"))
                        Spacer()
                        Text("\(viewModel.team.teamName)")
                            .font(.headline)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                }
                
                HStack {
                    Text("Страна")
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.team.country)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text("Город")
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.team.location)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text("Бюджет команды")
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.team.totalMoney)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                    Text("FCoin")
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text("Месячная оплата с игрока")
                    Spacer()
                    Text("\(viewModel.team.gameСosts)")
                        .font(.headline)
                    Text("FCoin")
                        .foregroundColor(Color("BlackAndWhite"))
                }

                HStack {
                    Text("Рейтинг команды")
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.rating)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                }
                
                HStack {
                    Text("Игроков в команде")
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
                            Text("Игра")
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
            
            .navigationBarTitle(Text("Карточка команды"), displayMode: .inline)
            
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
