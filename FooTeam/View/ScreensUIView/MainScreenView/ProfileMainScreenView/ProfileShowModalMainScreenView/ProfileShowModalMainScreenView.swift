//
//  ProfileShowModalMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 07.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileShowModalMainScreenView: View {
    
    @StateObject private var viewModel = ProfileShowModalMainScreenViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                HStack {
                    Spacer()
                    CellTopPlayersFooTeam(backgroundColor: Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)),
                                          namePlayer: "\(viewModel.name)",
                                          photoPlayer: "\(viewModel.avatarStringURL)",
                                          ratingPlayer: "\(viewModel.rating)",
                                          positionPlayer: "\(viewModel.position)",
                                          locationCountryImage: "",
                                          logoTeamImage: viewModel.team.avatarStringURL ?? "",
                                          game: "\(viewModel.winGame + viewModel.losGame)",
                                          goal: "\(viewModel.numberOfGoals)",
                                          win: "\(viewModel.winGame)",
                                          los: "\(viewModel.losGame)")
                        .padding(.vertical, 8)
                    Spacer()
                }
                
                HStack {
                    Text("Играю в команде:")
                    Spacer()
                    Text("\(viewModel.team.teamName ?? "")")
                        .font(.headline)
                }
                
                HStack {
                    Text("Личный баланс:")
                    Spacer()
                        .foregroundColor(Color.green)
                    Text("\(viewModel.payment) FCoin")
                        .font(.headline)
                }
                
                HStack {
                    Text("Месячнвя подписка:")
                    Spacer()
                    Text("\(viewModel.subscription ? "активна" : "не активна")")
                        .font(.headline)
                }
                
                HStack {
                    Text("Иду на след. игру:")
                    Spacer()
                    Text("\(viewModel.iGo ? "да" : "нет")")
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
                    self.viewModel.isPresentedShowModal.toggle()
                    
                }) {
                    Image(systemName: "pencil")
                        .renderingMode(.original)
                        .font(.title)
                }.sheet(
                    isPresented: $viewModel.isPresentedShowModal,
                    content: { PlayersProfileEditor(closeIsPresentedShowModal: $viewModel.isPresentedShowModal, player: viewModel.player) }
                ),
                trailing: Button(action: { viewModel.closeIsPresentedShowModal = false }) {
                    Image(systemName: "multiply")
                        .renderingMode(.original)
                        .font(.title)
                })
        }
    }
}

struct MyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileShowModalMainScreenView()
    }
}
