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
                
                HStack {
                    Text("Дни игр:")
                    Spacer()
                    Text("Пн, Ср")
                        .font(.headline)
                }
                
                HStack {
                    Text("Время игр:")
                    Spacer()
                    Text("21:00")
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
                leading: Button(action: {
                    self.viewModel.isPresentedEditTeam.toggle()
                    
                }) {
                    Image(systemName: "pencil")
                        .renderingMode(.original)
                        .font(.title)
                }
                .sheet(
                    isPresented: $viewModel.isPresentedEditTeam,
                    content: { TeamEditModalMainScreenView() }
                ),
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "multiply")
                        .renderingMode(.original)
                        .font(.title)
                })
        }
    }
}

struct TeamShowModalMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamShowModalMainScreenView()
    }
}
