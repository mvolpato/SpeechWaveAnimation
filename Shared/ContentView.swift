//  ContentView
//  Shared
//
//  Created by Michele Volpato on 28/01/2021.
//  
//

import SwiftUI

struct ContentView: View {
    @State private var amplitude: CGFloat = 0.8
    @State private var phase: CGFloat = 0.0
    @State private var change: CGFloat = 0.1
    
    var body: some View {
        VStack {
            Spacer()
            MultiWave(amplitude: amplitude, color: .green, phase: phase)
                .frame(height: 500)
                .onAppear {
                    withAnimation(Animation.linear(duration: 0.1)
                                    .repeatForever(autoreverses: false)
                    ) {
                        self.amplitude = _nextAmplitude()
                        self.phase -= 1.5
                    }
                }
                .onAnimationCompleted(for: amplitude) {
                    withAnimation(.linear(duration: 0.1)){
                        self.amplitude = _nextAmplitude()
                        self.phase -= 1.5
                    }
                }
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    private func _nextAmplitude() -> CGFloat {
        // If the amplitude is too low or too high, cap it and go in the other direction.
        if self.amplitude <= 0.01 {
            self.change = 0.1
            return 0.02
        } else if self.amplitude > 0.9 {
            self.change = -0.1
            return 0.9
        }
        
        // Simply set the amplitude to whatever you need and the view will update itself.
        let newAmplitude = self.amplitude + (self.change * CGFloat.random(in: 0.3...0.8))
        return max(0.01, newAmplitude)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
