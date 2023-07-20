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
    @State var names: [String:String] = [:]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Type anything . . .", text: $input, axis: .vertical)
                .font(.headline)
                .textFieldStyle(.roundedBorder)
            Button {
                print("Good morning".language)
                print("Buenos días".language)
                getNamedEntities()
            } label: {
                HStack{
                    Spacer()
                    Text("Recognise names")
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
            ForEach(names.sorted(by: >), id: \.key){key, value in
                Text("\"\(key)\" is \(value)")
                
            }
                .bold()
        }
        .padding()
    }
    
    

    func getNamedEntities(){
        let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
        tagger.string = input
        //What to process
        let range = NSRange(location: 0, length: input.count)
        //Rules of processing
        let options : NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        //What are we looking for
        let tags : [NSLinguisticTag] = [.personalName, .placeName, .organizationName]

        tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { tag, tokenRange, stop in
            if let tag = tag, tags.contains(tag){
                let name = (input as NSString).substring(with: tokenRange)
                self.names[name] = tag.rawValue
                print("\"\(name)\" is: \(tag.rawValue)")
            }
        }
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension String {
    var language: String? {
        return NSLinguisticTagger.dominantLanguage(for: self)
    }
}


