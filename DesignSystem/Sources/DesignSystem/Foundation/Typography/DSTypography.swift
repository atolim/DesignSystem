import SwiftUI

public enum DSTypographyStyle {
  /// Massive display title for prominent headings (32pt, bold)
  case hero
  
  /// Large title for page headers (24pt, bold)
  case title1
  
  /// Medium title for section headers (20pt, semibold)
  case title2
  
  /// Small title for subsections (18pt, semibold)
  case title3
  
  /// Standard reading text (16pt, regular)
  case body
  
  /// Accent or sub-text (14pt, regular)
  case callout
  
  /// Form labels or compact metadata (13pt, medium)
  case subheadline
  
  /// Fine print or auxiliary text (12pt, regular)
  case caption
  
  /// Extra small status text or tags (10pt, semibold)
  case caption2
}

public struct DSTypographyModifier: ViewModifier {
  let style: DSTypographyStyle
  let weight: Font.Weight?
  
  public func body(content: Content) -> some View {
    content
      .font(font)
      .lineSpacing(lineSpacing)
  }
  
  private var font: Font {
    switch style {
    case .hero:
      return .system(size: 32, weight: weight ?? .bold)
    case .title1:
      return .system(size: 24, weight: weight ?? .bold)
    case .title2:
      return .system(size: 20, weight: weight ?? .semibold)
    case .title3:
      return .system(size: 18, weight: weight ?? .semibold)
    case .body:
      return .system(size: 16, weight: weight ?? .regular)
    case .callout:
      return .system(size: 14, weight: weight ?? .regular)
    case .subheadline:
      return .system(size: 13, weight: weight ?? .medium)
    case .caption:
      return .system(size: 12, weight: weight ?? .regular)
    case .caption2:
      return .system(size: 10, weight: weight ?? .semibold)
    }
  }
  
  private var lineSpacing: CGFloat {
    switch style {
    case .hero: return 8
    case .title1: return 6
    case .title2: return 4
    case .title3: return 4
    case .body: return 5
    case .callout: return 4
    case .subheadline: return 3
    case .caption: return 2
    case .caption2: return 2
    }
  }
}

extension View {
  /// Applies the DesignSystem typography style.
  /// - Parameters:
  ///   - style: The DSTypographyStyle (e.g. .title1, .body)
  ///   - weight: Optional weight override. If nil, uses the style's default weight.
  public func dsFont(_ style: DSTypographyStyle, weight: Font.Weight? = nil) -> some View {
    self.modifier(DSTypographyModifier(style: style, weight: weight))
  }
}
