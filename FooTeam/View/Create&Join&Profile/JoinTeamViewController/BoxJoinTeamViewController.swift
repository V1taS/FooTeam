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
    @State var isPresentedAlertSignOut = false
    
    let awards = Award.getAwards()
    var activeAwards: [Award] {
        awards.filter { $0.awarded }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Поиск...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                GridView(items: activeAwards, columns: 2) { award in
                    VStack {
                        award.awardView
                    }
                } .padding(.top, 0)
            }
            
            .navigationBarTitle("Присоедениться к команде", displayMode: .inline)
            .navigationBarItems(trailing: OutButtonJoinTeam(isPresentedAlertSignOut: $isPresentedAlertSignOut))
        }
    }
}

struct BoxJoinTeamViewController_Previews: PreviewProvider {
    static var previews: some View {
        BoxJoinTeamViewController()
    }
}
