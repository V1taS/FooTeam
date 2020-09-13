//
//  CellJoinTeamViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellJoinTeamViewController: View {
    
    var team: Teams
    
    let colorText: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    var body: some View {
        
        ZStack {
            BackgroundFooTeam(firstColor: .gray, centerColor: Color.black.opacity(0.7), lastColor: .gray)
                .frame(width: 170, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack {
                Image("khimki")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                Text("\(team.teamName ?? "")")
                    .foregroundColor(Color(colorText))
                
                Text("\(team.teamType ?? "")")
                .font(.system(size: 15))
                .foregroundColor(.green)
                .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text("Место: \(team.location ?? "")")
                    .foregroundColor(Color(colorText))
                    .font(.system(size: 15))
                    .lineLimit(1)
                Text("Игроков: \(team.rating ?? 0)")
                    .foregroundColor(Color(colorText))
                    .font(.system(size: 15))
                    .lineLimit(1)
            }
            .frame(width: 160)
        }
    }
}

struct CellJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        CellJoinTeamViewController(team: Teams(avatarStringURL: "", teamName: "Khimki", location: "Russia", teamType: "Close", rating: 17))
    }
}
