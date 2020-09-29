//
//  ProfileMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileMainScreenView: View {
    
    @StateObject private var viewModel = ProfileMainScreenViewModel()
    @State var isPresentedShowModal: Bool = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
                .frame(width: 180, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke()
                )
            
            Button(action: { isPresentedShowModal.toggle() }) {
                
                VStack {
                    Text("ПРОФИЛЬ")
                        .font(.headline)
                        .foregroundColor(Color(.red))
                    Text(viewModel.name)
                        .lineLimit(1)
                        .frame(width: 150)
                        .foregroundColor(.black)
                    
                    ImagePlayer(avatarStringURL: viewModel.avatarStringURL, avatarSize: 125)
                }
            }.sheet(isPresented: $isPresentedShowModal) {
                ProfileShowModalMainScreenView(closeIsPresentedShowModal: $isPresentedShowModal) }
        }
    }
}


struct ProfileMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainScreenView()
    }
}
