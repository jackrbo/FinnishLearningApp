//
//  SearchBar.swift
//  FinnnishLearningApp
//
//  Created by Richard-Bollans, Jack on 13/12/2021.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    
    
    
    
    @Binding var text: String
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text:Binding<String>){
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            text = searchText
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("cdios"))
    }
}
