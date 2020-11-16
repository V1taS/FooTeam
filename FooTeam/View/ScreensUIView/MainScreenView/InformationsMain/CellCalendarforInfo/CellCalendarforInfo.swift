//
//  CellCalendarforInfo.swift
//  FooTeam
//
//  Created by Виталий Сосин on 03.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellCalendarforInfo: View {
    var dayOfweak: String
    var background: UIColor
    var textColor: UIColor
    var cornerColor: UIColor
    
    var body: some View {
        ZStack {
            Color(background)
                .frame(width: 28, height: 28)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .overlay(RoundedRectangle(cornerRadius: 2)
                            .stroke(Color(cornerColor)))
            Text("\(dayOfweak)")
                .font(.callout)
                .lineLimit(1)
                .foregroundColor(Color(textColor))
        }
    }
}

struct CellCalendarforInfo_Previews: PreviewProvider {
    static var previews: some View {
        CellCalendarforInfo(dayOfweak: "Пн",
                            background: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),
                            textColor: UIColor.black,
                            cornerColor: UIColor.gray)
    }
}
