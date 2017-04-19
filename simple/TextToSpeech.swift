//
//  TextToSpeech.swift
//  Ana
//
//  Created by Mukund, Vishwas on 10/26/16.
//  Copyright © 2016 Pritchard, Adam. All rights reserved.
//

import Foundation
import AVFoundation

class TextToSpeech{
    
    
    func speakText(text: String){
        let speak = AVSpeechSynthesizer()
        let speech = AVSpeechUtterance(string: text)
        speech.volume = 2;
        speak.speak(speech)
    }
    
    
}
