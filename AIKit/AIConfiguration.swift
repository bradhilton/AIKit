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
    
    weak var delegate: AIConfigurationDelegate?
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
    
    public func awaitForResponse(for text: String) {
        makeWitRequest(with: text)
    }
    
    public func startListeningForResponse() {
        switch SFSpeechRecognizer.authorizationStatus() {
        case .authorized:
            startRecognitionTask()
        case .notDetermined:
            requestAuthorization()
        default:
            delegate?.configuration(self, didReceiveResponse: .failure)
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
    
    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                self.startRecognitionTask()
            default:
                self.delegate?.configuration(self, didReceiveResponse: .failure)
            }
        }
    }
    
    func startRecognitionTask() {
        stopListeningForResponse()
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        self.request = request
        var timer: Timer?
        task = recognizer.recognitionTask(with: request) { (result, error) in
            if let result = result {
                let input = result.bestTranscription.formattedString
                self.delegate?.configuration(self, userInputUpdated: input)
                timer?.invalidate()
                timer = Timer(timeInterval: 2.0, repeats: false) { _ in
                    self.stopListeningForResponse()
                    self.makeWitRequest(with: input)
                }
            } else {
                self.delegate?.configuration(self, didReceiveResponse: .failure)
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
            delegate?.configuration(self, didReceiveResponse: .failure)
        }
    }
    
    public func makeWitRequest(with text: String) {
        self.delegate?.configurationStartedLoadingResponse(self)
        let url = URL(string: "https://api.wit.ai/message")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "q", value: text)]
        urlSession.dataTask(with: components.url!) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            guard let witResponse = try? decoder.decode(WitResponse.self, from: data) else { return }
            self.delegate?.configuration(self, didReceiveResponse: AIResponse(witResponse: witResponse))
        }.resume()
    }
    
}
