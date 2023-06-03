//
//  WordDescriptionModel.swift
//  FinnnishLearningApp
//
//  Created by Richard-Bollans, Jack on 19/11/2021.
//

import Foundation
import Combine


public final class ViewModel: ObservableObject {
    @Published var isFinnishWord = true
    @Published var newWord = ""
    @Published var words = [String]() {
        didSet {
            UserDefaults.standard.set(words, forKey: "Words")
        }
    }
    
    var newWordHeader : String {
        if isFinnishWord {
            return "Uusi sana"
        } else {
            return "New word"
        }
    }
    
    var addNewWordText: String {
        if isFinnishWord {
            return "Lisää uusi suomenkielinen sana"
        } else {
            return "Add a new english word"
        }
    }
    
    var submitText: String {
        if isFinnishWord {
            return "Lisää"
        } else {
            return "Submit"
        }
    }
    
    var searchText: String {
        if isFinnishWord {
            return "Hae"
        } else {
            return "Search"
        }
    }
    
    var navigationButtonLabel: String {
        if isFinnishWord {
            return "🇫🇮"
        } else {
            return "🇬🇧"
        }
    }
    
    func trimNewWord() -> String? {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let trimmedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard trimmedWord.count > 0 else { return nil }
        
        return trimmedWord
    }
    
    func addNewWord() {
        guard let trimmedWord = trimNewWord() else { return }

        // extra validation to come
        if words.contains(where: { $0 == trimmedWord }) {
            return
        }
        words.insert(trimmedWord, at: 0)
        newWord = ""
        
    }
    
    func removeRows(at offsets: IndexSet) {
        words.remove(atOffsets: offsets)
    }
}
