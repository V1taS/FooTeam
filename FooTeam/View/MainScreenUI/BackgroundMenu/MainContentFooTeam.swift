//
//  MainContentFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct MainContentFooTeam: View {
    
    @Binding var index: Int
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 15){
                HeaderFooTeam(index: $index, show: $show)
                Spacer(minLength: 0)
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding()
            
            GeometryReader {_ in
                VStack{
                    if self.index == 0 {
                        ScrollView {
                            TopPlayersFooTeam()
                            CaruselBodyFooTeam()
                        }
                    }
                    else if self.index == 1 {
                        ScrollView {
                            TopPlayersFooTeam()
                            CaruselBodyFooTeam()
                        }
                    }
                    else if self.index == 2 {
                        ScrollView {
                            TopPlayersFooTeam()
                            CaruselBodyFooTeam()
                        }
                    }
                    else{
                        ScrollView {
                            TopPlayersFooTeam()
                            CaruselBodyFooTeam()
                        }
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(self.show ? 30 : 0)
        .scaleEffect(self.show ? 0.6 : 1)
        .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
        .rotationEffect(.init(degrees: self.show ? -5 : 0))
    }
}

struct MainContentFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        MainContentFooTeam(index: .constant(0), show: .constant(false))
    }
}
