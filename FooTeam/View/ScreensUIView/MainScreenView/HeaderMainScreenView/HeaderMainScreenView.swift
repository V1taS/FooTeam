//
//  HeaderMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct HeaderMainScreenView: View {
    
    @ObservedObject var currentUser = CurrentUser()
    
        @StateObject private var viewModel = HeaderMainScreenViewModel()
    
    var body: some View {
        HStack {
            ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
                .frame(height: 30)
                .border(Color.black)
                
                HStack {
                    Text("Баланс:")
                    .padding(.leading)
                    Spacer()
                    Text("\(viewModel.balance)")
                        .font(.headline)
                    Text("FCoin")
                    .padding(.trailing)
                }
            }
        }
    }
}

struct HeaderMainFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        HeaderMainScreenView()
    }
}
