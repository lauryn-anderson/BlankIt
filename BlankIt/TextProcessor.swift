//
//  TextProcessor.swift
//  BlankIt
//
//  Created by Lauryn Anderson on 2020-06-20.
//  Copyright © 2020 Lauryn Anderson. All rights reserved.
//

import Foundation
import NaturalLanguage

protocol Wordy {
    var value: String { get set }
    var type: NLTag { get }
}

struct Word: Wordy {
    var value: String
    var type: NLTag
    
    init(value: String, type: NLTag){
        self.value = value
        self.type = type
    }
}

struct Blank: Wordy {
    var value: String
    var type: NLTag
    
    init(value: String, type: NLTag) {
        self.value = value
        self.type = type
    }
}

class TextProcessor {
    var wordArray = [Wordy]()
    var wordCounter = 0
    var blankIndex = 0
    var blankArray = [Blank]()
    let maximumCharacters = 5000
    
    func processOriginal(text: String) {
        tagWords(text: text)
        pickBlanks()
        //send blankArray to user for replacement words
        //delegate?.askForReplacement(blanks: blankArray)
    }
    
    func pickBlanks() {
        //identify "blanks" to be replaced
        var adjectiveIndex = 0
        var nounIndex = 0
        var adverbIndex = 0
        var otherIndex = 0
        var index = 0
        
        for word in wordArray {
            switch word.type {
            case .adjective:
                if adjectiveIndex % 3 == 0 {
                    createBlank(value: word.value, type: word.type, index: index)
                }
                adjectiveIndex += 1
            case .noun:
                if nounIndex % 3 == 1 {
                    createBlank(value: word.value, type: word.type, index: index)
                }
                nounIndex += 1
            case .adverb:
                let suffix = word.value.suffix(2)
                if suffix == "ly"{
                    if adverbIndex == 0 {
                        createBlank(value: word.value, type: word.type, index: index)
                    }
                    adverbIndex += 1
                }
            case .personalName:
                createBlank(value: word.value, type: word.type, index: index)
            case .placeName:
                createBlank(value: word.value, type: word.type, index: index)
            case .organizationName:
                createBlank(value: word.value, type: word.type, index: index)
            default:
                otherIndex += 1
            }
            index += 1
        }
    }
    
    func createBlank (value: String, type: NLTag, index: Int) {
        let blank = Blank(value: value, type: type)
        wordArray[index] = blank
        blankArray.append(blank)
        blankIndex += 1
    }
    
    func tagWords(text: String) {
        let tagger = NLTagger(tagSchemes: [.nameTypeOrLexicalClass])
        tagger.string = text
        //let _ = tagger.tags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass)
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameTypeOrLexicalClass) { tag, tokenRange in
            
            if let tag = tag {
                let word = Word(value: (text as NSString).substring(with: NSRange(tokenRange, in: text)), type: tag)
                if wordCounter < maximumCharacters {
                    wordArray.append(word)
                }
                wordCounter = wordCounter + 1
            }
            
            return true
        }
        
        print("all done")
        
        return
    }
    
    func createNew(newWords: [String]) -> String {
        
        var mutableBlanks = newWords
        var output: [String] = []
        
        for word in wordArray {
            if word is Blank {
                let replacement = mutableBlanks.removeFirst()
                output.append(replacement)
            } else {
                output.append(word.value)
            }
        }
        return output.joined()
    }
    
    func resetProcessor() {
        wordArray = []
        wordCounter = 0
        blankIndex = 0
        blankArray = []
    }
}
