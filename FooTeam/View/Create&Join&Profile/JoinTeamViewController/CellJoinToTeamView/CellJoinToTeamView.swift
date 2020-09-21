//
//  CellJoinToTeamView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellJoinToTeamView: View {
    
    var team: Teams
    var currentUser = FirestoreService.shared.currentUser

    @State var showAlert = false
    
    let colorText: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    var body: some View {
        
        VStack {
            
            Button(action: { self.showAlert.toggle() } ) {
                ZStack {
                    BackgroundFooTeam(firstColor: .gray, centerColor: Color.black.opacity(0.7), lastColor: .gray)
                        .frame(width: 170, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack {
                        ImagePlayer(avatarStringURL: team.avatarStringURL ?? "", avatarSize: 60, placeholder: "team")

                        Text("\(team.teamName ?? "")")
                            .foregroundColor(Color(colorText))
                            .font(.title)
                        
                        Text("\(team.teamType ?? "")")
                            .font(.system(size: 15))
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .padding(.top, 1)
                        
                        Text("\(team.location ?? "")")
                            .foregroundColor(Color(colorText))
                            .font(.system(size: 15))
                            .padding(.top, 1)
//                        Text("Игроков: \(countPlayersInTeam.players.count)")
//                            .foregroundColor(Color(colorText))
//                            .font(.system(size: 15))
//                            .lineLimit(1)

                    }
                    .frame(width: 160, height: 170)
                }
                    
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Отправить запрос команде?"),
                          primaryButton: .default(Text("Отправить запрос")) {
                            
                            JoinTheTeam.shared.SaveIDinTeam(player: self.currentUser!, team: self.team)
                            
                        },
                          secondaryButton: .destructive(Text("Отмена")))
                }
            }
        }
    }
    
    struct CellJoinTeamViewController_Previews: PreviewProvider {
        static var previews: some View {
            CellJoinToTeamView(team: Teams(avatarStringURL: "", teamName: "Teadfdfd", location: "Rus", teamType: "Type", rating: 80))
        }
    }
}
