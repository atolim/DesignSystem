import SwiftUI

public enum DSBadgeVariant {
  case solid
  case subtle
  case outline
}

public enum DSBadgeColor {
  case primary
  case secondary
  case neutral
  case success
  case warning
  case error
  case info
}

public enum DSBadgeSize {
  case small
  case medium
  
  var verticalPadding: CGFloat {
    switch self {
    case .small: return 2
    case .medium: return 4
    }
  }
  
  var horizontalPadding: CGFloat {
    switch self {
    case .small: return 6
    case .medium: return 8
    }
  }
  
  var typographyStyle: DSTypographyStyle {
    switch self {
    case .small: return .caption2
    case .medium: return .caption
    }
  }
}

public struct DSBadge: View {
  let text: String
  let icon: DSIcon?
  let variant: DSBadgeVariant
  let color: DSBadgeColor
  let customColor: Color?
  let size: DSBadgeSize
  
  public init(
    _ text: String,
    icon: DSIcon? = nil,
    variant: DSBadgeVariant = .subtle,
    color: DSBadgeColor = .primary,
    size: DSBadgeSize = .medium
  ) {
    self.text = text
    self.icon = icon
    self.variant = variant
    self.color = color
    self.customColor = nil
    self.size = size
  }
  
  public init(
    _ text: String,
    icon: DSIcon? = nil,
    variant: DSBadgeVariant = .subtle,
    customColor: Color,
    size: DSBadgeSize = .medium
  ) {
    self.text = text
    self.icon = icon
    self.variant = variant
    self.color = .primary
    self.customColor = customColor
    self.size = size
  }
  
  public var body: some View {
    HStack(spacing: 4) {
      if let icon = icon {
        icon.image
          .font(.system(size: size == .small ? 10 : 12))
      }
      
      Text(text)
        .dsFont(size.typographyStyle, weight: .semibold)
    }
    .padding(.vertical, size.verticalPadding)
    .padding(.horizontal, size.horizontalPadding)
    .background(backgroundColor)
    .foregroundColor(textColor)
    .overlay(borderView)
    .clipShape(Capsule())
  }
  
  @ViewBuilder
  private var borderView: some View {
    if variant == .outline {
      Capsule()
        .stroke(borderColor, lineWidth: 1.0)
    }
  }
  
  private var semanticColor: Color {
    if let customColor = customColor {
      return customColor
    }
    switch color {
    case .primary: return DSColor.primary
    case .secondary: return DSColor.secondary
    case .neutral: return DSColor.textNeutral
    case .success: return DSColor.success
    case .warning: return DSColor.warning
    case .error: return DSColor.error
    case .info: return DSColor.info
    }
  }
  
  private var backgroundColor: Color {
    switch variant {
    case .solid:
      return semanticColor
    case .subtle:
      return semanticColor.opacity(0.12)
    case .outline:
      return Color.clear
    }
  }
  
  private var textColor: Color {
    switch variant {
    case .solid:
      if customColor != nil {
        return .white
      }
      if color == .neutral {
        return DSColor.backgroundDefault
      }
      return .white
    case .subtle, .outline:
      return semanticColor
    }
  }
  
  private var borderColor: Color {
    semanticColor
  }
}
