//
//  EditableTextView.swift
//  BlankIt
//
//  Created by Lauryn Anderson on 2020-06-20.
//  Copyright © 2020 Lauryn Anderson. All rights reserved.
//

import SwiftUI
import UIKit

struct EditableTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.contentInset = UIEdgeInsets(top: 5,
            left: 10, bottom: 5, right: 5)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> EditableTextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var control: EditableTextView
        
        init(_ control: EditableTextView) {
            self.control = control
        }
        
        func textViewDidChange(_ textView: UITextView) {
            control.text = textView.text
        }
    }
}

struct EditableTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditableTextView(text: InputView().$data.text)
    }
}
