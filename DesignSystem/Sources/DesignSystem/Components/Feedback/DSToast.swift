import SwiftUI

public enum DSToastStyle {
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
  
  var color: Color {
    switch self {
    case .success: return DSColor.success
    case .warning: return DSColor.warning
    case .error: return DSColor.error
    case .info: return DSColor.info
    }
  }
}

public struct DSToastItem: Identifiable, Equatable {
  public let id = UUID()
  public let message: String
  public let style: DSToastStyle
  public let duration: Double
  
  public init(message: String, style: DSToastStyle = .info, duration: Double = 3.0) {
    self.message = message
    self.style = style
    self.duration = duration
  }
}

public struct DSToastView: View {
  let item: DSToastItem
  let onDismiss: () -> Void
  
  @State private var offset: CGFloat = 0
  
  public var body: some View {
    HStack(spacing: DSSpacing.sm) {
      item.style.icon.image
        .foregroundColor(item.style.color)
        .imageScale(.medium)
      
      Text(item.message)
        .dsFont(.subheadline, weight: .medium)
        .foregroundColor(DSColor.textStrong)
      
      Spacer()
      
      Button(action: onDismiss) {
        DSIcon.close.image
          .foregroundColor(DSColor.textMuted)
          .imageScale(.small)
      }
    }
    .padding(.vertical, 14)
    .padding(.horizontal, DSSpacing.lg)
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(DSColor.backgroundDefault)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    )
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(DSColor.border, lineWidth: 1.0)
    )
    .offset(y: offset)
    .gesture(
      DragGesture()
        .onChanged { gesture in
          if gesture.translation.height < 0 {
            offset = gesture.translation.height
          }
        }
        .onEnded { gesture in
          if gesture.translation.height < -20 {
            onDismiss()
          } else {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
              offset = 0
            }
          }
        }
    )
    .padding(.horizontal, DSSpacing.lg)
  }
}

public struct DSToastModifier: ViewModifier {
  @Binding var item: DSToastItem?
  
  public func body(content: Content) -> some View {
    ZStack(alignment: .top) {
      content
      
      if let currentItem = item {
        DSToastView(item: currentItem) {
          withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
            item = nil
          }
        }
        .transition(.move(edge: .top).combined(with: .opacity))
        .zIndex(999)
        .task {
          try? await Task.sleep(nanoseconds: UInt64(currentItem.duration * 1_000_000_000))
          if item?.id == currentItem.id {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
              item = nil
            }
          }
        }
        .padding(.top, 16)
      }
    }
  }
}

extension View {
  /// Displays a non-intrusive floating toast alert at the top of the view hierarchy.
  public func dsToast(_ item: Binding<DSToastItem?>) -> some View {
    self.modifier(DSToastModifier(item: item))
  }
}
