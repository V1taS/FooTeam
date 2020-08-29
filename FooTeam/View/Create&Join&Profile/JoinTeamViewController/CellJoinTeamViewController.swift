//
//  CellJoinTeamViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellJoinTeamViewController: View {
    
    let colorText: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    var body: some View {
        
        ZStack {
            BackgroundFooTeam(firstColor: .gray, centerColor: Color.black.opacity(0.7), lastColor: .gray)
                .frame(width: 170, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 45))
            
            VStack {
                Image("khimki")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                Text("ФК Химки")
                    .foregroundColor(Color(colorText))
                
                Text("Открыта")
                .font(.system(size: 15))
                .foregroundColor(.green)
                .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text("Место: Химки")
                    .foregroundColor(Color(colorText))
                    .font(.system(size: 15))
                    .lineLimit(1)
                Text("Игроков: 18")
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
        CellJoinTeamViewController()
    }
}
