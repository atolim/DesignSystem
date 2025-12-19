//
//  BaseButton.swift
//  DesignSystem
//
//  Created by 임주영 on 12/4/25.
//

import Foundation
import SwiftUI

struct BaseButton: ButtonStyle, BaseButtonStyle {
  var contentStyle: any ButtonContentStyle
  var size: ButtonSize
  
  @Environment(\.isEnabled) private var isEnabled
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(size.inset)
      .font(size.font)
      .background(backgroundView)
      .cornerRadius(4, antialiased: true)
      .foregroundStyle(contentStyle.titleColor)
      .opacity(configuration.isPressed ? 0.5 : 1)
  }
  
  @ViewBuilder
  private var backgroundView: some View {
    if let grad = contentStyle as? GradationContentButtonStyle {
      Rectangle()
        .fill(
          LinearGradient(
            gradient: Gradient(colors: isEnabled
                               ? [
                                  grad.startColor,
                                  grad.endColor
                               ]
                               : [Color.gray.opacity(0.5), Color.gray.opacity(0.4)]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
    } else {
      Rectangle()
        .fill(
          isEnabled
            ? contentStyle.backgroundColor
            : contentStyle.disabledBackgroundColor
        )
    }
  }
}
#Preview {
  ScrollView {
    LazyVStack {
      Button {
        
      } label: {
        Text("Adasd")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      Button(action: {
        
      }, label: {
        Text("Ad")
      })
        .modifier(ButtonModifier(size: .small, contentType: .blue))
      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))
      .disabled(true)
      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))
      .disabled(true)
      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))
      .disabled(true)
      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))


      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      
      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      
      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))

      Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
      }
      .setButtonStyle(.large, contentType: .gradient(Color.purple, Color.pink ))
      .disabled(true)
    }
  }
}
