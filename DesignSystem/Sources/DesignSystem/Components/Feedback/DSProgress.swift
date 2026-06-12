import SwiftUI

// MARK: - Circular Spinner Loader
public struct DSSpinner: View {
  let size: CGFloat
  let strokeWidth: CGFloat
  let color: Color
  
  @State private var isAnimating = false
  
  public init(size: CGFloat = 32, strokeWidth: CGFloat = 3, color: Color = DSColor.primary) {
    self.size = size
    self.strokeWidth = strokeWidth
    self.color = color
  }
  
  public var body: some View {
    Circle()
      .trim(from: 0.0, to: 0.7)
      .stroke(color, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
      .frame(width: size, height: size)
      .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
      .onAppear {
        withAnimation(
          .linear(duration: 0.8)
          .repeatForever(autoreverses: false)
        ) {
          isAnimating = true
        }
      }
  }
}

// MARK: - Horizontal Progress Bar
public struct DSProgressBar: View {
  let value: Double // Range 0.0 to 1.0
  let height: CGFloat
  let color: Color
  
  public init(value: Double, height: CGFloat = 6, color: Color = DSColor.primary) {
    self.value = max(0.0, min(1.0, value))
    self.height = height
    self.color = color
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        // Track Background
        RoundedRectangle(cornerRadius: height / 2)
          .fill(DSColor.backgroundSecondary)
          .frame(height: height)
        
        // Progress Fill
        RoundedRectangle(cornerRadius: height / 2)
          .fill(color)
          .frame(width: geometry.size.width * CGFloat(value), height: height)
          .animation(.spring(response: 0.35, dampingFraction: 0.8), value: value)
      }
    }
    .frame(height: height)
  }
}
