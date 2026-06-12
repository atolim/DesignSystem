import SwiftUI

public enum DSIcon: String {
  case check = "checkmark"
  case checkCircle = "checkmark.circle.fill"
  case warning = "exclamationmark.triangle.fill"
  case error = "xmark.circle.fill"
  case info = "info.circle.fill"
  case search = "magnifyingglass"
  case close = "xmark"
  case chevronRight = "chevron.right"
  case chevronLeft = "chevron.left"
  case chevronDown = "chevron.down"
  case chevronUp = "chevron.up"
  case eye = "eye"
  case eyeSlash = "eye.slash"
  case plus = "plus"
  case profilePlaceholder = "person.crop.circle.fill"
  
  public var image: Image {
    Image(systemName: self.rawValue)
  }
}
