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
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    ImagePlayer(avatarStringURL: "\(viewModel.team.avatarStringURL)", avatarSize: 200)
                    Spacer()
                }
                
                HStack {
                    Text("Тип команды")
                    Spacer()
                    Text("\(viewModel.team.teamType)")
                        .font(.headline)
                }
                
                HStack {
                    Text("Команда")
                    Spacer()
                    Text("\(viewModel.team.teamName)")
                        .font(.headline)
                }
                
                HStack {
                    Text("Город")
                    Spacer()
                    Text("\(viewModel.team.location)")
                        .font(.headline)
                }
                
                VStack {
                    ForEach(viewModel.getPlayTime, id: \.self) { time in
                        
                        HStack {
                            Text("Игра в")
                            Spacer()
                            Text("\(GetDayOfWeekFromNumber.shared.GetDayOfWeek(numberString: time.dayOfWeek))")
                                .font(.headline)
                            Text("\(GetDateStringFromDate.shared.GetDateString(date: time.date))")
                                .font(.headline)
                        }
                    }
                }
                
                HStack {
                    Text("Максимальное кол-во игроков")
                    Spacer()
                    Text("25")
                        .font(.headline)
                }
                
                HStack {
                    Text("Рейтинг команды")
                    Spacer()
                    Text("\(viewModel.rating)")
                        .font(.headline)
                }
            }
            
            .navigationBarTitle(Text("Карточка команды"), displayMode: .inline)
            
            .navigationBarItems(
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
        TeamShowModalMainScreenView()
    }
}
