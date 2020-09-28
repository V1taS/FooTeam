//
//  WaitingForConfirmation.swift
//  FooTeam
//
//  Created by Виталий Сосин on 24.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct WaitingForConfirmationView: View {
    
    @StateObject private var viewModel = WaitingForConfirmationViewModel()
    
    var body: some View {
        VStack {

            Text("Ожидание подтверждения")
                .font(.title)
                .fontWeight(.bold)
            ProgressView("", value: viewModel.downloadAmount, total: 100)
                .padding()
            
            Button(action: {} ) {
                Text("Отмена")
                    .foregroundColor(Color.red)
            }

            
        }
//        .onAppear {
//            setTimer()
//        }
        .fullScreenCover(isPresented: $viewModel.isPresented) {
            TabViewFooTeam()
        }
    }
    
//    private func setTimer() {
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if viewModel.downloadAmount < 100 {
//                viewModel.downloadAmount += 1.1
//            } else {
//                viewModel.downloadAmount = 0
//            }
//        }
//    }
}

struct WaitingForConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForConfirmationView()
    }
}
