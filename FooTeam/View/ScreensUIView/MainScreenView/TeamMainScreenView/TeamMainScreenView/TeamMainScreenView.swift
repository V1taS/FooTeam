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
                .frame(maxWidth: 380, idealHeight: 100, maxHeight: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("BlackAndWhite")))
            
            Button(action: { viewModel.isPresentedShowModal.toggle() }) {
                
                HStack {
                    Image("teamCount")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .minimumScaleFactor(0.7)
                        .frame(maxWidth: 150)
                    
                    Spacer()
                    
                    VStack {
                        Text(NSLocalizedString("TeamMainScreenViewStructures",
                                               comment: "Structures"))
                            .font(.title)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color(.red))
                        
                        Text("\(NSLocalizedString("TeamMainScreenViewTotalPlayers", comment: "Total players")) \(viewModel.playersCount)")
                            .foregroundColor(Color("BlackAndWhite"))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .frame(maxWidth: 150)
                        Text("\(NSLocalizedString("TeamMainScreenViewComeToGame", comment: "They will come to the game")) \(viewModel.iGoCount)")
                            .foregroundColor(Color("BlackAndWhite"))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .frame(maxWidth: 150)
                    }
                }.padding(.horizontal)
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
