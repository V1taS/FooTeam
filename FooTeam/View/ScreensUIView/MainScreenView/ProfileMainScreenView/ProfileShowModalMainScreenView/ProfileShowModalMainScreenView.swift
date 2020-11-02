//
//  ProfileShowModalMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ProfileShowModalMainScreenView: View {
    
    @StateObject private var viewModel = ProfileShowModalMainScreenViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    CellTopPlayersFooTeam(namePlayer: "\(viewModel.player.name)",
                                          photoPlayer: "\(viewModel.player.avatarStringURL)",
                                          ratingPlayer: "\(viewModel.player.rating)",
                                          positionPlayer: "\(viewModel.player.position)",
                                          locationCountryImage: "",
                                          logoTeamImage: viewModel.team.avatarStringURL ,
                                          game: "\(viewModel.player.winGame + viewModel.player.losGame)",
                                          goal: "\(viewModel.player.numberOfGoals)",
                                          win: "\(viewModel.player.winGame)",
                                          los: "\(viewModel.player.losGame)")
                        .padding(.vertical, 8)
                    Spacer()
                }
                
                HStack {
                    Text("Играю в команде:")
                    Spacer()
                    Text("\(viewModel.team.teamName)")
                        .font(.headline)
                }
                
                HStack {
                    Text("Личный баланс:")
                    Spacer()
                        .foregroundColor(Color.green)
                    Text("\(viewModel.player.payment) FCoin")
                        .font(.headline)
                }
                
                HStack {
                    Text("Месячная подписка:")
                    Spacer()
                    Text("\(viewModel.player.subscription ? Text("активна").foregroundColor(Color.green) : Text("не активна").foregroundColor(Color.red))")
                        .font(.headline)
                }
                
                HStack {
                    Text("Иду на след. игру:")
                    Spacer()
                    Text("\(viewModel.player.iGo ? Text("да").foregroundColor(Color.green) : Text("нет").foregroundColor(Color.red))")
                        .font(.headline)
                }
                
                HStack {
                    Spacer()
                    Button(action: { viewModel.isPresentedAlert.toggle()} ) {
                        Text("Выйти")
                            .font(.system(.headline, design: .serif))
                            .foregroundColor(Color.red)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .cornerRadius(5)
                    }
                    .fullScreenCover(isPresented: $viewModel.outFromTeam, content: {
                        JoinToTeamView()
                    })
                    Spacer()
                }
            } .alert(isPresented: self.$viewModel.isPresentedAlert) {
                Alert(title: Text("Внимание"),
                      message: Text("Вы хотите выйти из команды?"),
                      primaryButton: Alert.Button.default(Text("Отмена")),
                      secondaryButton: Alert.Button.destructive(
                        Text("Выйти"), action: {
                            DeletePlayerFromTeam.shared.deletPlayerFromTeam(player: FirestoreService.shared.currentUser)
                            viewModel.outFromTeam.toggle()
                        }
                      )
                )
            }
            
            .navigationBarTitle(Text("Персональная карточка"), displayMode: .inline)
            
            .navigationBarItems(
                leading: Button(action: {
                    BufferIDplayer.shared.saveUserID(id: viewModel.player.id)
                    self.viewModel.isPresentedProfileEditor.toggle()
                    
                }) {
                    Image(systemName: "pencil")
                        .font(.title)
                        .foregroundColor(Color("BlackAndWhite"))
                }.sheet(
                    isPresented: $viewModel.isPresentedProfileEditor,
                    content: { PlayersProfileEditor(player: viewModel.player) }
                ),
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "multiply")
                        .font(.title)
                        .foregroundColor(Color("BlackAndWhite"))
                })
        }
    }
}

struct MyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileShowModalMainScreenView()
    }
}
