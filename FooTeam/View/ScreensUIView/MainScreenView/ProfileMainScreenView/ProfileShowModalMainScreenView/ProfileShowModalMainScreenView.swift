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
    
    //    @StateObject private var viewModel = ProfileShowModalMainScreenViewModel()
    
    @ObservedObject var currentUser = CurrentUser()
    @ObservedObject var playersListener = PlayersListener()
    
    @Binding var showModal: Bool
    @State var userEditorShow = false
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                      colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                                      backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)),
                                      namePlayer: "\(currentUser.player?.name ?? "")",
                    photoPlayer: "\(currentUser.player?.avatarStringURL ?? "")",
                    ratingPlayer: "\(currentUser.player?.rating ?? 0)",
                    positionPlayer: "\(currentUser.player?.position ?? "")",
                    game: "\(currentUser.player?.numberOfGames ?? 0)",
                    goal: "\(currentUser.player?.numberOfGoals ?? 0)",
                    win: "\(currentUser.player?.winGame ?? 0)",
                    los: "\(currentUser.player?.losGame ?? 0)")
                
                Form {
                    HStack {
                        Text("Играю в команде:")
                        Spacer()
                        Text("выйти")
                            .foregroundColor(.red)
                        Text("\(currentUser.player?.nameTeam ?? "")")
                            .font(.headline)
                        
                    }
                    
                    HStack {
                        Text("Личный баланс:")
                        Spacer()
                            .foregroundColor(Color.green)
                        Text("\(currentUser.player?.payment ?? "") FCoin")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Месячнвя подписка:")
                        Spacer()
                        Text("\(currentUser.player?.subscription ?? false ? "активна" : "не активна")")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Иду на след. игру:")
                        Spacer()
                        Text("\(currentUser.player?.iGo ?? false ? "да" : "нет")")
                            .font(.headline)
                    }
                }
                
                VStack {
                    Button(action: {
                        
                        self.userEditorShow.toggle()
                    }) {
                        Text("Редактировать")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Text("\(currentUser.player?.captain ?? false ? "КАПИТАН" : "")")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .background(Color.yellow)
                    
                    
                }
                
                }
                
            .navigationBarTitle(Text("Персональная карточка"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                
                self.showModal = false
                
            }) {
                Image(systemName: "multiply")
                    .renderingMode(.original)
                    .font(.title)
            })
        } .sheet(
            isPresented: $userEditorShow,
            content: { ProfileShowModalMainScreenView(currentUser: self.currentUser, playersListener: self.playersListener, showModal: self.$showModal, userEditorShow: self.userEditorShow) }
        )
    }
}

struct MyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileShowModalMainScreenView(showModal: .constant(false))
    }
}
