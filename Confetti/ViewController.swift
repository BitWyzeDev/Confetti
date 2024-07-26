//
//  ViewController.swift
//  Confetti
//
//  Created by Scott Richards on 7/17/24.
//

import UIKit

class ViewController: UIViewController {
    let pink = UIColor(hexString: "#FD82B0")!
    let purple = UIColor(hexString: "#B82EB7")!
    let green = UIColor(hexString: "#01AFD2")!
    let blue = UIColor(hexString: "#89E2A4")!
    let yellow = UIColor(hexString: "#F6DC99")!
    let orange = UIColor(hexString: "#FF9933")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    
    func addConfettiEffect() {
        let emitter = CAEmitterLayer()
        emitter.frame = view.bounds
        
        // Configure the emitter
        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: view.bounds.width / 2, y: 0)
        emitter.emitterSize = CGSize(width: view.bounds.width, height: 1)


        // Create the confetti cells
        let colors: [UIColor] = [pink, purple, green, blue, yellow, orange]
        var cells: [CAEmitterCell] = []
        
        for color in colors {
            let cell = CAEmitterCell()
            cell.birthRate = 5
            cell.lifetime = 6.0
            cell.velocity = 100
            cell.velocityRange = 50
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spin = 3.5
            cell.spinRange = 1.0
            cell.scale = 0.05
            cell.scaleRange = 0.02
            cell.color = color.cgColor
            cell.contents = UIImage(named: "Confetti")?.cgImage
            
            cells.append(cell)
        }
        
        emitter.emitterCells = cells
        view.layer.addSublayer(emitter)
    }

    @IBAction func onCelebrate(_ sender: Any) {
        addConfettiEffect()
    }
    
}

