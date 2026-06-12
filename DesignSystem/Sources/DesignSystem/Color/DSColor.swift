//
//  Untitled.swift
//  DesignSystem
//
//  Created by 임주영 on 12/19/25.
//

// Sources/DesignSystem/Color/DSColor.swift
import SwiftUI
import Foundation

public enum DSColor {
  public static let primary = Color("primary", bundle: .module)
  public static let secondary = Color("secondary", bundle: .module)
  
  public static let backgroundDefault = Color("backgroundDefault", bundle: .module)
  public static let backgroundSecondary = Color("backgroundSecondary", bundle: .module)
  
  public static let textStrong = Color("textStrong", bundle: .module)
  public static let textNeutral = Color("textNeutral", bundle: .module)
  public static let textMuted = Color("textMuted", bundle: .module)
  
  public static let border = Color("border", bundle: .module)
  
  public static let success = Color("success", bundle: .module)
  public static let warning = Color("warning", bundle: .module)
  public static let error = Color("error", bundle: .module)
  public static let info = Color("info", bundle: .module)
}
