import SwiftUI

public struct DSTooltipView: View {
  let text: String
  
  public var body: some View {
    VStack(spacing: 0) {
      Text(text)
        .dsFont(.caption)
        .foregroundColor(DSColor.backgroundDefault)
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(DSColor.textStrong)
        .cornerRadius(6)
        .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
      
      TooltipArrowShape()
        .fill(DSColor.textStrong)
        .frame(width: 12, height: 6)
    }
  }
}

struct TooltipArrowShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    path.closeSubpath()
    return path
  }
}

public struct DSTooltipModifier: ViewModifier {
  let text: String
  @Binding var isPresented: Bool
  
  public func body(content: Content) -> some View {
    content
      .overlay(
        GeometryReader { geometry in
          if isPresented {
            VStack {
              DSTooltipView(text: text)
                .fixedSize()
            }
            .frame(width: geometry.size.width)
            .offset(y: -42)
            .transition(.scale(scale: 0.9, anchor: .bottom).combined(with: .opacity))
            .zIndex(999)
          }
        }
      )
      .animation(.spring(response: 0.2, dampingFraction: 0.8), value: isPresented)
  }
}

extension View {
  /// Presents a custom tooltip balloon above the view.
  public func dsTooltip(text: String, isPresented: Binding<Bool>) -> some View {
    self.modifier(DSTooltipModifier(text: text, isPresented: isPresented))
  }
}
