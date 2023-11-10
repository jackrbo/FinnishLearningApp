//
//  WordDescription.swift
//  FinnnishLearningApp
//
//  Created by Richard-Bollans, Jack on 19/11/2021.
//


import SwiftUI
import WebKit


struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

struct WordDescription: View {
    internal init(word: String, viewModel: ViewModel) {
        self.word = word
        self.viewModel = viewModel
    }
    
    let viewModel: ViewModel
    
    let word: String
    var testCount = 0
    
    private var urlPath = ""
    private var url : URL {
        let urlPath = "\(viewModel.targetLanguage.baseDomain)\(word)\(viewModel.section)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "\(viewModel.targetLanguage.baseDomain)\(word)\(viewModel.section)"
        return  URL(string: "https://\(urlPath)") ?? URL(string: "https://fi.wiktionary.org/wiki")!
        
    }
    
    var body: some View {
        VStack {
            Section {
                Text(word)
            }
            
            WebView(request: URLRequest(url: url))
                .toolbar {
                NavigationLink(destination: WordEditor(word: word)) {
                    Text("Edit")
                }
            }
        }
    }
}

struct WordDescription_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WordDescription(word: "ä", viewModel: ViewModel())
        }
    }
}
