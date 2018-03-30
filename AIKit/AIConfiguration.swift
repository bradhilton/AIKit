//
//  AIConfiguration.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//
import Speech

public class AIConfiguration {
 
    let recognizer = SFSpeechRecognizer(locale: .autoupdatingCurrent)
    let request = SFSpeechAudioBufferRecognitionRequest()
    let audioEngine = AVAudioEngine()
    let audioSession: AVAudioSession = {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print(error)
        }
        return audioSession
    }()
    
    public init () {}
    
    public func awaitForResponse(for text: String, with completion: (AIResponse) -> ()){
        completion(.text("Hello_Lorraine"))
        
    }
    public func requestAuthorization(){
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                break
            case .denied:
                break
            case .restricted:
                break
            case .notDetermined:
                break
            }
        }
    }
    public func speech(){
        guard let recognizer = recognizer else { return }
        request.shouldReportPartialResults = true
        
        
        recognizer.recognitionTask(with: request) { (result, error) in
            
        }
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        
        try? audioEngine.start()
    }
    
}
