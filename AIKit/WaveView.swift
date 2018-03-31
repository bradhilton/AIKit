//
//  WaveView.swift
//  BanjoTuner
//
//  Created by Lorraine Alexander on 6/12/17.
//  Copyright © 2017 Alexander Apps. All rights reserved.
//

import UIKit

// This is a swift version of https://github.com/stefanceriu/SCSiriWaveformView, thanks to stefanceriu
@IBDesignable
class WaveView: UIView {
    
    var phase: CGFloat = 0.5
    @IBInspectable var amplitude: CGFloat = 1.0
    var numberOfWaves: CGFloat = 5.0
    @IBInspectable var waveColor: UIColor = UIColor.white
    @IBInspectable var primaryWaveLineWidth: CGFloat = 3.0
    @IBInspectable var secondaryWaveLineWidth: CGFloat = 1.0
    @IBInspectable var idleAmplitude: CGFloat = 0.01
    @IBInspectable var frequency: CGFloat = 1.5
    @IBInspectable var density: CGFloat = 5.0
    @IBInspectable var phaseShift: CGFloat = -0.15
    
    func update(with level: CGFloat) {
        guard !level.isNaN, level.isFinite else { return }
        phase += phaseShift
        let newAmplitude = max(level, idleAmplitude)
        let currentAmplitude = amplitude
        
        var i = amplitude
        guard newAmplitude > amplitude else {

            for j in 0..<Int((amplitude - newAmplitude) * 10000) {
                amplitude = CGFloat(i)
                i = i - CGFloat(j)*0.0001
                setNeedsDisplay()
            }
            amplitude = newAmplitude
            setNeedsDisplay()
            return
        }


        for j in Int(currentAmplitude * 10000)..<Int(newAmplitude * 10000) {
            amplitude = i + CGFloat(j)*0.0001
            setNeedsDisplay()
        }
        amplitude = newAmplitude
        setNeedsDisplay()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.clear(bounds)
        
        backgroundColor?.set()
        context.fill(rect)
        
        for i in 0..<Int(numberOfWaves) {
            let strokeLineWidth = i == 0 ? primaryWaveLineWidth : secondaryWaveLineWidth
            context.setLineWidth(strokeLineWidth)
            
            let halfHeight = bounds.height / 2.0
            let width = bounds.width
            let mid = width / 2.0
            
            let maxAmplitude = halfHeight - strokeLineWidth * 2.0
            
            let progress: CGFloat = 1.0 - CGFloat(i) / numberOfWaves
            
            let normalizedAmplitude: CGFloat = (1.5 * progress - (2.0 / numberOfWaves)) * amplitude
            
            
            let multiplier = min(1.0, (progress / 3.0 * 2.0) + (1.0 / 3.0))
            waveColor.withAlphaComponent(multiplier * waveColor.cgColor.alpha).set()
            
            var x: CGFloat = 0
            while x < width + density {
                let scaling: CGFloat = -pow(1 / mid * (x - mid), 2.0) + 1
                    
                let y: CGFloat = scaling * maxAmplitude * normalizedAmplitude * sin(2 * CGFloat.pi * (x / width) * frequency + phase) + halfHeight
                
                if x == 0 {
                    context.move(to: CGPoint(x: x, y: y))
                } else {
                    context.addLine(to: CGPoint(x: x, y: y))
                }
                x += density
            }
            context.strokePath()
            
        }
    }
    
}
