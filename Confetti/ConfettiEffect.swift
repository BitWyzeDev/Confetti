//
//  ConfettiEffect.swift
//  Confetti
//
//  Created by Scott Richards on 7/30/24.
//

import Foundation
import UIKit

class ConfettiEffect {
    var velocity: Float = 240.0
    var velocityRange: Float = 100.0
    var scale: Float = 0.05
    var scaleRange: Float = 0.05
    var birthRate: Float = 12.0 // specifies the number of particles that are emitted per second
    var spin: CGFloat = 2.0   // Sets a base rotational speed of 2 radians per second
    var spinRange: CGFloat = 4.0 // Allows the rotational speed to vary randomly by up to ±4 radians per second, resulting in rotational speeds between -2 and 6 radians per second
    var lifetime: Float = 4.0 // determines how long each particle exists before it disappears. This parameter is crucial for defining the duration of the particle effect and how long the particles remain visible after being emitted.
    var lifetimeRange: Float = 1.5 // This adds some variability to the particle lifetimes, with a lifetime of 5 making some particles last between 3.5 to 6.5 seconds, which creates a more dynamic and natural effect.

    private var emitter = CAEmitterLayer()
    
    let pink = UIColor(hexString: "#FD82B0")!
    let purple = UIColor(hexString: "#B82EB7")!
    let green = UIColor(hexString: "#01AFD2")!
    let blue = UIColor(hexString: "#89E2A4")!
    let yellow = UIColor(hexString: "#F6DC99")!
    let orange = UIColor(hexString: "#FF9933")!
    
    let confettiImages = ["SquareConfetti", "CurledConfetti", "RectangleConfetti"]
    
    func getRandomConfettiImage() -> CGImage? {
        let randomIndex = Int.random(in: 0...(confettiImages.count - 1))
        let imageName = confettiImages[randomIndex]
        print("random confetti image: \(imageName)")
        return UIImage(named: imageName)?.cgImage
    }
    
    func addConfettiEffect(toView: UIView) {
        emitter = CAEmitterLayer()
        emitter.frame = toView.bounds
        
        // Configure the emitter
        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: toView.bounds.width / 2, y: 0)
        emitter.emitterSize = CGSize(width: toView.bounds.width, height: 1)


        // Create the confetti cells
        let colors: [UIColor] = [pink, purple, green, blue, yellow, orange]
        var cells: [CAEmitterCell] = []
        
        for color in colors {
            let cell = CAEmitterCell()
            cell.birthRate = birthRate
            cell.lifetime = lifetime
            cell.lifetimeRange = lifetimeRange
            cell.velocity = CGFloat(velocity)
            cell.velocityRange = CGFloat(velocityRange)
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spin = spin
            cell.spinRange = spinRange
            cell.scale = CGFloat(scale)
            cell.scaleRange = CGFloat(scaleRange)
            cell.color = color.cgColor
            cell.contents = UIImage(named: "Confetti")?.cgImage
            
            cells.append(cell)
        }
        
        emitter.emitterCells = cells
        toView.layer.addSublayer(emitter)
    }
    
    func removeConfetti() {
        emitter.removeFromSuperlayer()
    }
    
}
