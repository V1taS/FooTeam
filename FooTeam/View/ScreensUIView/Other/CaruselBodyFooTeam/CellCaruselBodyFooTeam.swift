//
//  CellCaruselBodyFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct CellCaruselBodyFooTeam: View {
    let backgroundColor: Color
    let imageButton: String
    let nameButton: String
    let descriptionOne: String
    let descriptionTwo: String
    let valueOne: Int
    let valueTwo: Int
    
    var body: some View {
        ZStack {
            Color(.blue)
                .frame(width: 360, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            BackgroundFooTeam(centerColor: backgroundColor)
                .frame(width: 360, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            HStack {
                Image(imageButton)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .offset(x: 0, y: 0)
                VStack {
                    Text(nameButton)
                        .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 190)
                    HStack  {
                        Text(descriptionOne)
                            .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        Text("\(valueOne)")
                            .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                    }
                    HStack  {
                        Text(descriptionTwo)
                            .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        Text("\(valueTwo)")
                            .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                    }
                }
            }
        } .padding(.leading)
    }
}

struct CellCaruselBodyFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        CellCaruselBodyFooTeam(backgroundColor: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                               imageButton: "team",
                               nameButton: "Моя команда",
                               descriptionOne: "Всего игроков:",
                               descriptionTwo: "Придут на игру",
                               valueOne: 18,
                               valueTwo: 15)
    }
}
