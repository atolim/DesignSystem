import SwiftUI

public enum DSButtonVariant {
  case solid
  case outline
  case text
  case gradient
}

public enum DSButtonColor {
  case primary
  case secondary
  case neutral
  case error
  case success
}

public enum DSButtonSize {
  case small
  case medium
  case large
  
  var verticalPadding: CGFloat {
    switch self {
    case .small: return 8
    case .medium: return 12
    case .large: return 16
    }
  }
  
  var horizontalPadding: CGFloat {
    switch self {
    case .small: return 12
    case .medium: return 18
    case .large: return 24
    }
  }
  
  var typographyStyle: DSTypographyStyle {
    switch self {
    case .small: return .caption
    case .medium: return .subheadline
    case .large: return .body
    }
  }
  
  var cornerRadius: CGFloat {
    switch self {
    case .small: return 6
    case .medium: return 8
    case .large: return 10
    }
  }
}

public struct DSButtonStyle: ButtonStyle {
  let variant: DSButtonVariant
  let color: DSButtonColor
  let size: DSButtonSize
  let isLoading: Bool
  
  @Environment(\.isEnabled) private var isEnabled
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .dsFont(size.typographyStyle, weight: .semibold)
      .padding(.vertical, size.verticalPadding)
      .padding(.horizontal, size.horizontalPadding)
      .background(backgroundView(isPressed: configuration.isPressed))
      .foregroundColor(textColor(isPressed: configuration.isPressed))
      .overlay(borderView)
      .cornerRadius(size.cornerRadius)
      .scaleEffect(configuration.isPressed && isEnabled && !isLoading ? 0.97 : 1.0)
      .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
  }
  
  @ViewBuilder
  private func backgroundView(isPressed: Bool) -> some View {
    if !isEnabled {
      if variant == .solid || variant == .gradient {
        DSColor.backgroundSecondary
      } else {
        Color.clear
      }
    } else {
      switch variant {
      case .solid:
        solidColor.opacity(isPressed ? 0.85 : 1.0)
      case .outline, .text:
        isPressed ? solidColor.opacity(0.1) : Color.clear
      case .gradient:
        LinearGradient(
          gradient: Gradient(colors: gradientColors),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .opacity(isPressed ? 0.85 : 1.0)
      }
    }
  }
  
  @ViewBuilder
  private var borderView: some View {
    if variant == .outline {
      RoundedRectangle(cornerRadius: size.cornerRadius)
        .stroke(borderColor, lineWidth: 1.5)
    }
  }
  
  private var solidColor: Color {
    switch color {
    case .primary: return DSColor.primary
    case .secondary: return DSColor.secondary
    case .neutral: return DSColor.textStrong
    case .error: return DSColor.error
    case .success: return DSColor.success
    }
  }
  
  private var gradientColors: [Color] {
    switch color {
    case .primary:
      return [DSColor.primary, DSColor.primary.opacity(0.8)]
    case .secondary:
      return [DSColor.secondary, DSColor.secondary.opacity(0.8)]
    case .neutral:
      return [DSColor.textStrong, DSColor.textNeutral]
    case .error:
      return [DSColor.error, DSColor.error.opacity(0.8)]
    case .success:
      return [DSColor.success, DSColor.success.opacity(0.8)]
    }
  }
  
  private func textColor(isPressed: Bool) -> Color {
    if !isEnabled {
      return DSColor.textMuted
    }
    
    switch variant {
    case .solid, .gradient:
      if color == .neutral {
        return DSColor.backgroundDefault
      }
      return .white
    case .outline, .text:
      return solidColor
    }
  }
  
  private var borderColor: Color {
    if !isEnabled {
      return DSColor.border
    }
    return solidColor
  }
}

// Convenient helper component
public struct DSButton: View {
  let title: String
  let icon: DSIcon?
  let iconPosition: IconPosition
  let variant: DSButtonVariant
  let color: DSButtonColor
  let size: DSButtonSize
  let isLoading: Bool
  let action: () -> Void
  
  public enum IconPosition {
    case leading
    case trailing
  }
  
  public init(
    _ title: String,
    icon: DSIcon? = nil,
    iconPosition: IconPosition = .leading,
    variant: DSButtonVariant = .solid,
    color: DSButtonColor = .primary,
    size: DSButtonSize = .medium,
    isLoading: Bool = false,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.icon = icon
    self.iconPosition = iconPosition
    self.variant = variant
    self.color = color
    self.size = size
    self.isLoading = isLoading
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      HStack(spacing: DSSpacing.xs) {
        if isLoading {
          ProgressView()
            .controlSize(.small)
            .tint(textColor)
            .padding(.trailing, 2)
        } else if let icon = icon, iconPosition == .leading {
          icon.image
            .imageScale(.medium)
        }
        
        Text(title)
        
        if !isLoading, let icon = icon, iconPosition == .trailing {
          icon.image
            .imageScale(.medium)
        }
      }
    }
    .buttonStyle(DSButtonStyle(variant: variant, color: color, size: size, isLoading: isLoading))
    .disabled(isLoading)
  }
  
  private var textColor: Color {
    switch variant {
    case .solid, .gradient:
      if color == .neutral {
        return DSColor.backgroundDefault
      }
      return .white
    case .outline, .text:
      switch color {
      case .primary: return DSColor.primary
      case .secondary: return DSColor.secondary
      case .neutral: return DSColor.textStrong
      case .error: return DSColor.error
      case .success: return DSColor.success
      }
    }
  }
}
