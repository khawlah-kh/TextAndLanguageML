//
//  ContentView.swift
//  TextAndLanguageML
//
//  Created by Khawlah Khalid on 10/07/2023.
//

import SwiftUI
import NaturalLanguage

struct ContentView: View {
    @State var input: String = ""
    @State var result: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Type anything . . .", text: $input, axis: .vertical)
                .font(.headline)
                .textFieldStyle(.roundedBorder)
            Button {
                predictLanguage()
            } label: {
                HStack{
                    Spacer()
                    Text("Predict language")
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                }
                .padding()
                .background {
                    Color.purple
                }.cornerRadius(8)
            }

            Text("Result: \(result)")
                .bold()
        }
        .padding()
    }
    
    

    func predictLanguage(){
        let locale = Locale(identifier: "en")
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(input)
        
        guard let language = recognizer.dominantLanguage else {
            result = "Unknown language"
            return
        }
        
        result = locale.localizedString(forLanguageCode: language.rawValue)
        ?? "Unknown language Code"
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
