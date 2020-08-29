//
//  Award.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct Award {
    let awardView: AnyView
    let awarded: Bool
    
    static func getAwards() -> [Award] {
        return [
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true),
            Award(awardView: AnyView(CellJoinTeamViewController()),
                  awarded: true)
        ]
    }
}
