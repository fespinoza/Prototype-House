import SwiftUI

@available(iOS 26, *)
struct FromIOSDevsSlack: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Slack Toolbar")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("""
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut \
                labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco \
                laboris nisi ut aliquip ex ea commodo consequat.
                """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Do nothing
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                    }
                }

                ToolbarItem(placement: .automatic) {
                    Button {
                        print("Channel tapped")
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "number")
                                .fontWeight(.bold)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack(alignment: .leading, spacing: 2) {
                                Text("dev-talk")
                                    .font(.callout)
                                    .fontWeight(.bold)

                                Text("1,400 members **•** 4 tabs")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                ToolbarSpacer(.fixed)

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Audio tapped")
                    } label: {
                        Label {
                            Text("Audio")
                        } icon: {
                            Image(systemName: "headphones")
                                .font(.title3)
                        }
                        .labelStyle(.iconOnly)
                    }
                }
            }
        }
    }
}

@available(iOS 26, *)
#Preview {
    FromIOSDevsSlack()
}
