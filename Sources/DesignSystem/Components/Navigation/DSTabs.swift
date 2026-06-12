import SwiftUI

public enum DSTabStyle {
  case underline
  case pill
}

public struct DSTabs<Tab: Hashable>: View {
  let tabs: [Tab]
  @Binding var selectedTab: Tab
  let tabTitle: (Tab) -> String
  let style: DSTabStyle
  
  @Namespace private var tabAnimation
  
  public init(
    tabs: [Tab],
    selectedTab: Binding<Tab>,
    tabTitle: @escaping (Tab) -> String,
    style: DSTabStyle = .underline
  ) {
    self.tabs = tabs
    self._selectedTab = selectedTab
    self.tabTitle = tabTitle
    self.style = style
  }
  
  public var body: some View {
    switch style {
    case .underline:
      underlineStyleView
    case .pill:
      pillStyleView
    }
  }
  
  private var underlineStyleView: some View {
    VStack(spacing: 0) {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: DSSpacing.xl) {
          ForEach(tabs, id: \.self) { tab in
            Button(action: {
              withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                selectedTab = tab
              }
            }) {
              VStack(spacing: DSSpacing.sm) {
                Text(tabTitle(tab))
                  .dsFont(.body, weight: selectedTab == tab ? .bold : .medium)
                  .foregroundColor(selectedTab == tab ? DSColor.primary : DSColor.textMuted)
                  .padding(.horizontal, 4)
                
                ZStack {
                  if selectedTab == tab {
                    Rectangle()
                      .fill(DSColor.primary)
                      .frame(height: 3)
                      .matchedGeometryEffect(id: "underline", in: tabAnimation)
                  } else {
                    Rectangle()
                      .fill(Color.clear)
                      .frame(height: 3)
                  }
                }
              }
            }
            .buttonStyle(PlainButtonStyle())
          }
        }
        .padding(.horizontal, DSSpacing.lg)
      }
      
      Divider()
        .background(DSColor.border)
    }
  }
  
  private var pillStyleView: some View {
    HStack(spacing: 0) {
      ForEach(tabs, id: \.self) { tab in
        Button(action: {
          withAnimation(.spring(response: 0.28, dampingFraction: 0.8)) {
            selectedTab = tab
          }
        }) {
          Text(tabTitle(tab))
            .dsFont(.subheadline, weight: selectedTab == tab ? .semibold : .medium)
            .foregroundColor(selectedTab == tab ? DSColor.textStrong : DSColor.textMuted)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
              ZStack {
                if selectedTab == tab {
                  RoundedRectangle(cornerRadius: 8)
                    .fill(DSColor.backgroundDefault)
                    .shadow(color: Color.black.opacity(0.06), radius: 3, x: 0, y: 1)
                    .matchedGeometryEffect(id: "pill", in: tabAnimation)
                }
              }
            )
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
    .padding(4)
    .background(DSColor.backgroundSecondary)
    .cornerRadius(12)
  }
}
