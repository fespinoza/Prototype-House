import SwiftUI
import Contacts

struct FetchContactsDemoView: View {
    struct FetchedContact: Identifiable, Hashable {
        let id = UUID()
        let firstName: String
        let lastName: String
        let phoneNumbers: [String]
        let emailAddresses: [String]
    }

    @State var localContacts: [FetchedContact] = []

    var body: some View {
        VStack {
            Menu {
                Button(
                    "Request Permission",
                    action: {
                        Task { await requestPermission() }
                    }
                )

                Button(
                    "Fetch Contacts",
                    action: {
                        Task { await fetchContacts() }
                    }
                )
            } label: {
                Text("Contact Operations")
            }

            List(localContacts) { contact in
                contactView(for: contact)
            }
        }
        .navigationTitle("Contacts")
    }

    func contactView(for contact: FetchedContact) -> some View {
        VStack(alignment: .leading) {
            Text("\(contact.firstName) \(contact.lastName)")
                .font(.headline.bold())
            VStack(alignment: .leading) {
                ForEach(contact.phoneNumbers, id: \.self) { phoneNumber in
                    Text("- \(phoneNumber)")
                }
            }
            VStack(alignment: .leading) {
                ForEach(contact.emailAddresses, id: \.self) { emailAddress in
                    Text("- \(emailAddress)")
                }
            }
        }
    }

    func requestPermission() async {
        let store = CNContactStore()

        do {
            let accessGranted = try await store.requestAccess(for: .contacts)
            print("Access Granded \(accessGranted)")
        } catch {
            dump(error)
        }
    }

    func fetchContacts() async {
        Task {
            let store = CNContactStore()

            let keysToFetch = [
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactEmailAddressesKey,
                CNContactPhoneNumbersKey,
            ] as [CNKeyDescriptor]

            var contacts: [CNContact] = []

            do {
                try store.enumerateContacts(
                    with: CNContactFetchRequest(keysToFetch: keysToFetch)
                ) { contact, stop in
                    contacts.append(contact)
                }

                localContacts = contacts.map({ contact in
                        .init(
                            firstName: contact.givenName,
                            lastName: contact.familyName,
                            phoneNumbers: contact.phoneNumbers.map(\.value).map(\.stringValue),
                            emailAddresses: contact.emailAddresses.map(\.value).map(String.init)
                        )
                })
            } catch {
                dump(error)
            }

        }
//        CNContactFormatter.string(from: contact, style: .fullName)
    }
}

#Preview {
    FetchContactsDemoView()
}
