import SwiftUI

public enum DSAvatarSize {
  case small
  case medium
  case large
  
  public var size: CGFloat {
    switch self {
    case .small: return 32
    case .medium: return 48
    case .large: return 64
    }
  }
  
  var initialsTypography: DSTypographyStyle {
    switch self {
    case .small: return .caption
    case .medium: return .body
    case .large: return .title3
    }
  }
}

public enum DSAvatarStatus {
  case none
  case online
  case offline
}

public struct DSAvatar: View {
  let url: URL?
  let initials: String?
  let size: DSAvatarSize
  let status: DSAvatarStatus
  
  public init(
    url: URL? = nil,
    initials: String? = nil,
    size: DSAvatarSize = .medium,
    status: DSAvatarStatus = .none
  ) {
    self.url = url
    self.initials = initials
    self.size = size
    self.status = status
  }
  
  public var body: some View {
    ZStack(alignment: .bottomTrailing) {
      avatarBody
        .frame(width: size.size, height: size.size)
        .clipShape(Circle())
      
      if status != .none {
        Circle()
          .fill(status == .online ? DSColor.success : DSColor.textMuted)
          .frame(width: size.size * 0.28, height: size.size * 0.28)
          .overlay(
            Circle()
              .stroke(DSColor.backgroundDefault, lineWidth: 2)
          )
          .offset(x: 1, y: 1)
      }
    }
  }
  
  @ViewBuilder
  private var avatarBody: some View {
    if let url = url {
      AsyncImage(url: url) { phase in
        switch phase {
        case .empty:
          ZStack {
            DSColor.backgroundSecondary
            ProgressView()
              .controlSize(.small)
          }
        case .success(let image):
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        case .failure:
          fallbackBody
        @unknown default:
          fallbackBody
        }
      }
    } else {
      fallbackBody
    }
  }
  
  @ViewBuilder
  private var fallbackBody: some View {
    ZStack {
      DSColor.backgroundSecondary
      
      if let initials = initials, !initials.isEmpty {
        Text(initials.prefix(2).uppercased())
          .dsFont(size.initialsTypography, weight: .bold)
          .foregroundColor(DSColor.textNeutral)
      } else {
        DSIcon.profilePlaceholder.image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .foregroundColor(DSColor.textMuted)
          .padding(size.size * 0.2)
      }
    }
  }
}
