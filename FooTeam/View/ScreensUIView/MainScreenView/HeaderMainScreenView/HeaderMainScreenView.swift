//
//  HeaderMainScreenView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct HeaderMainScreenView: View {
    
    @StateObject private var viewModel = HeaderMainScreenViewModel()
    
    var body: some View {
        HStack {
            ZStack {
                Color("WhiteAndBlack")
                    .frame(height: 30)
                    .border(Color("BlackAndWhite"))
                
                HStack {
                    Text("Баланс:")
                        .padding(.leading)
                        .foregroundColor(Color("BlackAndWhite"))
                    Spacer()
                    Text("\(viewModel.balance)")
                        .font(.headline)
                        .foregroundColor(Color("BlackAndWhite"))
                    Text("FCoin")
                        .padding(.trailing)
                        .foregroundColor(Color("BlackAndWhite"))
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
