//
//  BaseButtonStyle.swift
//  DesignSystem
//
//  Created by 임주영 on 12/4/25.
//
import SwiftUI

public enum ButtonSize {
  case xsamll
  case small
  case medium
  case large
  case xlarge
  
  var inset: EdgeInsets {
    switch self {
    case .xsamll:
      return EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
    case .small:
      return EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
    case .medium:
      return EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    case .large:
      return EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
    case .xlarge:
      return EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24)
    }
  }
  
  var font: Font {
    switch self {
    case .xsamll:
      return .caption2
    case .small:
      return .caption
    case .medium:
      return .subheadline
    case .large:
      return .callout
    case .xlarge:
      return .body
    }
  }
}

enum ButtonStyleType {
  case solid
  case capsule
}

enum ButtonIconDirection {
  case leading
  case trailing
}

protocol ButtonContentStyle {
  var titleColor: Color { get }
  var backgroundColor: Color { get }
  var disabledBackgroundColor: Color { get }
  var highlightedColor: Color? { get }
}

protocol GradationStyle {
  var startColor: Color { get }
  var endColor: Color { get }
}

protocol BaseButtonStyle {
  var size: ButtonSize { get }
  var contentStyle: ButtonContentStyle { get }
}

protocol GradationXsmallButtonStyle: BaseButtonStyle {}
extension GradationXsmallButtonStyle {
  var size: ButtonSize { .xsamll }
}

protocol BorderButtonContentStyle: BaseButtonStyle {}
protocol SolidButtonContentStyle: BaseButtonStyle {}
