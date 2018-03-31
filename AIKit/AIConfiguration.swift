//
//  AIConfiguration.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//
import Speech

private let urlSessionConfiguration : URLSessionConfiguration = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = ["Authorization" : "Bearer NLGR5H26PCJR6HQQVAUOKVIWVMU4I55W"]
    return configuration
} ()

public class AIConfiguration {
    
    weak var delegate: AIConfigurationDelegate?
    private let recognizer = SFSpeechRecognizer(locale: .autoupdatingCurrent)!
    private let audioEngine = AVAudioEngine()
    private let urlSession = URLSession(configuration: urlSessionConfiguration)
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var audioPlayer: AVAudioPlayer?
    
    public init() {
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioSession.setMode(AVAudioSessionModeMeasurement)
        try! audioSession.setActive(true, with: .notifyOthersOnDeactivation)
    }
    
    func awaitForResponse(for text: String) {
        makeWitRequest(with: text)
    }
    
    func startListeningForResponse() {
        switch SFSpeechRecognizer.authorizationStatus() {
        case .authorized:
            startRecognitionTask()
        case .notDetermined:
            requestAuthorization()
        default:
            makeGoogleRequest(with: .failure)
        }
    }
    
    func stopListeningForResponse() {
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
    
    private func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                self.startRecognitionTask()
            default:
                self.makeGoogleRequest(with: .failure)
            }
        }
    }
    
    private func startRecognitionTask() {
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
                timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                    self.stopListeningForResponse()
                    self.makeWitRequest(with: input)
                }
            } else if (error as NSError?)?.code != 216 {
                self.makeGoogleRequest(with: .failure)
            }
        }
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            if let power = buffer.power {
                self.delegate?.configuration(self, updatedPowerLevel: power)
            }
            request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            stopListeningForResponse()
            makeGoogleRequest(with: .failure)
        }
    }
    
    private func makeWitRequest(with text: String) {
        self.delegate?.configurationStartedLoadingResponse(self)
        var components = URLComponents(string: "https://api.wit.ai/message")!
        components.queryItems = [URLQueryItem(name: "q", value: text)]
        urlSession.dataTask(with: components.url!) { (data, _, _) in
            guard let data = data else {
                self.makeGoogleRequest(with: .failure)
                return
            }
            let decoder = JSONDecoder()
            guard let witResponse = try? decoder.decode(WitResponse.self, from: data) else {
                self.makeGoogleRequest(with: .failure)
                return
            }
            guard let aiResponse = AIResponse(with: witResponse) else {
                self.makeGoogleRequest(with:
                    self.delegate?.configuration(self, aiResponseFor: witResponse) ?? .failure
                )
                return
            }
            self.makeGoogleRequest(with: aiResponse)
        }.resume()
    }
    
    private func makeGoogleRequest(with response: AIResponse) {
        let url = URL(string: "https://texttospeech.googleapis.com/v1beta1/text:synthesize?key=AIzaSyDOx2NKLSBmZx-cjR2Oj3vyI9PIp2CSMMQ")!
        var request = URLRequest(url: url)
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(
            GoogleRequest(input: .init(text: response.message))
        )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                self.delegate?.configuration(self, didReceiveResponse: .failure)
                return
            }
            let decoder = JSONDecoder()
            guard let googleResponse = try? decoder.decode(GoogleResponse.self, from: data),
                let audioData = Data(base64Encoded: googleResponse.audioContent) else {
                self.delegate?.configuration(self, didReceiveResponse: .failure)
                return
            }
            self.delegate?.configuration(self, didReceiveResponse: response)
            self.playAudioData(audioData)
        }.resume()
    }
    
    private func playAudioData(_ data: Data) {
        do {
            self.audioPlayer = try AVAudioPlayer(data: data)
            self.audioPlayer?.play()
        } catch {}
    }
    
}
