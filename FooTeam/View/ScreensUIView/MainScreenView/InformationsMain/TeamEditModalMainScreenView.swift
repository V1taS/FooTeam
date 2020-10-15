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
                    HStack {
                        Spacer()
                        ImagePlayer(avatarStringURL: "\(viewModel.team.avatarStringURL)", avatarSize: 200)
                        Spacer()
                    } .onTapGesture { viewModel.isPresentedChangeAvatar.toggle() }
                    
                    HStack {
                        Text("Тип команды")
                        Picker("", selection: $viewModel.selectionAvailabilityTeamType) {
                            ForEach(0..<viewModel.availabilityTeamType.count) {
                                Text(self.viewModel.availabilityTeamType[$0])
                            }
                        } .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        Text("Команда:")
                        TextField("\(viewModel.team.teamName)",
                                  text: $viewModel.team.teamName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Text("Город:")
                        TextField("\(viewModel.team.location)",
                                  text: $viewModel.team.location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        DatePicker("Дата игр", selection: $viewModel.calendarDetails, displayedComponents: [.hourAndMinute, .date])
                    }

                    HStack {
                        Text("Удалить команду")
                        Toggle(isOn: $viewModel.deleteTeam) {
                            Text("\(viewModel.deleteTeam ? "да" : "нет")")
                                .font(.headline)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        } ) {
                            Text("Сохранить")
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
            
            .navigationBarTitle(Text("Редактирование команды"), displayMode: .inline)
            
            .navigationBarItems(
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "multiply")
                        .renderingMode(.original)
                        .font(.title)
                })
            
            if viewModel.isPresentedChangeAvatar {
                ZStack {
                    Color.black.opacity(0.8)
                    ZStack {
                        Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
                        EditPhotoView(player: viewModel.players.first!, isPresentedChangeAvatar: $viewModel.isPresentedChangeAvatar, image: $viewModel.image)
                    }
                    .frame(width: 330, height: 330)
                    .cornerRadius(20)
                    .offset(x: 0, y: 220)
                } .edgesIgnoringSafeArea(.all)
                
            }
        }
    }
}

struct TeamEditModalMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamEditModalMainScreenView()
    }
}
