//
//  ContentView.swift
//  BlankIt
//
//  Created by Lauryn Anderson on 2020-06-20.
//  Copyright © 2020 Lauryn Anderson. All rights reserved.
//

import SwiftUI

struct InputView: View {
    @ObservedObject var data = Data()
    
    var body: some View {
        NavigationView {
            VStack {
                EditableTextView(text: $data.text)
                HStack {
                    Spacer()
                    NavigationLink(destination: OutputView(text: $data.text)) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color.purple)
                    }
                }
            .padding()
            }
            .navigationBarTitle("Your Paragraph")
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
