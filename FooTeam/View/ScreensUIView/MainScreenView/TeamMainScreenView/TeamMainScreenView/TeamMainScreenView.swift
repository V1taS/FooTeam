//
//  TeamMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct TeamMainScreenView: View {
    
    @StateObject private var viewModel = TeamMainScreenViewModel()
    
    var body: some View {
        ZStack {
            Color("WhiteAndBlack")
                .frame(width: 380, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10) .stroke(Color("BlackAndWhite")))
            
            Button(action: { viewModel.isPresentedShowModal.toggle() }) {
                
                HStack {
                    Image("teamCount")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                    
                    Spacer()
                    
                    VStack {
                        Text("Составы")
                            .font(.title)
                            .foregroundColor(Color(.red))
                        
                        Text("Всего игроков: \(viewModel.playersCount)")
                            .foregroundColor(Color("BlackAndWhite"))
                        Text("Придут на игру: \(viewModel.iGoCount)")
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                }.padding(.horizontal, 36)
            } .sheet(
                isPresented: $viewModel.isPresentedShowModal,
                content: { ListTeamsMainScreenView() }
            )
        }
    }
}

struct MyTeamMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TeamMainScreenView()
    }
}
