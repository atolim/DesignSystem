//
//  BadgeView.swift
//  DesignSystem
//
//  Created by 임주영 on 12/9/25.
//

import SwiftUI

public struct BadgeView: View {
  let text: String
  var tint: Color = .blue.opacity(0.15)

  public init(text: String, tint: Color = .blue.opacity(0.15)) {
    self.text = text
    self.tint = tint
  }
  
  public var body: some View {
    Text(text)
      .font(.caption2.weight(.semibold))
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(tint, in: Capsule())
  }
}
