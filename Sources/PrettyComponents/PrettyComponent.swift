//
//  File.swift
//  
//
//  Created by Geovanni Fuentes on 2022-12-30.
//

import Foundation
import SwiftUI

public struct PrettyComponent: View {
    @Namespace private var animation
    @State private var isAnimating = false
    
    public var text: String = ""
    public var color: Color = .clear
    
    public init(text: String) {
        self.text = text
    }
    
    private var frameHeight: Double {
        isAnimating ? 100 : 44
    }
    
    private var frameWidth: Double {
        isAnimating ? 100 : .infinity
    }
    
    private var cornerRadius: CGFloat {
        isAnimating ? 50 : 0
    }
    
    public var body: some View {
        HStack {
            Group {
                if isAnimating {
                    Text("...")
                        .matchedGeometryEffect(id: "AnimatedText", in: animation)
                } else {
                    Text(text)
                        .matchedGeometryEffect(id: "AnimatedText", in: animation)
                }
            }
            .padding()
        }
        .frame(minWidth: 0, maxWidth: frameWidth, minHeight: 0, maxHeight: frameHeight)
        .background(color)
        .cornerRadius(cornerRadius)
        .animation(.easeIn, value: isAnimating)
        .onTapGesture {
            withAnimation {
                isAnimating.toggle()
            }
        }
    }
}

extension PrettyComponent {
    func addBackgroundColor(_ color: Color) -> Self {
        var copySelf = self
        copySelf.color = color
        return copySelf
    }
}



struct PrettyComponent_Previews: PreviewProvider {
    static var previews: some View {
        PrettyComponent(text: "Component")
            .addBackgroundColor(Color.red)
    }
}
