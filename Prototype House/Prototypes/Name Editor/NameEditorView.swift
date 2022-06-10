//
//  NameEditorView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 01/05/2022.
//

import SwiftUI

struct NameEditorDemoView: View {
    @State var name: String = "Felipe"
    @State var isEditingName: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Text(name)
                .foregroundColor(.white)
                .font(.largeTitle)
                .multilineTextAlignment(.center)

            Button("Edit Name", action: presentEditingArea)
                .tint(Color.yellow)
                .buttonStyle(.bordered)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.purple)
        .overlay(editNameArea)
    }

    @ViewBuilder var editNameArea: some View {
        if isEditingName {
            NameEditorView(
                isPresented: $isEditingName,
                name: name,
                title: "Name for Player 1",
                onChange: { newName in
                    self.name = newName
                }
            )
            .transition(.opacity.animation(.easeInOut(duration: 0.33)))
        } else {
            EmptyView()
        }
    }

    func presentEditingArea() {
        withAnimation {
            isEditingName = true
        }
    }
}

/*

 - Use `@FocusState` and `focused` to focus on the text field when appears
 - Use `isContentPresented` + `onAppear` to animate with delay a second portion of the view
    - first the background opacity
    - second the "overlay" content

 */

struct NameEditorView: View {
    @Binding var isPresented: Bool
    @State var name: String = "Hello"
    @State var title: String = "Name for Player 2"

    @State private var isContentPresented: Bool = false

    @FocusState private var isTextFieldFocused: Bool

    var onChange: ((String) -> Void)? = nil

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()
                content
                    .offset(x: 0, y: isContentPresented ? 0 : 60)
                    .opacity(isContentPresented ? 1 : 0)
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.easeInOut.delay(0.3)) {
                isContentPresented = true
            }
        }
    }

    var content: some View {
        VStack {
            Text(title)
                .font(.headline)

            HStack {
                TextField("Name", text: $name)
                    .focused($isTextFieldFocused)

                clearButton
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color(UIColor.tertiarySystemGroupedBackground))
            )
            .padding(.vertical, 16)

            HStack {
                Button("Cancel", role: .cancel, action: cancel)
                Spacer()
                Button("OK", action: confirm)
                    .buttonStyle(.bordered)
            }
        }
        .onAppear(perform: {
            isTextFieldFocused = true
        })
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(8)
        .padding()
    }

    @ViewBuilder var clearButton: some View {
        if name != "" {
            Button(action: clearName) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
    }

    func clearName() {
        name = ""
    }

    func cancel() {
        dismissView()
    }

    func confirm() {
        onChange?(name)
        dismissView()
    }

    private func dismissView() {
        withAnimation {
            isContentPresented = false
            isPresented = false
        }
    }
}

struct NameEditorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NameEditorDemoView()
                .preferredColorScheme(.dark)

//            NameEditorView(isPresented: .constant(true))
        }
    }
}
