//
//  ButtonColorType.swift
//  DesignSystem
//
//  Created by 임주영 on 12/4/25.
//
import SwiftUI

public enum ButtonColorType {
  case black
  case white
  case purple
  case blue
  case gradient(Color, Color)
  
  var buttonContent: ButtonContentStyle {
    switch self {
    case .black:
      return BlackContentButtonStyle()
    case .white:
      return WhiteContentButtonStyle()
    case .purple:
      return PurpleContentButtonStyle()
    case .blue:
      return BlueContentButtonStyle()
    case .gradient(let startColor, let endColor):
      return GradationContentButtonStyle(startColor: startColor, endColor: endColor)
    }
  }
}

// MARK: - Black Style
struct BlackContentButtonStyle: ButtonContentStyle {
  var titleColor: Color { .white }
  var backgroundColor: Color { .black }
  var highlightedColor: Color? { nil }
  var disabledBackgroundColor: Color { .black.opacity(0.4) }
}

// MARK: - White Style
struct WhiteContentButtonStyle: ButtonContentStyle {
  var titleColor: Color { .black }
  var backgroundColor: Color { .white }
  var highlightedColor: Color? { nil }
  var disabledBackgroundColor: Color { .gray.opacity(0.2) }
}

// MARK: - Blue Style
struct BlueContentButtonStyle: ButtonContentStyle {
  var titleColor: Color { .white }
  var backgroundColor: Color { Color.blue }
  var highlightedColor: Color? { nil }
  var disabledBackgroundColor: Color { Color.blue.opacity(0.4) }
}

// MARK: - Purple Style
struct PurpleContentButtonStyle: ButtonContentStyle {
  var titleColor: Color { .white }
  var backgroundColor: Color { Color.purple }
  var highlightedColor: Color? { nil }
  var disabledBackgroundColor: Color { Color.purple.opacity(0.4) }
}

struct GradationContentButtonStyle: ButtonContentStyle, GradationStyle {
  var titleColor: Color = .white
  var backgroundColor: Color = .white
  var disabledBackgroundColor: Color { startColor.opacity(0.4) }
  var highlightedColor: Color? = nil
  var startColor: Color
  var endColor: Color
}
