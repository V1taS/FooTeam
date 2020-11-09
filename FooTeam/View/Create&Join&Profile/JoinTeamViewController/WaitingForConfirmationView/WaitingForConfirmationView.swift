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
            Text(NSLocalizedString("WaitingForConfirmationViewModelWaitingForConfirmation", comment: "Waiting for confirmation"))
                .font(.title)
                .fontWeight(.bold)
            ProgressView("", value: viewModel.downloadAmount, total: 100)
                .padding()
            
            Button(action: {
                let mainContentFooTeam = UIHostingController(rootView: JoinToTeamView())
                mainContentFooTeam.modalPresentationStyle = .fullScreen
                UIApplication.shared.windows.first?.rootViewController = mainContentFooTeam
            } ) {
                Text(NSLocalizedString("WaitingForConfirmationViewModelCancel", comment: "Cancel"))
                    .foregroundColor(Color.red)
            }
        }
        .onAppear {
            setTimer()
        }
        .alert(isPresented: $viewModel.playerNoAccept) {
            Alert(title: Text(NSLocalizedString("WaitingForConfirmationViewModelTheTeamIsNotReadyAcceptYou", comment: "The team is not ready to accept You")), dismissButton: .cancel(Text("ok")))
        }
    }
    
    private func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if viewModel.downloadAmount < 100 {
                viewModel.downloadAmount += 1.1
            } else {
                viewModel.downloadAmount = 0
            }
        }
    }
}

struct WaitingForConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForConfirmationView()
    }
}
