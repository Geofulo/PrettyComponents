import SwiftUI

public struct PrettyComponents {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    public struct PrettyButton {
        
    }
}

struct PrettyComponent: View {
    @Namespace private var animation
    @State private var isAnimating = false
    
    public var text: String
    public var color: Color = .clear
    
    init(text: String) {
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
    
    var body: some View {
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
