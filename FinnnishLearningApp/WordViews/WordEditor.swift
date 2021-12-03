//
//  WordEditor.swift
//  FinnnishLearningApp
//
//  Created by Richard-Bollans, Jack on 19/11/2021.
//

import SwiftUI
import WebKit




struct WordEditor: View {
    internal init(word: String) {
        self.word = word
    }
    
    let word: String
    var body: some View {
        Text(word)
    }
    
    
}

struct WordEditor_Previews: PreviewProvider {
    static var previews: some View {
        WordEditor(word: "tönkkö")
    }
}
