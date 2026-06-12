import SwiftUI

public struct DSModal: View {
  let title: String
  let description: String
  let primaryButton: DSButton?
  let secondaryButton: DSButton?
  let isPresented: Binding<Bool>
  
  public init(
    title: String,
    description: String,
    primaryButton: DSButton? = nil,
    secondaryButton: DSButton? = nil,
    isPresented: Binding<Bool>
  ) {
    self.title = title
    self.description = description
    self.primaryButton = primaryButton
    self.secondaryButton = secondaryButton
    self.isPresented = isPresented
  }
  
  public var body: some View {
    ZStack {
      if isPresented.wrappedValue {
        // Dimmed Backdrop
        Color.black.opacity(0.4)
          .edgesIgnoringSafeArea(.all)
          .transition(.opacity)
          .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
              isPresented.wrappedValue = false
            }
          }
        
        // Modal Content Box
        VStack(spacing: DSSpacing.lg) {
          VStack(spacing: DSSpacing.sm) {
            Text(title)
              .dsFont(.title3, weight: .bold)
              .foregroundColor(DSColor.textStrong)
              .multilineTextAlignment(.center)
            
            Text(description)
              .dsFont(.body)
              .foregroundColor(DSColor.textNeutral)
              .multilineTextAlignment(.center)
              .lineLimit(nil)
          }
          .padding(.horizontal, DSSpacing.xs)
          
          // Action Buttons
          HStack(spacing: DSSpacing.sm) {
            if let secondaryButton = secondaryButton {
              secondaryButton
            }
            if let primaryButton = primaryButton {
              primaryButton
            }
          }
        }
        .padding(DSSpacing.xl)
        .background(DSColor.backgroundDefault)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 32)
        .transition(.scale(scale: 0.9).combined(with: .opacity))
        .zIndex(1)
      }
    }
    .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isPresented.wrappedValue)
  }
}

public struct DSModalModifier: ViewModifier {
  @Binding var isPresented: Bool
  let title: String
  let description: String
  let primaryButton: DSButton?
  let secondaryButton: DSButton?
  
  public func body(content: Content) -> some View {
    ZStack {
      content
      
      DSModal(
        title: title,
        description: description,
        primaryButton: primaryButton,
        secondaryButton: secondaryButton,
        isPresented: $isPresented
      )
    }
  }
}

extension View {
  /// Presents a premium overlay modal dialog over the current view hierarchy.
  public func dsModal(
    isPresented: Binding<Bool>,
    title: String,
    description: String,
    primaryButton: DSButton? = nil,
    secondaryButton: DSButton? = nil
  ) -> some View {
    self.modifier(
      DSModalModifier(
        isPresented: isPresented,
        title: title,
        description: description,
        primaryButton: primaryButton,
        secondaryButton: secondaryButton
      )
    )
  }
}
