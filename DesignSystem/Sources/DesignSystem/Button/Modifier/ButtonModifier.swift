//
//  ButtonModifier.swift
//  DesignSystem
//
//  Created by 임주영 on 12/4/25.
//
import SwiftUI

public struct ButtonModifier: ViewModifier {
  let size: ButtonSize
  let contentType: ButtonColorType
  
  public func body(content: Content) -> some View {
    content
      .buttonStyle(BaseButton(contentStyle: contentType.buttonContent, size: size))
  }
}

extension View {
  public func setButtonStyle(_ size: ButtonSize, contentType: ButtonColorType) -> some View {
    return self.modifier(ButtonModifier(size: size, contentType: contentType))
  }
}
