import SwiftUI
import DesignSystem

public struct ContentView: View {
  // Tab selection
  @State private var currentTab = 0
  
  // State for Inputs
  @State private var textNormal = ""
  @State private var textPassword = ""
  @State private var textError = ""
  @State private var textSuccess = "valid_input_here"
  @State private var textNoLabel = ""
  @State private var textNoBorder = ""
  @State private var textNoLabelNoBorder = ""
  @State private var checkboxOn = false
  @State private var switchOn = true
  @State private var selectedRadio = "Option A"
  @State private var selectedFruit = "Apple"
  let fruitOptions = ["Apple", "Banana", "Orange", "Grape"]
  
  // State for Feedback
  @State private var progressValue: Double = 0.4
  @State private var isTooltipPresented = false
  @State private var isBottomSheetPresented = false
  @State private var toastItem: DSToastItem? = nil
  
  // State for Navigation
  @State private var isModalPresented = false
  @State private var activeUnderlineTab = "Home"
  @State private var activePillTab = "All"
  
  public init() {}
  
  public var body: some View {
    TabView(selection: $currentTab) {
      // 1. Foundations Tab
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: DSSpacing.xl) {
            // Colors
            VStack(alignment: .leading, spacing: DSSpacing.sm) {
              Text("Colors")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: DSSpacing.md) {
                ColorCell(name: "Primary", color: DSColor.primary)
                ColorCell(name: "Secondary", color: DSColor.secondary)
                ColorCell(name: "Bg Default", color: DSColor.backgroundDefault)
                ColorCell(name: "Bg Sec", color: DSColor.backgroundSecondary)
                ColorCell(name: "Text Strong", color: DSColor.textStrong)
                ColorCell(name: "Text Neutral", color: DSColor.textNeutral)
                ColorCell(name: "Text Muted", color: DSColor.textMuted)
                ColorCell(name: "Border", color: DSColor.border)
                ColorCell(name: "Success", color: DSColor.success)
                ColorCell(name: "Warning", color: DSColor.warning)
                ColorCell(name: "Error", color: DSColor.error)
                ColorCell(name: "Info", color: DSColor.info)
              }
            }
            
            DSDivider()
            
            // Typography
            VStack(alignment: .leading, spacing: DSSpacing.sm) {
              Text("Typography")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              Group {
                TypographyRow(styleName: "Hero (32pt, Bold)", style: .hero)
                TypographyRow(styleName: "Title 1 (24pt, Bold)", style: .title1)
                TypographyRow(styleName: "Title 2 (20pt, Semibold)", style: .title2)
                TypographyRow(styleName: "Title 3 (18pt, Semibold)", style: .title3)
                TypographyRow(styleName: "Body (16pt, Regular)", style: .body)
                TypographyRow(styleName: "Callout (14pt, Regular)", style: .callout)
                TypographyRow(styleName: "Subheadline (13pt, Medium)", style: .subheadline)
                TypographyRow(styleName: "Caption (12pt, Regular)", style: .caption)
                TypographyRow(styleName: "Caption 2 (10pt, Semibold)", style: .caption2)
              }
            }
            
            DSDivider()
            
            // Spacing
            VStack(alignment: .leading, spacing: DSSpacing.sm) {
              Text("Spacing / Layout")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              VStack(alignment: .leading, spacing: DSSpacing.sm) {
                SpacingBlock(name: "xxs: 2pt", width: DSSpacing.xxs)
                SpacingBlock(name: "xs: 4pt", width: DSSpacing.xs)
                SpacingBlock(name: "sm: 8pt", width: DSSpacing.sm)
                SpacingBlock(name: "md: 12pt", width: DSSpacing.md)
                SpacingBlock(name: "lg: 16pt", width: DSSpacing.lg)
                SpacingBlock(name: "xl: 24pt", width: DSSpacing.xl)
                SpacingBlock(name: "xxl: 32pt", width: DSSpacing.xxl)
                SpacingBlock(name: "xxxl: 48pt", width: DSSpacing.xxxl)
              }
            }
          }
          .padding(DSSpacing.lg)
        }
        .background(DSColor.backgroundDefault)
        .navigationTitle("Foundations")
      }
      .tabItem {
        Label("Foundations", systemImage: "square.grid.2x2")
      }
      .tag(0)
      
      // 2. Inputs Tab
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: DSSpacing.xl) {
            // Buttons
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Buttons")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              HStack(spacing: DSSpacing.sm) {
                DSButton("Solid Primary", color: .primary, size: .small) {}
                DSButton("Outline", variant: .outline, color: .primary, size: .small) {}
                DSButton("Text", variant: .text, color: .primary, size: .small) {}
              }
              
              HStack(spacing: DSSpacing.sm) {
                DSButton("Secondary Gradient", variant: .gradient, color: .secondary, size: .medium) {}
                DSButton("Loading", variant: .solid, color: .neutral, size: .medium, isLoading: true) {}
              }
              
              DSButton("Destructive Button", icon: .warning, iconPosition: .leading, variant: .solid, color: .error, size: .large) {}
              
              DSButton("Disabled Button", variant: .solid, color: .primary, size: .medium) {}
                .disabled(true)
            }
            
            DSDivider()
            
            // TextFields
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Text Fields")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              DSTextField("Username", text: $textNormal, placeholder: "Enter username", leadingIcon: .profilePlaceholder)
              DSTextField("Password", text: $textPassword, placeholder: "Enter password", leadingIcon: .info, isSecure: true)
              DSTextField("Email Address", text: $textError, placeholder: "email@domain", state: .error("Invalid email format"))
              DSTextField("Referral Code", text: $textSuccess, placeholder: "Optional", state: .success)
              
              Text("New Variations")
                .dsFont(.subheadline, weight: .bold)
                .foregroundColor(DSColor.textNeutral)
                .padding(.top, DSSpacing.sm)
              
              DSTextField(text: $textNoLabel, placeholder: "No label, with border")
              DSTextField("With Label & No Border", text: $textNoBorder, placeholder: "Enter details", hasBorder: false)
              DSTextField(text: $textNoLabelNoBorder, placeholder: "No label & no border", hasBorder: false)
            }
            
            DSDivider()
            
            // Toggles
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Selection Controls")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              Toggle(isOn: $checkboxOn) {
                Text("I agree to terms and conditions")
              }
              .toggleStyle(DSCheckboxStyle())
              
              Toggle(isOn: $switchOn) {
                Text("Enable Push Notifications")
              }
              .toggleStyle(DSSwitchStyle())
              
              VStack(alignment: .leading, spacing: DSSpacing.sm) {
                Text("Select Option:")
                  .dsFont(.subheadline, weight: .bold)
                  .foregroundColor(DSColor.textNeutral)
                
                HStack(spacing: DSSpacing.xl) {
                  DSRadioButton(isOn: selectedRadio == "Option A", label: "Option A") { selectedRadio = "Option A" }
                  DSRadioButton(isOn: selectedRadio == "Option B", label: "Option B") { selectedRadio = "Option B" }
                }
              }
            }
            
            DSDivider()
            
            // Select Dropdown
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Dropdown Select")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              DSSelect(
                label: "Favorite Fruit",
                options: fruitOptions,
                selectedOption: $selectedFruit,
                optionTitle: { $0 }
              )
            }
          }
          .padding(DSSpacing.lg)
        }
        .background(DSColor.backgroundDefault)
        .navigationTitle("Inputs")
      }
      .tabItem {
        Label("Inputs", systemImage: "keyboard")
      }
      .tag(1)
      
      // 3. Feedback Tab
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: DSSpacing.xl) {
            // Badges
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Badges & Tags")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              HStack(spacing: DSSpacing.sm) {
                DSBadge("Primary", variant: .subtle, color: .primary)
                DSBadge("Success", variant: .solid, color: .success)
                DSBadge("Error", variant: .outline, color: .error)
                DSBadge("Warning", variant: .subtle, color: .warning)
              }
              
              HStack(spacing: DSSpacing.sm) {
                DSBadge("Status Active", icon: .check, variant: .subtle, color: .success, size: .small)
                DSBadge("Info Tag", icon: .info, variant: .solid, color: .info, size: .medium)
              }
            }
            
            DSDivider()
            
            // Avatars
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Avatars")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              HStack(spacing: DSSpacing.lg) {
                DSAvatar(initials: "JY", size: .small, status: .online)
                DSAvatar(url: URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80"), size: .medium, status: .online)
                DSAvatar(size: .large, status: .offline)
              }
            }
            
            DSDivider()
            
            // Progress
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Progress & Loading")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              HStack(spacing: DSSpacing.lg) {
                DSSpinner(size: 24, strokeWidth: 2, color: DSColor.primary)
                DSSpinner(size: 32, strokeWidth: 3, color: DSColor.secondary)
                DSSpinner(size: 48, strokeWidth: 4, color: DSColor.textStrong)
              }
              
              VStack(spacing: DSSpacing.sm) {
                DSProgressBar(value: progressValue)
                
                HStack {
                  DSButton("Decrease", variant: .outline, color: .neutral, size: .small) {
                    progressValue = max(0.0, progressValue - 0.1)
                  }
                  Spacer()
                  DSButton("Increase", variant: .outline, color: .primary, size: .small) {
                    progressValue = min(1.0, progressValue + 0.1)
                  }
                }
              }
            }
            
            DSDivider()
            
            // Alert Banners
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Banners")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              DSAlert(style: .info, title: "System Update", description: "A new version of the app is available. Please update.")
              DSAlert(
                style: .error,
                title: "Failed to upload file",
                description: "Connection was interrupted.",
                primaryAction: (title: "Retry", action: { toastItem = DSToastItem(message: "Retrying upload...", style: .info) })
              )
              DSAlert(style: .success, title: "Transaction complete", onDismiss: {})
            }
            
            DSDivider()
            
            // Interactions
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Interactions")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              HStack(spacing: DSSpacing.md) {
                Button(action: { isTooltipPresented.toggle() }) {
                  Text("Toggle Tooltip")
                    .dsFont(.subheadline, weight: .semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(DSColor.secondary)
                    .cornerRadius(8)
                }
                .dsTooltip(text: "Here is your info!", isPresented: $isTooltipPresented)
                
                DSButton("Trigger Toast", variant: .solid, color: .neutral) {
                  toastItem = DSToastItem(message: "This is a toast message!", style: .success)
                }
              }
              .padding(.bottom, 8)
              
              DSButton("Open Bottom Sheet", variant: .outline, color: .primary) {
                isBottomSheetPresented = true
              }
            }
          }
          .padding(DSSpacing.lg)
        }
        .background(DSColor.backgroundDefault)
        .navigationTitle("Feedback")
        .dsBottomSheet(isPresented: $isBottomSheetPresented) {
          VStack(spacing: DSSpacing.lg) {
            Text("Scrollable Drawer")
              .dsFont(.title2, weight: .bold)
              .foregroundColor(DSColor.textStrong)
            
            DSDivider()
            
            ScrollView {
              VStack(spacing: DSSpacing.md) {
                ForEach(1...20, id: \.self) { index in
                  DSListRow(title: "List Item \(index)", subtitle: "Subtitle description details")
                }
              }
            }
          }
          .padding(.top, DSSpacing.xl)
        }
      }
      .tabItem {
        Label("Feedback", systemImage: "bell")
      }
      .tag(2)
      .dsToast($toastItem)
      
      // 4. Navigation Tab
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: DSSpacing.xl) {
            // Tabs
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Sliding Tabs")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              DSTabs(
                tabs: ["Home", "Search", "Settings"],
                selectedTab: $activeUnderlineTab,
                tabTitle: { $0 },
                style: .underline
              )
              .padding(.bottom, 8)
              
              DSTabs(
                tabs: ["All", "Pending", "Done"],
                selectedTab: $activePillTab,
                tabTitle: { $0 },
                style: .pill
              )
            }
            
            DSDivider()
            
            // Modals
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Modal Dialogs")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              DSButton("Show Modal", variant: .solid, color: .primary) {
                isModalPresented = true
              }
            }
            
            DSDivider()
            
            // Lists
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Lists")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              VStack(spacing: 0) {
                DSListRow(
                  title: "Profile Settings",
                  subtitle: "Edit account details and email",
                  leading: { DSIcon.profilePlaceholder.image.foregroundColor(DSColor.primary) },
                  action: {}
                )
                
                DSDivider()
                
                DSListRow(
                  title: "Notifications Enabled",
                  leading: { DSIcon.info.image.foregroundColor(DSColor.secondary) },
                  trailing: {
                    Toggle("", isOn: $switchOn)
                      .labelsHidden()
                  }
                )
                
                DSDivider()
                
                DSListRow(
                  title: "Connection Status",
                  trailing: { DSBadge("Connected", variant: .subtle, color: .success, size: .small) },
                  action: {}
                )
              }
              .cornerRadius(12)
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(DSColor.border, lineWidth: 1.0)
              )
            }
            
            DSDivider()
            
            // Dividers
            VStack(alignment: .leading, spacing: DSSpacing.md) {
              Text("Dividers")
                .dsFont(.title2)
                .foregroundColor(DSColor.textStrong)
              
              Text("Horizontal:")
                .dsFont(.caption)
              DSDivider(orientation: .horizontal, thickness: 2.0, color: DSColor.primary)
              
              Text("Vertical (inside HStack):")
                .dsFont(.caption)
                .padding(.top, 4)
              
              HStack {
                Text("Left")
                DSDivider(orientation: .vertical, thickness: 2.0, color: DSColor.secondary)
                  .frame(height: 20)
                Text("Right")
              }
            }
          }
          .padding(DSSpacing.lg)
        }
        .background(DSColor.backgroundDefault)
        .navigationTitle("Navigation")
        .dsModal(
          isPresented: $isModalPresented,
          title: "Delete Account?",
          description: "Are you sure you want to permanently delete your account? This action cannot be undone.",
          primaryButton: DSButton("Delete", variant: .solid, color: .error) { isModalPresented = false },
          secondaryButton: DSButton("Cancel", variant: .outline, color: .neutral) { isModalPresented = false }
        )
      }
      .tabItem {
        Label("Navigation", systemImage: "arrow.up.right.square")
      }
      .tag(3)
    }
    .tint(DSColor.primary)
  }
}

// MARK: - Helper views for rendering foundations
struct ColorCell: View {
  let name: String
  let color: Color
  
  var body: some View {
    VStack(spacing: DSSpacing.xs) {
      RoundedRectangle(cornerRadius: 8)
        .fill(color)
        .frame(height: 60)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(DSColor.border, lineWidth: 1.0)
        )
      
      Text(name)
        .dsFont(.caption2)
        .foregroundColor(DSColor.textStrong)
        .multilineTextAlignment(.center)
    }
  }
}

struct TypographyRow: View {
  let styleName: String
  let style: DSTypographyStyle
  
  var body: some View {
    VStack(alignment: .leading, spacing: 2) {
      Text(styleName)
        .dsFont(.caption2)
        .foregroundColor(DSColor.textMuted)
      
      Text("The quick brown fox jumps.")
        .dsFont(style)
        .foregroundColor(DSColor.textStrong)
    }
    .padding(.vertical, 4)
  }
}

struct SpacingBlock: View {
  let name: String
  let width: CGFloat
  
  var body: some View {
    HStack {
      Text(name)
        .dsFont(.caption)
        .frame(width: 90, alignment: .leading)
      
      RoundedRectangle(cornerRadius: 2)
        .fill(DSColor.primary)
        .frame(width: width, height: 16)
      
      Spacer()
    }
  }
}
#Preview {
  ContentView()
}
