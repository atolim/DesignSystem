import SwiftUI

// MARK: - Checkbox Style
public struct DSCheckboxStyle: ToggleStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    Button(action: { configuration.isOn.toggle() }) {
      HStack(spacing: DSSpacing.sm) {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .strokeBorder(configuration.isOn ? DSColor.primary : DSColor.border, lineWidth: 2)
            .background(
              RoundedRectangle(cornerRadius: 4)
                .fill(configuration.isOn ? DSColor.primary : Color.clear)
            )
            .frame(width: 20, height: 20)
          
          if configuration.isOn {
            DSIcon.check.image
              .font(.system(size: 11, weight: .bold))
              .foregroundColor(.white)
          }
        }
        .animation(.easeInOut(duration: 0.15), value: configuration.isOn)
        
        configuration.label
          .dsFont(.body)
          .foregroundColor(DSColor.textStrong)
      }
    }
    .buttonStyle(PlainButtonStyle())
  }
}

// MARK: - Switch Style
public struct DSSwitchStyle: ToggleStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
        .dsFont(.body)
        .foregroundColor(DSColor.textStrong)
      
      Spacer()
      
      Button(action: { configuration.isOn.toggle() }) {
        RoundedRectangle(cornerRadius: 16)
          .fill(configuration.isOn ? DSColor.primary : DSColor.border)
          .frame(width: 50, height: 30)
          .overlay(
            Circle()
              .fill(Color.white)
              .padding(3)
              .offset(x: configuration.isOn ? 10 : -10)
              .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 1)
              .animation(.spring(response: 0.25, dampingFraction: 0.75), value: configuration.isOn)
          )
      }
      .buttonStyle(PlainButtonStyle())
      .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
    }
  }
}

// MARK: - Radio Button
public struct DSRadioButton: View {
  let isOn: Bool
  let label: String
  let action: () -> Void
  
  public init(isOn: Bool, label: String, action: @escaping () -> Void) {
    self.isOn = isOn
    self.label = label
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      HStack(spacing: DSSpacing.sm) {
        ZStack {
          Circle()
            .strokeBorder(isOn ? DSColor.primary : DSColor.border, lineWidth: 2)
            .frame(width: 20, height: 20)
          
          if isOn {
            Circle()
              .fill(DSColor.primary)
              .frame(width: 10, height: 10)
              .transition(.scale.combined(with: .opacity))
          }
        }
        .animation(.spring(response: 0.2, dampingFraction: 0.8), value: isOn)
        
        Text(label)
          .dsFont(.body)
          .foregroundColor(DSColor.textStrong)
      }
    }
    .buttonStyle(PlainButtonStyle())
  }
}
