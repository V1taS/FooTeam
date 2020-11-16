//
//  WaitingForConfirmation.swift
//  FooTeam
//
//  Created by Виталий Сосин on 24.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Firebase

struct WaitingForConfirmationView: View {
    
    var team: Team
    @StateObject private var viewModel = WaitingForConfirmationViewModel()
    
    var body: some View {
        VStack {
            Text(NSLocalizedString("WaitingForConfirmationViewModelWaitingForConfirmation", comment: "Waiting for confirmation"))
                .font(.title)
                .fontWeight(.bold)
            ProgressView("", value: viewModel.downloadAmount, total: 100)
                .padding()
            
            Button(action: {
                viewModel.isPresented.toggle()
            } ) {
                Text(NSLocalizedString("WaitingForConfirmationViewModelCancel", comment: "Cancel"))
                    .foregroundColor(Color.red)
            }
        }
        .onAppear {
            setTimer()
        }
        
        .alert(item: $viewModel.alertIdentifier) { alert in
            switch alert.id {
            case .first:
                return Alert(title: Text(NSLocalizedString("WaitingForConfirmationViewModelTheTeamIsNotReadyAcceptYou", comment: "The team is not ready to accept You")), dismissButton: .cancel(Text("ok")))
            case .second:
                return Alert(title: Text(NSLocalizedString("JoinToTeamViewModelAttention", comment:"Attention")),
                             message: Text(NSLocalizedString("JoinToTeamViewModelWithdrawRequestAddToTeam", comment:"Do you want to revoke your team addition request?")),
                             primaryButton: Alert.Button.default(Text(NSLocalizedString("JoinToTeamViewModelCancel", comment: "Cancel"))),
                             secondaryButton: Alert.Button.destructive(
                                Text(NSLocalizedString("JoinToTeamViewModelWithdrawRequest", comment: "Withdraw request")), action: {
                                    if !viewModel.player.id.isEmpty {
                                        NoAcceptInvitation.shared.acceptInvitation(player: viewModel.player, idTeam: team.id)
                                        let mainContentFooTeam = UIHostingController(rootView: JoinToTeamView())
                                        mainContentFooTeam.modalPresentationStyle = .fullScreen
                                        UIApplication.shared.windows.first?.rootViewController = mainContentFooTeam
                                    }
                                }
                             )
                )
            }
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
        WaitingForConfirmationView(team: Team(avatarStringURL: "", teamName: "", location: "", teamType: "", rating: 0, maxCountPlayersInTeam: 0, isHidden: false, currentCountPlayersInTeam: 0, country: "", totalMoney: "", gameСosts: "", fieldType: ""))
    }
}
