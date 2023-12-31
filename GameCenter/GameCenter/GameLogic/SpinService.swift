//
//  CÓDIGO PROTEGIDO PELA GPL 2.0
//  ORIGINALMENTE CRIADO POR PEDRO MEZACASA MULLER, FELIPPO STÉDILE E THIAGO DIAS PARISOTTO.
//

import Foundation
import CoreLocation
import Combine

class CompassHeading: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var bugged: Bool = false
    @Published var numberOfSpins: Int {
        didSet {
            didChangeSpin = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.didChangeSpin = false
            }
        }
    }
    
    @Published var didChangeSpin: Bool = false

    var trueHeading: Double = 0
    var offSet: Double = 0
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    var lastDirection: DirectionGoing = .right
    var degrees: Double = .zero {
        didSet {
            objectWillChange.send()
        }
    }
    
    var leftStack: Double = 0 {
        didSet {
            if leftStack >= 360 {
                leftStack = 0
                rightStack = 0
                numberOfSpins += 1
            }
            
            if leftStack >= 1 {
                rightStack = max(rightStack - leftStack, 0)
            }
            
            biggestStack = max(leftStack, rightStack) + (Double(numberOfSpins) * 360)
        }
    }
    
    var rightStack: Double = 0 {
        didSet {
            if rightStack >= 360 {
                numberOfSpins += 1
                rightStack = 0
                leftStack = 0
            }
            
            if rightStack >= 1 {
                leftStack = max(leftStack - rightStack, 0)
            }
            
            biggestStack = max(leftStack, rightStack) + (Double(numberOfSpins) * 360)
        }
    }
    
    @Published var biggestStack: Double = 0
    
    private let locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        self.numberOfSpins = 0
        super.init()
        
        self.locationManager.delegate = self
        self.setup()
    }
    
    private func setup() {
        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingHeading()
        }
    }
    
    var maior: Double = 0
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        trueHeading = newHeading.trueHeading
        
        if degrees == 0 {
            self.degrees = newHeading.trueHeading
            self.offSet = newHeading.trueHeading
            return
        }
        
        if abs(newHeading.trueHeading - degrees) > 200 {
            self.degrees = newHeading.trueHeading
//            bugged = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.bugged = false
//            }
            return
        }
        
        // TODO: Multiplayer send this delta
        
        
        
        // base case
        if newHeading.trueHeading > self.degrees {
            rightStack += abs(newHeading.trueHeading - self.degrees)
            
        } else {
            leftStack += abs(newHeading.trueHeading - self.degrees)
            
        }
        
        self.degrees = newHeading.trueHeading
    }
}

// MARK: Intent Functions
extension CompassHeading {
    func resetOffSet() {
        self.degrees = .zero
        self.trueHeading = .zero
        self.offSet = .zero
        self.leftStack = .zero
        self.rightStack = .zero
    }
}


enum DirectionGoing {
    case right, left
}
