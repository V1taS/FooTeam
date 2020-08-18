//
//  BoxJoinTeamViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxJoinTeamViewController: View {
    
    @State private var searchText = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            Text("Присоедениться к команде")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            TextField("Поиск...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                CellJoinTeamViewController()
                CellJoinTeamViewController()
            }
            
            HStack {
                CellJoinTeamViewController()
                CellJoinTeamViewController()
            }
            HStack {
                CellJoinTeamViewController()
                CellJoinTeamViewController()
            }
            
            HStack {
                CellJoinTeamViewController()
                CellJoinTeamViewController()
            }
            
            HStack {
                CellJoinTeamViewController()
                CellJoinTeamViewController()
            }
            
            HStack {
                CellJoinTeamViewController()
                CellJoinTeamViewController()
            }
        }
    }
}

struct BoxJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        BoxJoinTeamViewController()
    }
}
