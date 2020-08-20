//
//  BoxCaruselBodyFooTeam.swift
//  iChat
//
//  Created by Виталий Сосин on 13.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct BoxCaruselBodyFooTeam: View {
    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false) {
                
                HStack {
                    CellCaruselBodyFooTeam(backgroundColor: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), imageButton: "team", nameButton: "Моя команда", descriptionOne: "Всего игроков:", descriptionTwo: "Придут на игру", valueOne: 32, valueTwo: 15)
                    
                    CellCaruselBodyFooTeam(backgroundColor: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), imageButton: "teamCount", nameButton: "Составы", descriptionOne: "Кол-во команд:", descriptionTwo: "Кол-во игроков:", valueOne: 3, valueTwo: 15)
                    
                    CellCaruselBodyFooTeam(backgroundColor: Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), imageButton: "uefa", nameButton: "Турниры", descriptionOne: "Ближайшие:", descriptionTwo: "Выигранные:", valueOne: 0, valueTwo: 0)
                    
                    CellCaruselBodyFooTeam(backgroundColor: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), imageButton: "sponser", nameButton: "Спонсоры", descriptionOne: "Количество:", descriptionTwo: "Бюджет:", valueOne: 12, valueTwo: 5000)
                }
        }
    }
}

struct BoxCaruselBodyFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        BoxCaruselBodyFooTeam()
    }
}
