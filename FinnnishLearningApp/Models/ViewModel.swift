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
}
