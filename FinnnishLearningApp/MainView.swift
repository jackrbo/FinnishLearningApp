//
//  ContentView.swift
//  FinnnishLearningApp
//
//  Created by Richard-Bollans, Jack on 19/11/2021.
//

import SwiftUI

struct MainView: View {
    @State var isAlertPresented = false
    @StateObject var viewModel = ViewModel()
    
    @State private var showingSheet = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Finnish words")
                    .font(.title)
                    .bold()
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal")
                    }
                    .padding(.leading)
                    Spacer()
                    Button(action: { viewModel.isFinnishWord.toggle()})
                    {
                        Text(viewModel.navigationButtonLabel)
                            .font(.largeTitle)
                    }
                    .padding(.trailing)
                }
                
                
                SearchBar(text: $viewModel.newWord)
                    .padding(.bottom)
                List {
                    
                    Section(header: Text(viewModel.newWordHeader)) {
                        
//                        HStack {
//                            TextField(viewModel.addNewWordText, text: $newWord)
//                                .padding()
//                                .disableAutocorrection(true)
//                        }
                        HStack {
                            SearchButton(name: viewModel.submitText) {
                            viewModel.addNewWord()
                            }
                            Spacer()
                            SearchButton(name: viewModel.searchText) {
                                if let _ =
                                    viewModel.trimNewWord() {                  showingSheet.toggle()
                                }
                            }
                            .sheet(isPresented: $showingSheet) {
                                if let trimmedWord = viewModel.trimNewWord() {
                                    WordDescription(word: trimmedWord, viewModel: viewModel)
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    
                    ForEach(viewModel.words.filter {
                        viewModel.newWord.isEmpty ? true: $0.lowercased().prefix(viewModel.newWord.count).contains(viewModel.newWord.lowercased())
                    }, id: \.self) { word in
                        NavigationLink(destination: WordDescription(word: word, viewModel: viewModel)) {
                                Text(word)
                            }
                    }
                    .onDelete(perform: viewModel.removeRows)
                }
            }
        }
        .onSubmit(viewModel.addNewWord)
        .onAppear(){
            if let savedWords = UserDefaults.standard.stringArray(forKey: "Words") {
                viewModel.words = savedWords
            }
        }
    }
}

struct SearchButton: View {
    let name: String
    let action: () -> Void
   
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(name)
                .foregroundColor(.white)
            
        }
        .buttonStyle(BorderlessButtonStyle())
        .frame(maxWidth: .infinity, alignment: .center).padding()
        .background(Color.blue).cornerRadius(5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
