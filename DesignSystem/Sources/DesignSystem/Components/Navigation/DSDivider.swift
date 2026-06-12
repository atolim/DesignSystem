import SwiftUI

public enum DSDividerOrientation {
  case horizontal
  case vertical
}

public struct DSDivider: View {
  let orientation: DSDividerOrientation
  let thickness: CGFloat
  let color: Color
  
  public init(
    orientation: DSDividerOrientation = .horizontal,
    thickness: CGFloat = 1.0,
    color: Color = DSColor.border
  ) {
    self.orientation = orientation
    self.thickness = thickness
    self.color = color
  }
  
  public var body: some View {
    switch orientation {
    case .horizontal:
      Rectangle()
        .fill(color)
        .frame(height: thickness)
    case .vertical:
      Rectangle()
        .fill(color)
        .frame(width: thickness)
    }
  }
}
