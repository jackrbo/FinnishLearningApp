//
//  WordDescriptionModel.swift
//  FinnnishLearningApp
//
//  Created by Richard-Bollans, Jack on 19/11/2021.
//

import Foundation
import Combine

enum OriginLanguage: String, Codable {
    case finnish
    case english
    case italian
    
    var newWordHeader: String {
        switch self {
        case .english:
            return "New word"
        case .finnish:
            return "Uusi sana"
        case .italian:
            return "Nuova parola"
        }
    }
    
    var addNewWordText: String {
        switch self {
        case .english:
            return "Add a new english word"
        case .finnish:
            return "Lisää uusi suomenkielinen sana"
        case .italian:
            return "Aggiungi una nuova parola"
        }
    }
    
    var submitText: String {
        switch self {
        case .english:
            return "Submit"
        case .finnish:
            return "Lisää"
        case .italian:
            return "Aggiungi"
        }
    }
    
    var searchText: String {
        switch self {
        case .english:
            return "Search"
        case .finnish:
            return "Hae"
        case .italian:
            return "Ricerca"
        }
    }
    
    var navigationButtonLabel: String {
        switch self {
        case .english:
            return "🇬🇧"
        case .finnish:
            return "🇫🇮"
        case .italian:
            return "🇮🇹"
        }
    }
    
    func cycle() -> OriginLanguage {
        switch self {
        case .english:
            return .finnish
        case .finnish:
            return .italian
        case .italian:
            return .english
        }
    }
}

enum TargetLanguage: String {
    case finnish
    case english
    case italian
    
    var navigationButtonLabel: String {
        switch self {
        case .english:
            return "🇬🇧"
        case .finnish:
            return "🇫🇮"
        case .italian:
            return "🇮🇹"
        }
    }
    
    var baseDomain: String {
        switch self {
        case .english:
            return "en.wiktionary.org/wiki/"
        case .finnish:
            return "fi.wiktionary.org/wiki/"
        case .italian:
            return "it.wiktionary.org/wiki/"
        }
    }
    
    func cycle() -> TargetLanguage {
        switch self {
        case .english:
            return .finnish
        case .finnish:
            return .italian
        case .italian:
            return .english
        }
    }
}

class Word: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(word, forKey: "word")
        coder.encode(originLanguage, forKey: "originLanguage")
    }
    
    required init?(coder: NSCoder) {
        word = coder.decodeObject(forKey: "word") as? String ?? ""
        originLanguage = coder.decodeObject(forKey: "originLanguage") as? OriginLanguage ?? .english
    }
    
    internal init(word: String, originLanguage: OriginLanguage) {
        self.word = word
        self.originLanguage = originLanguage
    }
    
    let word: String
    let originLanguage: OriginLanguage
}

public final class ViewModel: ObservableObject {
    @Published var newWord = ""
    @Published var words = [Word]() {
        didSet {
            do {
                let savedData = try NSKeyedArchiver.archivedData(withRootObject: words, requiringSecureCoding: false)
                let defaults = UserDefaults.standard
                defaults.set(savedData, forKey: "NewWords")
            } catch {
                print(error)
            }
        }
    }
    @Published var originLanguage = OriginLanguage.finnish
    @Published var targetLanguage = TargetLanguage.finnish
    var wordsToShow: [Word] {
        words.filter {
            $0.originLanguage == originLanguage
        }
    }
    
    var section: String {
        switch originLanguage {
        case .english:
            switch targetLanguage {
            case .english:
                return "#English"
            case .finnish:
                return "#Englanti"
            case .italian:
                return "#Inglese"
            }
        case .finnish:
            switch targetLanguage {
            case .english:
                return "#Finnish"
            case .finnish:
                return "#Suomi"
            case .italian:
                return "#Finlandese"
            }
        case .italian:
            switch targetLanguage {
            case .english:
                return "#Italian"
            case .finnish:
                return "#Italia"
            case .italian:
                return "#Italiano"
            }
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
        if words.compactMap({$0.word}).contains(where: { $0 == trimmedWord }) {
            return
        }
        let newWord = Word(word: trimmedWord, originLanguage: self.originLanguage)
        words.insert(newWord, at: 0)
    }
    
    func removeRows(at offsets: IndexSet) {
        words.remove(atOffsets: offsets)
    }
}
