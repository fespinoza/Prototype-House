//
//  ViewThatFitsExample.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 30/05/2024.
//

import SwiftUI

struct ViewThatFitsExample: View {
    enum Experiment: String, CaseIterable {
        case manual = "Manual"
        case forEach = "For Each"
        case overflowContent = "Overflow"
    }

    enum Size: Int, CaseIterable {
        case small = 100
        case medium = 200
        case large = 300
    }

    @State var experiment: Experiment = .manual
    @State var size: Size = .medium

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HStack {
                    Picker("Experiment", selection: $experiment) {
                        ForEach(Experiment.allCases, id: \.rawValue) { exp in
                            Text(exp.rawValue).tag(exp)
                        }
                    }

                    Spacer()

                    Picker("Size", selection: $size) {
                        ForEach(Size.allCases, id: \.rawValue) { exp in
                            Text(exp.rawValue, format: .number).tag(exp)
                        }
                    }
                }

                VStack {
                    switch experiment {
                    case .manual:
                        ManualView()
                    case .forEach:
                        ForEachView()
                    case .overflowContent:
                        Color.red.frame(height: 500)
                    }
                }
                .frame(height: CGFloat(size.rawValue))
                .background(Color.brown.opacity(0.1))

                Color.gray.opacity(0.3)
            }
            .padding()
        }
    }

    struct ForEachView: View {
        var body: some View {
            ViewThatFits {
                VariableContentView(count: 5)
                VariableContentView(count: 4)
                VariableContentView(count: 3)
                VariableContentView(count: 2)
                VariableContentView(count: 1)
            }
        }
    }

    struct VariableContentView:  View {
        let count: Int

        var body: some View {
            VStack {
                ForEach(0..<count, id: \.self) { index in
                    Row(title: "\(index + 1)", color: .blue)
                }

                Spacer()
            }
        }
    }

    struct ManualView: View {
        var body: some View {
            ViewThatFits {
                five
                four
                three
                two
                one
            }
        }

        var five: some View {
            VStack {
                Row(title: "one", color: .red)
                Row(title: "two", color: .blue)
                Row(title: "three", color: .green)
                Row(title: "four", color: .orange)
                Row(title: "five", color: .purple)

                Spacer()
            }
        }

        var four: some View {
            VStack {
                Row(title: "one", color: .red)
                Row(title: "two", color: .blue)
                Row(title: "three", color: .green)
                Row(title: "four", color: .orange)

                Spacer()
            }
        }

        var three: some View {
            VStack {
                Row(title: "one", color: .red)
                Row(title: "two", color: .blue)
                Row(title: "three", color: .green)

                Spacer()
            }
        }

        var two: some View {
            VStack {
                Row(title: "one", color: .red)
                Row(title: "two", color: .blue)

                Spacer()
            }
        }

        var one: some View {
            VStack {
                Row(title: "one", color: .red)

                Spacer()
            }
        }
    }

    struct Row: View {
        let title: String
        var color: Color = .red

        var body: some View {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(color.opacity(0.3))
        }
    }
}

#Preview {
    ViewThatFitsExample()
}
