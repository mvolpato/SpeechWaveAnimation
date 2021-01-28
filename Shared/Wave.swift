//  Wave
//  WaveAnimation
//
//  Created by Michele Volpato on 28/01/2021.
//  
//

import SwiftUI

struct Wave: Shape {
    /// The frequency of the sinus wave. The higher the value, the more sinus wave peaks you will have.
    /// Default: 1.5
    var frequency: CGFloat = 1.5

    /// The lines are joined stepwise, the more dense you draw, the more CPU power is used.
    /// Default: 1
    var density: CGFloat = 1.0

    /// The phase shift that will be applied
    var phase: CGFloat
    
    /// The normed ampllitude of this wave, between 0 and 1.
    var normedAmplitude: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let maxAmplitude = rect.height / 2.0
        let mid = rect.width / 2
        
        for x in Swift.stride(from:0, to: rect.width + self.density, by: self.density) {
            // Parabolic scaling
            let scaling = -pow(1 / mid * (x - mid), 2) + 1
            let y = scaling * maxAmplitude * normedAmplitude * sin(CGFloat(2 * Double.pi) * self.frequency * (x / rect.width)  + self.phase) + rect.height / 2
            if x == 0 {
                path.move(to: CGPoint(x:x, y:y))
            } else {
                path.addLine(to: CGPoint(x:x, y:y))
            }
        }
        
        return path
    }
    
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(normedAmplitude, phase)
        }
        
        set {
            self.normedAmplitude = newValue.first
            self.phase = newValue.second
        }
    }
}
