import SwiftUI

public struct DSListRow<Leading: View, Trailing: View>: View {
  let title: String
  let subtitle: String?
  let leading: (() -> Leading)?
  let trailing: (() -> Trailing)?
  let action: (() -> Void)?
  
  public init(
    title: String,
    subtitle: String? = nil,
    leading: (() -> Leading)? = nil,
    trailing: (() -> Trailing)? = nil,
    action: (() -> Void)? = nil
  ) {
    self.title = title
    self.subtitle = subtitle
    self.leading = leading
    self.trailing = trailing
    self.action = action
  }
  
  public var body: some View {
    let content = HStack(spacing: DSSpacing.md) {
      if let leading = leading {
        leading()
      }
      
      VStack(alignment: .leading, spacing: 2) {
        Text(title)
          .dsFont(.body, weight: .semibold)
          .foregroundColor(DSColor.textStrong)
        
        if let subtitle = subtitle {
          Text(subtitle)
            .dsFont(.caption)
            .foregroundColor(DSColor.textMuted)
        }
      }
      
      Spacer()
      
      if let trailing = trailing {
        trailing()
      } else if action != nil {
        DSIcon.chevronRight.image
          .foregroundColor(DSColor.textMuted)
          .imageScale(.small)
      }
    }
    .padding(.vertical, 14)
    .padding(.horizontal, DSSpacing.lg)
    .background(DSColor.backgroundDefault)
    
    if let action = action {
      Button(action: action) {
        content
      }
      .buttonStyle(PlainButtonStyle())
    } else {
      content
    }
  }
}

extension DSListRow where Trailing == EmptyView {
  public init(
    title: String,
    subtitle: String? = nil,
    leading: (() -> Leading)? = nil,
    action: (() -> Void)? = nil
  ) {
    self.init(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: nil,
      action: action
    )
  }
}

extension DSListRow where Leading == EmptyView {
  public init(
    title: String,
    subtitle: String? = nil,
    trailing: (() -> Trailing)? = nil,
    action: (() -> Void)? = nil
  ) {
    self.init(
      title: title,
      subtitle: subtitle,
      leading: nil,
      trailing: trailing,
      action: action
    )
  }
}

extension DSListRow where Leading == EmptyView, Trailing == EmptyView {
  public init(
    title: String,
    subtitle: String? = nil,
    action: (() -> Void)? = nil
  ) {
    self.init(
      title: title,
      subtitle: subtitle,
      leading: nil,
      trailing: nil,
      action: action
    )
  }
}
