//
//  InformationsMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct InformationsMainScreenView: View {
    
    @StateObject private var viewModel = InformationsMainScreenViewModel()
    @Binding var showAcceptPlayers: Bool
    @Binding var showTeamModal: Bool
    
    var body: some View {
        ZStack {
            Color("WhiteAndBlack")
                .frame(width: 180, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10) .stroke(Color("BlackAndWhite")))
            
            VStack {
                Text("ИНФОРМАЦИЯ")
                    .font(.headline)
                    .foregroundColor(Color(.red))
                
                DividerFooTeamMenu()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    HStack {
                        Text("Клуб:")
                            .foregroundColor(Color("BlackAndWhite"))
                        Text("\(viewModel.nameTeam)")
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                    
                    HStack {
                        Text("Иду на игру:")
                            .foregroundColor(Color("BlackAndWhite"))
                        Text("\(viewModel.iGo ? "да" : "нет")")
                            .font(.headline)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                } .frame(width: 160, alignment: .leading)
                
                DividerFooTeamMenu()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    HStack {
                        Text("Игра")
                            .foregroundColor(Color("BlackAndWhite"))
                        Text("\(viewModel.datePlay)")
                            .font(.headline)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                    
                    HStack {
                        Text("Температура:")
                            .foregroundColor(Color("BlackAndWhite"))
                        Text("\(viewModel.temperatureString)°С")
                            .font(.headline)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color("BlackAndWhite"))
                    }
                } .frame(width: 160)
                
                if viewModel.capitan {
                    VStack(alignment: .center, spacing: 1) {
                        HStack {
                            Button(action: { showAcceptPlayers.toggle() }) {
                                Image(systemName: "mail")
                                    .font(.title)
                                    .foregroundColor(viewModel.playersWaitingAccept.isEmpty ? .gray : .green)
                            }
                            
                            Button(action: { showTeamModal.toggle() }) {
                                Image(systemName: "camera.metering.multispot")
                                    .font(.title)
                                    .foregroundColor(.gray)
                            } .sheet(isPresented: $showTeamModal) {
                                TeamShowModalMainScreenView()
                            }
                        }
                    } .frame(width: 160) .padding(.top, 2)
                }
                
                
            }
        }
    }
}

struct InformationMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        InformationsMainScreenView(showAcceptPlayers: .constant(false), showTeamModal: .constant(false))
    }
}
