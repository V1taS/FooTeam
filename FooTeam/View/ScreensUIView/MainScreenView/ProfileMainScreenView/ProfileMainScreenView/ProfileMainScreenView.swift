//
//  ProfileMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct ProfileMainScreenView: View {
    
    @StateObject private var viewModel = ProfileMainScreenViewModel()
    
    var body: some View {
        ZStack {
            Color("WhiteAndBlack")
                .frame(width: 180, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10) .stroke(Color("BlackAndWhite")))
            
            Button(action: {
                viewModel.isPresentedShowModal.toggle()
            }) {
                VStack {
                    Text("ПРОФИЛЬ")
                        .font(.headline)
                        .foregroundColor(Color(.red))
                    Text(viewModel.name)
                        .lineLimit(1)
                        .frame(width: 150)
                        .foregroundColor(Color("BlackAndWhite"))
                    
                    ImagePlayer(avatarStringURL: viewModel.avatarStringURL, avatarSize: 125)
                }
            }.sheet(isPresented: $viewModel.isPresentedShowModal) {
                ProfileShowModalMainScreenView() }
        }
    }
}


struct ProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainScreenView()
    }
}
