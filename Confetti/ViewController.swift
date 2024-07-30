//
//  ViewController.swift
//  Confetti
//
//  Created by Scott Richards on 7/17/24.
//

import UIKit

extension Float {
    func toStringWithTwoDecimalPlaces() -> String {
        return String(format: "%.2f", self)
    }
    
    func toStringNoDecimal() -> String {
        return String(format: "%.0f", self)
    }
}

extension CGFloat {
    func toStringWithTwoDecimalPlaces() -> String {
        return String(format: "%.2f", self)
    }
    
    func toStringNoDecimal() -> String {
        return String(format: "%.0f", self)
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var stopButton: UIButton!
    private var emitter = CAEmitterLayer()
    @IBOutlet weak var velocityRangeSlider: UISlider!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var velocityRangeLabel: UILabel!
    @IBOutlet weak var scaleSlider: UISlider!
    @IBOutlet weak var scaleRangeSlider: UISlider!
    @IBOutlet weak var scaleLabel: UILabel!
    @IBOutlet weak var scaleRangeLabel: UILabel!
    @IBOutlet weak var birthRateLabel: UILabel!
    @IBOutlet weak var birthRateSlider: UISlider!
    let numberFormatter = NumberFormatter()
    let decimalFormatter = NumberFormatter()

    
    
    var velocity: Float = 240.0
    var velocityRange: Float = 100.0
    var scale: Float = 0.15
    var scaleRange: Float = 0.05
    var birthRate: Float = 12.0 // specifies the number of particles that are emitted per second
    var spin: CGFloat = 2.0   // Sets a base rotational speed of 2 radians per second
    var spinRange: CGFloat = 4.0 // Allows the rotational speed to vary randomly by up to ±4 radians per second, resulting in rotational speeds between -2 and 6 radians per second
    var lifetime: Float = 4.0 // determines how long each particle exists before it disappears. This parameter is crucial for defining the duration of the particle effect and how long the particles remain visible after being emitted.
    var lifetimeRange: Float = 1.5 // This adds some variability to the particle lifetimes, with a lifetime of 5 making some particles last between 3.5 to 6.5 seconds, which creates a more dynamic and natural effect.
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.minimumFractionDigits = 2
        decimalFormatter.maximumFractionDigits = 2
        scaleSlider.minimumValue = 0.0
        scaleSlider.maximumValue = 1.0
        scaleSlider.value = scale
        scaleRangeSlider.minimumValue = 0.0
        scaleRangeSlider.maximumValue = 1.0
        scaleRangeSlider.value = scaleRange
        birthRateSlider.value = birthRate
        updateLabels()
        // Do any additional setup after loading the view.
    }
 
    
    func updateLabels() {
        if let stringValue = numberFormatter.string(from: NSNumber(value: velocity)) {
            print("velocity = \(stringValue)")
            velocityLabel.text = stringValue
        }
        if let velocityRangeStr = numberFormatter.string(from: NSNumber(value: velocityRange)) {
            print("velocityRage = \(velocityRangeStr)")
            velocityRangeLabel.text = velocityRangeStr
        }
        if let scaleValue = decimalFormatter.string(from: NSNumber(value: scale)) {
            print("scale = \(scaleValue)")
            scaleLabel.text = scaleValue
        }
        if let scaleRangeValue = decimalFormatter.string(from: NSNumber(value: scaleRange)) {
            print("scaleRange = \(scaleRangeValue)")
            scaleRangeLabel.text = scaleRangeValue
        }
        birthRateLabel.text = birthRate.toStringNoDecimal()
    }
    
    func addConfettiEffect() {
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
//            cell.contents = UIImage(named: "Confetti")?.cgImage
            cell.contents = getRandomConfettiImage()
            
            cells.append(cell)
        }
        
        emitter.emitterCells = cells
        view.layer.addSublayer(emitter)
    }

    @IBAction func onCelebrate(_ sender: Any) {
        addConfettiEffect()
        stopButton.isHidden = false
    }
    
    @IBAction func onStop(_ sender: Any) {
        emitter.removeFromSuperlayer()
        stopButton.isHidden = true
    }
    
    @IBAction func onChangeVelocity(_ sender: Any) {
        let newValue = velocitySlider.value
        print("velocity = \(newValue)")
        velocity = newValue
        if let stringValue = numberFormatter.string(from: NSNumber(value: newValue)) {
            print("velocity = \(stringValue)")
            velocityLabel.text = stringValue
            updateEffect()
        }
    }

    @IBAction func onChangeVelocityRange(_ sender: Any) {
            let newValue = velocityRangeSlider.value
            print("velocityRange = \(newValue)")
            velocityRange = newValue
            if let stringValue = numberFormatter.string(from: NSNumber(value: newValue)) {
                print("velocityRange = \(stringValue)")
                velocityRangeLabel.text = stringValue
                updateEffect()
            }
    }

    func updateEffect() {
        emitter.removeFromSuperlayer()
        emitter = CAEmitterLayer()
        addConfettiEffect()
    }
    

    @IBAction func OnChangeScaleValue(_ sender: Any) {
        scale = scaleSlider.value
        let stringValue = scale.toStringWithTwoDecimalPlaces()
        scaleLabel.text = stringValue
        updateLabels()
        updateEffect()
    }
    
    @IBAction func onChangeScaleRangeValue(_ sender: Any) {
        scaleRange = scaleRangeSlider.value
        let stringValue = scaleRange.toStringWithTwoDecimalPlaces()
        scaleRangeLabel.text = stringValue
        updateLabels()
        updateEffect()
    }
    
    @IBAction func onBirthRateChangeValue(_ sender: UISlider) {
        birthRate = Float(sender.value)
        let stringValue = birthRate.toStringNoDecimal()
        birthRateLabel.text = stringValue
        updateLabels()
        updateEffect()
    }
    
}

