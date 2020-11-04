//
//  NumberOfTeamsFullField.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class NumberOfTeamsFullField: ObservableObject {
    
    static let shared = NumberOfTeamsFullField()
    
    func numberOfTeams(countPlauers: Int) -> Int {
        
        if countPlauers < 10 { return 0 }
        
        if countPlauers >= 10 { return 2 }
        
        return 0
    }
}

