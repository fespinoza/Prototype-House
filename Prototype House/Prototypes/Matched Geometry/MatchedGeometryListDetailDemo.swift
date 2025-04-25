import SwiftUI

private struct ProfileElement: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let color: Color
}

extension ProfileElement {
    static let sampleCollection: [ProfileElement] = [
        .init(name: "Alice", description: "Lead Developer", color: .blue),
        .init(name: "Bob", description: "iOS developer", color: .red),
        .init(name: "Mark", description: "QA Enginner", color: .orange),
        .init(name: "Eve", description: "iOS developer", color: .green),
        .init(name: "Rex", description: "Designer", color: .purple),
        .init(name: "Rudy", description: "Project Manager", color: .yellow),
    ]
}

struct MatchedGeometryListDetailDemo: View {
    @Namespace var list

    var body: some View {
        List(ProfileElement.sampleCollection) { element in
            NavigationLink(destination: { MatchedGeometryDetailView(element: element, list: list) }) {
                HStack {
                    Circle()
                        .fill(element.color)
                        .frame(width: 60, height: 60)
                        .matchedGeometryEffect(id: element.name, in: list)

                    VStack(alignment: .leading) {
                        Text(element.name).bold()
                        Text(element.description).foregroundStyle(Color.secondary)
                    }
                }
            }
        }
        .navigationTitle("The team")
    }
}

private struct MatchedGeometryDetailView: View {
    let element: ProfileElement

    let list: Namespace.ID

    var body: some View {
        ScrollView {
            VStack {
                Rectangle()
                    .foregroundStyle(element.color)
                    .frame(height: 300)
                    .matchedGeometryEffect(id: element.name, in: list)

                VStack(spacing: 16) {
                    Text(element.name).font(.largeTitle.bold())
                    Text(element.description)
                    
                    Text("""
                    Is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    """)
                    .padding(.top, 16)
                }
                .padding(.horizontal, 16)
            }
        }


    }
}

#Preview {
    NavigationStack {
        MatchedGeometryListDetailDemo()
    }
}
