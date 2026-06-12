import SwiftUI

public enum DSAlertStyle {
  case success
  case warning
  case error
  case info
  
  var icon: DSIcon {
    switch self {
    case .success: return .checkCircle
    case .warning: return .warning
    case .error: return .error
    case .info: return .info
    }
  }
  
  var tintColor: Color {
    switch self {
    case .success: return DSColor.success
    case .warning: return DSColor.warning
    case .error: return DSColor.error
    case .info: return DSColor.info
    }
  }
  
  var backgroundColor: Color {
    tintColor.opacity(0.1)
  }
}

public struct DSAlert: View {
  let style: DSAlertStyle
  let title: String
  let description: String?
  let primaryAction: (title: String, action: () -> Void)?
  let onDismiss: (() -> Void)?
  
  public init(
    style: DSAlertStyle,
    title: String,
    description: String? = nil,
    primaryAction: (title: String, action: () -> Void)? = nil,
    onDismiss: (() -> Void)? = nil
  ) {
    self.style = style
    self.title = title
    self.description = description
    self.primaryAction = primaryAction
    self.onDismiss = onDismiss
  }
  
  public var body: some View {
    HStack(alignment: description == nil ? .center : .top, spacing: DSSpacing.md) {
      style.icon.image
        .foregroundColor(style.tintColor)
        .font(.system(size: 20))
        .padding(.top, 2)
      
      VStack(alignment: .leading, spacing: DSSpacing.xs) {
        Text(title)
          .dsFont(.subheadline, weight: .bold)
          .foregroundColor(DSColor.textStrong)
        
        if let description = description {
          Text(description)
            .dsFont(.caption)
            .foregroundColor(DSColor.textNeutral)
        }
        
        if let action = primaryAction {
          Button(action: action.action) {
            Text(action.title)
              .dsFont(.caption2, weight: .bold)
              .foregroundColor(style.tintColor)
              .padding(.vertical, 6)
              .padding(.horizontal, 10)
              .background(style.tintColor.opacity(0.12))
              .cornerRadius(6)
          }
          .padding(.top, 4)
        }
      }
      
      Spacer()
      
      if let dismiss = onDismiss {
        Button(action: dismiss) {
          DSIcon.close.image
            .foregroundColor(DSColor.textMuted)
            .imageScale(.medium)
        }
      }
    }
    .padding(DSSpacing.lg)
    .background(style.backgroundColor)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(style.tintColor.opacity(0.2), lineWidth: 1.0)
    )
  }
}
