//
//  ListPlayersFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListPlayersSecondScreenView: View {
    
    @ObservedObject private var viewModel = ListPlayersSecondScreenViewModel()
    let notifications = Notifications()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: HStack {
                        Text(NSLocalizedString("ListPlayersSecondScreenViewBasicStructure",
                                               comment: "Basic structure"))
                        Spacer()
                        Text("\(viewModel.playersMain.count)")
                            .padding(.trailing, 8)
                    } ) {
                        ForEach(viewModel.playersMain, id: \.self) { player in
                            NavigationLink(destination: ListPlayersProfileShow(player: player)) {
                                HStack {
                                    Text("\(player.name)")
                                    Spacer()
                                    if #available(iOS 14.0, *) {
                                        Text("\(player.captain ? Text(NSLocalizedString("ListPlayersSecondScreenViewCaptain", comment: "Captain")).font(.headline) : Text(""))")
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    
                                    if #available(iOS 14.0, *) {
                                        Text("\(player.whoAreYou == "1" ? Text(NSLocalizedString("ListPlayersSecondScreenViewViewer", comment: "Viewer")).font(.headline) : Text(""))")
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    
                                    Text("I-GO")
                                        .foregroundColor(player.iGo ? .green : .red)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                    
                    Section(header: HStack {
                        Text(NSLocalizedString("ListPlayersSecondScreenViewReservePlayers",
                                               comment: "Reserve players"))
                        Spacer()
                        Text("\(viewModel.playersReserv.count)")
                            .padding(.trailing, 8)
                    } ) {
                        ForEach(viewModel.playersReserv, id: \.self) { player in
                            NavigationLink(destination: ListPlayersProfileShow(player: player)) {
                                HStack {
                                    Text("\(player.name)")
                                    Spacer()
                                    
                                    if #available(iOS 14.0, *) {
                                        Text("\(player.captain ? Text(NSLocalizedString("ListPlayersSecondScreenViewCaptain", comment: "Captain")).font(.headline) : Text(""))")
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    
                                    if #available(iOS 14.0, *) {
                                        Text("\(player.whoAreYou == "1" ? Text(NSLocalizedString("ListPlayersSecondScreenViewViewer", comment: "Viewer")).font(.headline) : Text(""))")
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    
                                    Text("I-GO")
                                        .foregroundColor(player.iGo ? .green : .red)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                }
            }
            
            .navigationBarItems(trailing:
                                    VStack {
                                        if FirestoreService.shared.currentUser.captain {
                                            Button(action: {
                                                viewModel.isPresentedShowModal.toggle()
                                            }) {
                                                Image(systemName: "square.and.pencil")
                                                    .font(.title)
                                                    .foregroundColor(Color("BlackAndWhite"))
                                            }
                                        }
                                    }
            ) .navigationBarTitle(Text(NSLocalizedString("ListPlayersSecondScreenViewMyTeam",
                                                         comment: "My team")))
        } .sheet(
            isPresented: $viewModel.isPresentedShowModal,
            content: { ProfileAddPlayerView() }
        )
    }
}

struct ListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersSecondScreenView()
    }
}
