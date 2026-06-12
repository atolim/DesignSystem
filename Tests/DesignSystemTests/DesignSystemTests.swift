import Testing
import SwiftUI
@testable import DesignSystem

@Suite("DesignSystem Foundation Tests")
struct DesignSystemTests {
  
  @Test("Verify spacing layout tokens")
  func testSpacingConstants() {
    #expect(DSSpacing.xxs == 2.0)
    #expect(DSSpacing.xs == 4.0)
    #expect(DSSpacing.sm == 8.0)
    #expect(DSSpacing.md == 12.0)
    #expect(DSSpacing.lg == 16.0)
    #expect(DSSpacing.xl == 24.0)
    #expect(DSSpacing.xxl == 32.0)
    #expect(DSSpacing.xxxl == 48.0)
  }
  
  @Test("Verify icon SF Symbols bindings")
  func testIconRawValues() {
    #expect(DSIcon.check.rawValue == "checkmark")
    #expect(DSIcon.close.rawValue == "xmark")
    #expect(DSIcon.search.rawValue == "magnifyingglass")
    #expect(DSIcon.chevronDown.rawValue == "chevron.down")
  }
}
