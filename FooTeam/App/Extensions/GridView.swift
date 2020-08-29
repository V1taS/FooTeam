//
//  GridView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct GridView<Conten, T>: View where Conten: View {
    var items: [T]
    var columns: Int
    var rows: Int {
        items.count / columns
    }
    
    let content: (T) -> Conten
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ForEach(0...self.rows, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0..<self.columns) { columnsIndex in
                                Group {
                                    if self.elementFor(row: rowIndex, and: columnsIndex) != nil {
                                        self.content(self.items[self.elementFor(row: rowIndex, and: columnsIndex)!])
                                            .frame(width: geometry.size.width / CGFloat(self.columns),
                                                   height: geometry.size.width / CGFloat(self.columns))
                                    } else {
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension GridView {
    private func elementFor(row: Int, and colomn: Int) -> Int? {
        let index = row * columns + colomn
        return index < items.count ? index : nil
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(items: [11, 3, 7, 17, 5, 2, 1], columns: 3) { item in
            Text("\(item)")
        }
    }
}
