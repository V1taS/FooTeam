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
    
    @StateObject private var viewModel = ListPlayersSecondScreenViewModel()
    @State var isPresentedShowModal: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Основной состав")) {
                        ForEach(viewModel.playersMain,
                                id: \.self) { player in
                            NavigationLink(destination: ListPlayersProfileShow(player: player)) {
                                HStack {
                                    Text("\(player.name)")
                                    Spacer()
                                    Text("\(player.captain ? "Капитан" : "")")
                                        .font(.headline)
                                    Text("I-GO")
                                        .foregroundColor(player.iGo ? .green : .red)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Запасные игроки")) {
                        ForEach(viewModel.playersReserv, id: \.self) { player in
                            NavigationLink(destination: ListPlayersProfileShow(player: player)) {
                                HStack {
                                    Text("\(player.name)")
                                    Spacer()
                                    Text("\(player.captain ? "Капитан" : "")")
                                        .font(.headline)
                                    Text("I-GO")
                                        .foregroundColor(player.iGo ? .green : .red)
                                        .fontWeight(.bold)
                                    
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Моя команда"))
            .navigationBarItems(trailing:
                                    Button(action: { self.isPresentedShowModal.toggle() }) {
                                        Image(systemName: "square.and.pencil").renderingMode(.original)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                        
                                    })
        } .sheet(
            isPresented: $isPresentedShowModal,
            content: { ProfileAddPlayerView(showModal: self.$isPresentedShowModal) }
        )
    }
}


struct ListPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayersSecondScreenView()
    }
}
