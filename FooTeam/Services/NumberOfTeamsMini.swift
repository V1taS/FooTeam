//
//  NumberOfTeams.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class NumberOfTeamsMini: ObservableObject {
    
    static let shared = NumberOfTeamsMini()
    
    func numberOfTeams(countPlauers: Int) -> Int {
        if countPlauers < 10 { return 0 }
        
        if countPlauers >= 10 && countPlauers <= 11 {
            if countPlauers % 2 == 0 {
                return 2
            } else {
                return 2
            }
        }
        
        if countPlauers >= 12 && countPlauers <= 13 {
            if countPlauers % 2 == 0 {
                return 2
            } else {
                return 2
            }
        }
        
        if countPlauers >= 14 && countPlauers <= 15 {
            if countPlauers % 3 == 0 {
                return 3
            } else {
                return 3
            }
        }
        
        if countPlauers == 16 { return 3 }
        if countPlauers == 17 { return 3 }
        if countPlauers == 18 { return 3 }
        if countPlauers == 19 { return 4 }
        if countPlauers == 20 { return 4 }
        if countPlauers == 21 { return 4 }
        if countPlauers == 22 { return 4 }
        if countPlauers >= 23 { return 0 }
        return 0
    }
}
