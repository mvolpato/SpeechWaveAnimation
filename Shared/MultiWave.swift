//  MultiWave
//  WaveAnimation
//
//  Created by Michele Volpato on 28/01/2021.
//  
//

import SwiftUI

struct MultiWave: View {
    var amplitude: CGFloat = 1.0
    var color: Color = Color.green
    var phase: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            ForEach((0...4), id: \.self) { count in
                singleWave(count: count)
            }
        }
    }
    
    func singleWave(count: Int) -> some View {
        let progress = 1.0 - CGFloat(count) / CGFloat(5)
        let normedAmplitude = (1.5 * progress - 0.8) * self.amplitude
        let alphaComponent = min(1.0, (progress/3.0*2.0) + (1.0/3.0))

        return Wave(phase: phase, normedAmplitude: normedAmplitude)
            .stroke(color.opacity(Double(alphaComponent)), lineWidth: 1.5 / CGFloat(count + 1))
    }
    
}

struct MultiWave_Previews: PreviewProvider {
    static var previews: some View {
        MultiWave()
    }
}
