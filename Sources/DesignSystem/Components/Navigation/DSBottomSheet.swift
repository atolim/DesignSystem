import SwiftUI

public struct DSBottomSheetModifier<SheetContent: View>: ViewModifier {
  @Binding var isPresented: Bool
  let detents: Set<PresentationDetent>
  let dragIndicatorVisible: Bool
  let sheetContent: () -> SheetContent
  
  public func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        sheetContent()
          .presentationDetents(detents)
          .presentationDragIndicator(dragIndicatorVisible ? .visible : .hidden)
          .presentationCornerRadius(24)
          .background(DSColor.backgroundDefault)
      }
  }
}

extension View {
  /// Presents a premium bottom sheet styled with design system background and rounded corners.
  /// - Parameters:
  ///   - isPresented: Binding to control sheet visibility.
  ///   - detents: Height options for the sheet (e.g. .medium, .large, .fraction(0.3)).
  ///   - dragIndicatorVisible: Whether to show the top drag handle bar.
  ///   - content: ViewBuilder content inside the bottom sheet.
  public func dsBottomSheet<Content: View>(
    isPresented: Binding<Bool>,
    detents: Set<PresentationDetent> = [.medium, .large],
    dragIndicatorVisible: Bool = true,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    self.modifier(
      DSBottomSheetModifier(
        isPresented: isPresented,
        detents: detents,
        dragIndicatorVisible: dragIndicatorVisible,
        sheetContent: content
      )
    )
  }
}
