//
//  ContentView.swift
//  BlankIt
//
//  Created by Lauryn Anderson on 2020-06-20.
//  Copyright © 2020 Lauryn Anderson. All rights reserved.
//

import SwiftUI

struct InputView: View {
    @State var text = ""
    
    var body: some View {
        EditableTextView(text: $text)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: "")
    }
}
