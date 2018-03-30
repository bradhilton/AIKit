//
//  AIConfiguration.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//
import Speech

let urlSessionConfiguration : URLSessionConfiguration = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = ["Authorization" : "Bearer NLGR5H26PCJR6HQQVAUOKVIWVMU4I55W"]
    return configuration
} ()

public class AIConfiguration {
    
    let recognizer = SFSpeechRecognizer(locale: .autoupdatingCurrent)!
    let audioEngine = AVAudioEngine()
    let urlSession = URLSession(configuration: urlSessionConfiguration)
    var request: SFSpeechAudioBufferRecognitionRequest?
    var task: SFSpeechRecognitionTask?
    
    public init() {
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryRecord)
        try! audioSession.setMode(AVAudioSessionModeMeasurement)
        try! audioSession.setActive(true, with: .notifyOthersOnDeactivation)
    }
    
    public func awaitForResponse(for text: String, with completion: (AIResponse) -> ()){
        completion(.text("Hello_Lorraine"))
    }
    
    public func startListeningForResponse(with completion: @escaping (AIResponse) -> ()) {
        switch SFSpeechRecognizer.authorizationStatus() {
        case .authorized:
            startRecognitionTask(with: completion)
        case .notDetermined:
            requestAuthorization(with: completion)
        default:
            completion(.failure)
        }
    }
    
    public func stopListeningForResponse() {
        if let request = request {
            request.endAudio()
            self.request = nil
        }
        if let task = task {
            task.cancel()
            self.task = nil
        }
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
    
    func requestAuthorization(with completion: @escaping (AIResponse) -> ()) {
        SFSpeechRecognizer.requestAuthorization { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                self.startRecognitionTask(with: completion)
            default:
                completion(.failure)
            }
        }
    }
    
    func startRecognitionTask(with completion: @escaping (AIResponse) -> ()) {
        stopListeningForResponse()
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        self.request = request
        var timer: Timer?
        task = recognizer.recognitionTask(with: request) { (result, error) in
            if let result = result {
                timer?.invalidate()
                timer = Timer(timeInterval: 2.0, repeats: false) { _ in
                    self.stopListeningForResponse()
                    self.makeWitRequest(with: result.bestTranscription.formattedString, and: completion)
                }
            } else {
                completion(.failure)
            }
        }
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            stopListeningForResponse()
            completion(.failure)
        }
    }
    
    public func makeWitRequest(with text: String, and completion: @escaping (AIResponse) -> ()){
        let url = URL(string: "https://api.wit.ai/message")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "q", value: text)]
        urlSession.dataTask(with: components.url!) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            guard let witResponse = try? decoder.decode(WitResponse.self, from: data) else { return }
        }.resume()
    }
    
}
