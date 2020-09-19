//
//  PopapCard.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopapCard: View {
    
    let capitanPlayer = FirestoreService.shared.currentUser
    
    @ObservedObject var waitingPlayers = WaitingPlayers()
    
    @Binding var showeWaitingPlayer: Int
    
    var body: some View {
        VStack {
            Button(action: {

                AcceptInvitation.shared.acceptInvitation(player: self.waitingPlayers.players.first!, capitanPlayer: self.capitanPlayer!)
                self.showeWaitingPlayer = 1000
                
            } ) {
                
                MenuRow(title: "Добавить", icon: "person.badge.plus")
            }
            
            Button(action: {

                NoAcceptInvitation.shared.acceptInvitation(player: self.waitingPlayers.players.first!, capitanPlayer: self.capitanPlayer!)
                self.showeWaitingPlayer = 1000
                print("\(String(describing: self.capitanPlayer))")
                
            } ) {
                
                MenuRow(title: "Удалить", icon: "person.badge.minus")
            }
            
            Button(action: {
                self.showeWaitingPlayer = 1000
            } ) {
                
                MenuRow(title: "Отмена", icon: "hand.raised.slash")
            }
        } .padding(.top, 50)
        .frame(maxWidth: .infinity)
        .frame(height: 290)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .padding(.horizontal, 60)
        .overlay(
            VStack {
                ImagePlayer(avatarStringURL: waitingPlayers.players.first?.avatarStringURL ?? "", avatarSize: 100)
                
                Text(waitingPlayers.players.first?.name ?? "")
                .offset(y: -130)
                    .frame(width: 200)
                    .font(.headline)
            }
            
            
        )
    }
}

struct PopapCard_Previews: PreviewProvider {
    static var previews: some View {
        PopapCard(showeWaitingPlayer: .constant(0))
    }
}

struct MenuRow: View {
    
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light, design: .default))
                .imageScale(.large)
                .frame(width: 32, height: 32)
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 130, alignment: .leading)
        }
    }
}
