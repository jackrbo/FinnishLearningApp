//
//  ContentView.swift
//  FinnnishLearningApp
//
//  Created by Richard-Bollans, Jack on 19/11/2021.
//

import SwiftUI

struct MainView: View {
    @State var isAlertPresented = false
    @State var words = [String]() {
        didSet {
            UserDefaults.standard.set(words, forKey: "Words")
        }
    }
    @StateObject var viewModel = ViewModel()
    
    @State private var showingSheet = false
    
    @State private var newWord = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text(viewModel.newWordHeader)) {
                        HStack {
                            TextField(viewModel.addNewWordText, text: $newWord)
                                .padding()
                                .disableAutocorrection(true)
                        }
                        HStack {
                            Button(action: {
                                addNewWord()
                            }) {
                                Text(viewModel.submitText)
                                    .foregroundColor(.white)
                                    
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .frame(maxWidth: .infinity, alignment: .center).padding()
                            .background(Color.blue).cornerRadius(5)
                            Spacer()
                            Button(action: {
                                if let _ =
                                    trimNewWord() {                  showingSheet.toggle()
                                }
                            }) {
                                Text(viewModel.searchText)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .center).padding()
                            .background(Color.blue).cornerRadius(5)
                            .sheet(isPresented: $showingSheet) {
                                if let trimmedWord = trimNewWord() {
                                    WordDescription(word: trimmedWord, viewModel: viewModel)
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    
                    ForEach(words, id: \.self) { word in
                        NavigationLink(destination: WordDescription(word: word, viewModel: viewModel)) {
                                Text(word)
                            }
                    }
                    .onDelete(perform: removeRows)
                }
                .navigationTitle(Text("Finnish words"))
                .navigationBarItems(leading: Button(action: { viewModel.isFinnishWord.toggle()})
                {
                    Text(viewModel.navigationButtonLabel)
                        .font(.largeTitle)
                }
                )
            }
        }
        .onSubmit(addNewWord)
        
        .onAppear(){
            if let savedWords = UserDefaults.standard.stringArray(forKey: "Words") {
                words = savedWords
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

        words.insert(trimmedWord, at: 0)
        newWord = ""
        
    }
    
    func removeRows(at offsets: IndexSet) {
        words.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
