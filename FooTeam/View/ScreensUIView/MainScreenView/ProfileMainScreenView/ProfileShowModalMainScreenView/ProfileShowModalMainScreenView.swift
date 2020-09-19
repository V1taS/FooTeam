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
    @State var userEditorShow = false
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                                      colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                                      backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)),
                                      namePlayer: "\(viewModel.name)",
                                      photoPlayer: "\(viewModel.avatarStringURL)",
                                      ratingPlayer: "\(viewModel.rating)",
                                      positionPlayer: "\(viewModel.position)",
                                      game: "\(viewModel.numberOfGames)",
                                      goal: "\(viewModel.numberOfGoals)",
                                      win: "\(viewModel.winGame)",
                                      los: "\(viewModel.losGame)")
                
                Form {
                    HStack {
                        Text("Играю в команде:")
                        Spacer()
                        Text("выйти")
                            .foregroundColor(.red)
                        Text("\(viewModel.nameTeam)")
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
                }
                
                VStack {
                    Button(action: {
                        
                        self.userEditorShow.toggle()
                    }) {
                        Text("Редактировать")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Text("\(viewModel.captain ? "КАПИТАН" : "")")
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
        }
        .sheet(
            isPresented: $userEditorShow,
            content: { ProfileEditorView(showModal: $userEditorShow) }
        )
    }
}

struct MyProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileShowModalMainScreenView(showModal: .constant(false))
    }
}
