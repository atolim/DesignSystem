import SwiftUI

public struct DSSelect<Option: Hashable>: View {
  let label: String
  let options: [Option]
  @Binding var selectedOption: Option
  let optionTitle: (Option) -> String
  
  public init(
    label: String,
    options: [Option],
    selectedOption: Binding<Option>,
    optionTitle: @escaping (Option) -> String
  ) {
    self.label = label
    self.options = options
    self._selectedOption = selectedOption
    self.optionTitle = optionTitle
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: DSSpacing.xs) {
      Text(label)
        .dsFont(.caption)
        .foregroundColor(DSColor.textNeutral)
      
      Menu {
        ForEach(options, id: \.self) { option in
          Button(action: { selectedOption = option }) {
            HStack {
              Text(optionTitle(option))
              if selectedOption == option {
                DSIcon.check.image
              }
            }
          }
        }
      } label: {
        HStack {
          Text(optionTitle(selectedOption))
            .dsFont(.body)
            .foregroundColor(DSColor.textStrong)
          
          Spacer()
          
          DSIcon.chevronDown.image
            .foregroundColor(DSColor.textMuted)
            .imageScale(.small)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, DSSpacing.md)
        .background(DSColor.backgroundDefault)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(DSColor.border, lineWidth: 1)
        )
      }
    }
  }
}
