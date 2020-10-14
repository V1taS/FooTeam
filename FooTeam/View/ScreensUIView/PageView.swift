//
//  PageView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 09.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct PageView: View {
    var body: some View {
        TabView {
            Text("This is")
            Text("Page View")
            Text("In SwiftUI")
        }
        .font(.largeTitle)
        .foregroundColor(.red)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
