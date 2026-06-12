import SwiftUI

public enum DSTextFieldState: Equatable {
  case normal
  case success
  case error(String)
}

public struct DSTextField: View {
  let label: String?
  @Binding var text: String
  let placeholder: String
  let leadingIcon: DSIcon?
  let isSecure: Bool
  let state: DSTextFieldState
  let hasBorder: Bool
  
  @FocusState private var isFocused: Bool
  @State private var isSecureTextEntry: Bool
  
  public init(
    _ label: String? = nil,
    text: Binding<String>,
    placeholder: String = "",
    leadingIcon: DSIcon? = nil,
    isSecure: Bool = false,
    state: DSTextFieldState = .normal,
    hasBorder: Bool = true
  ) {
    self.label = label
    self._text = text
    self.placeholder = placeholder
    self.leadingIcon = leadingIcon
    self.isSecure = isSecure
    self.state = state
    self.hasBorder = hasBorder
    self._isSecureTextEntry = State(initialValue: isSecure)
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: DSSpacing.xs) {
      if let label = label, !label.isEmpty {
        HStack(spacing: 0){
          Text(label)
            .dsFont(.caption)
            .foregroundColor(labelColor)
          Spacer()
        }
      }
      
      HStack(spacing: DSSpacing.sm) {
        if let leadingIcon = leadingIcon {
          leadingIcon.image
            .foregroundColor(iconColor)
        }
        
        Group {
          if isSecure && isSecureTextEntry {
            SecureField("", text: $text)
          } else {
            TextField("", text: $text)
          }
        }
        .placeholder(when: shouldShowPlaceholder) {
          Text(placeholder)
            .foregroundColor(DSColor.textMuted)
            .dsFont(.body)
        }
        .focused($isFocused)
        .dsFont(.body)
        .foregroundColor(DSColor.textStrong)
        
        // Clear button
        if !text.isEmpty && isFocused && !isSecure {
          Button(action: { text = "" }) {
            DSIcon.close.image
              .foregroundColor(DSColor.textMuted)
              .imageScale(.small)
          }
        }
        
        // Eye toggle for secure text
        if isSecure {
          Button(action: { isSecureTextEntry.toggle() }) {
            Image(systemName: isSecureTextEntry ? "eye.slash" : "eye")
              .foregroundColor(DSColor.textMuted)
              .imageScale(.medium)
          }
        }
      }
      .padding(.vertical, 14)
      .padding(.horizontal, DSSpacing.md)
      .background(hasBorder ? DSColor.backgroundDefault : Color.clear)
      .overlay(
        Group {
          if hasBorder {
            RoundedRectangle(cornerRadius: 8)
              .stroke(borderColor, lineWidth: isFocused ? 2 : 1)
          }
        }
      )
      
      // Feedback message (for error/success)
      if case .error(let message) = state {
        Text(message)
          .dsFont(.caption)
          .foregroundColor(DSColor.error)
          .transition(.opacity)
      }
    }
    .animation(.easeInOut(duration: 0.15), value: state)
  }
  
  private var hasLabel: Bool {
    if let label = label, !label.isEmpty {
      return true
    }
    return false
  }
  
  private var shouldShowPlaceholder: Bool {
    text.isEmpty
  }
  
  private var shouldFloat: Bool {
    isFocused || !text.isEmpty
  }
  
  private var borderColor: Color {
    if isFocused {
      switch state {
      case .normal: return DSColor.primary
      case .success: return DSColor.success
      case .error: return DSColor.error
      }
    } else {
      switch state {
      case .normal: return DSColor.border
      case .success: return DSColor.success
      case .error: return DSColor.error
      }
    }
  }
  
  private var labelColor: Color {
    if isFocused {
      switch state {
      case .normal: return DSColor.primary
      case .success: return DSColor.success
      case .error: return DSColor.error
      }
    } else {
      return DSColor.textNeutral
    }
  }
  
  private var iconColor: Color {
    isFocused ? DSColor.primary : DSColor.textMuted
  }
}

// Helper view extension to support custom placeholder styling
extension View {
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content
  ) -> some View {
    ZStack(alignment: alignment) {
      placeholder().opacity(shouldShow ? 1 : 0)
      self
    }
  }
}
