//
//  OutputView.swift
//  BlankIt
//
//  Created by Lauryn Anderson on 2020-06-20.
//  Copyright © 2020 Lauryn Anderson. All rights reserved.
//

import SwiftUI

struct OutputView: View {
    @Binding var text: String
    
    var body: some View {
        Text(verbatim: text)
    }
}

struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView(text: InputView().$data.text)
    }
}
