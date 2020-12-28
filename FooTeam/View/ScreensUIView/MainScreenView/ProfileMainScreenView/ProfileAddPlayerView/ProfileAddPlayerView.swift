//
//  AddListPlayersFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ProfileAddPlayerView: View {
    
    @ObservedObject private var viewModel = ProfileAddPlayerViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    VStack {
                        ImagePlayer(avatarStringURL: "",
                                    avatarSize: 125)
                    } .padding(.vertical)
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Text(NSLocalizedString("ProfileAddPlayerViewWhoAreYou",
                                               comment: "Who are you?"))
                        Picker("", selection: $viewModel.selectionWhoAreYou) {
                            ForEach(0..<viewModel.whoAreYou.count) {
                                Text(viewModel.whoAreYou[$0])
                            }
                        } .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        Text(NSLocalizedString("ProfileAddPlayerViewName",
                                               comment: "Name"))
                        TextField("Ivanov Ivan", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Text(NSLocalizedString("ProfileAddPlayerViewMail",
                                               comment: "Email"))
                        TextField("e-mail", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    if viewModel.selectionWhoAreYou == 0 {
                        HStack {
                            Text(NSLocalizedString("ProfileAddPlayerViewBalance",
                                                   comment: "Balance"))
                            TextField("", text: $viewModel.payment)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("ProfileAddPlayerViewPosition",
                                                   comment: "Position"))
                            Picker("", selection: $viewModel.selectionPositions) {
                                ForEach(0..<viewModel.positions.count) {
                                    Text(viewModel.positions[$0])
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            Text(NSLocalizedString("ProfileAddPlayerViewPlaysInTeam",
                                                   comment: "Plays in a team"))
                            Spacer()
                            Text("\(viewModel.team.teamName)")
                                .font(.headline)
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        AddPlayer.shared.addPlayerWith(
                            capitanPlayer: FirestoreService.shared.currentUser,
                            avatarImage: nil,
                            name: viewModel.name,
                            email: viewModel.email,
                            whoAreYou: "\(viewModel.selectionWhoAreYou)",
                            teamNumber: 0,
                            payment: viewModel.payment,
                            iGo: false,
                            subscription: false,
                            rating: 50,
                            position: viewModel.positions[
                                viewModel.selectionPositions
                            ],
                            numberOfGoals: 0,
                            winGame: 0,
                            losGame: 0,
                            captain: false)
                        
                        presentationMode.wrappedValue.dismiss()
                    } ) {
                        Text(NSLocalizedString("ProfileAddPlayerViewSave",
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
            
            .navigationBarTitle(Text(
                NSLocalizedString("ProfileAddPlayerViewAddPlayer",
                                  comment: "Add a player")
            ), displayMode: .automatic)
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

struct AddListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAddPlayerView()
    }
}
