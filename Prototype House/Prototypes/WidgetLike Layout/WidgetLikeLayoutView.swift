//
//  WidgetLikeLayoutView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 06/01/2026.
//

import SwiftUI

@available(iOS 26.0, *)
struct WidgetLikeLayoutView: View {
    struct Habit: Identifiable {
        let id = UUID()
        let name: String
    }

    let habits: [Habit] = [
        .init(name: "🇳🇴 Duolingo"),
        .init(name: "📚 Read"),
        .init(name: "🎬 YouTube"),
        .init(name: "🍅 4 work pomodoros"),
        .init(name: "🍅 4 work pomodoros"),
        .init(name: "🍅 4 work pomodoros"),
        .init(name: "🍅 4 work pomodoros"),
    ]

    var body: some View {
        VStack {
            Text("Hello, World!")

            widgetShape

            widgetContent
                .widgetShape()

            widgetContentTwo
                .widgetShapeTwo()
        }
    }

    var widgetContent: some View {
        HStack(spacing: 6) {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text(5.formatted())
                        .foregroundStyle(Color.accent)
                        .font(.system(size: 40))

                    Text("/\(16)")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("Today's Pending \(Text("Habits").foregroundStyle(Color.accent))")
                    .font(.subheadline.bold())
            }
            .padding()
            .frame(width: 130, alignment: .leading)
//                .background(Color.orange.opacity(0.2))

            VStack(alignment: .leading, spacing: 4) {
                ForEach(habits) { habit in
                    row(for: habit)
                }

//                    Spacer()
            }
//                .background(Color.green.opacity(0.2))
        }
    }

    var widgetContentTwo: some View {
        HStack(spacing: 6) {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text(5.formatted())
                        .foregroundStyle(Color.accent)
                        .font(.system(size: 40))

                    Text("/\(16)")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("Today's Pending \(Text("Habits").foregroundStyle(Color.accent))")
                    .font(.subheadline.bold())
            }
            .frame(width: 100, alignment: .leading)
//                .background(Color.orange.opacity(0.2))
            
            VStack(alignment: .leading, spacing: 4) {
                ForEach(habits) { habit in
                    row(for: habit)
                }

//                    Spacer()
            }
//                .background(Color.green.opacity(0.2))
        }
    }

    func row(for habit: Habit) -> some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .stroke()
                .foregroundStyle(.secondary)
                .frame(width: 19, height: 19)

            Text(habit.name)
                .lineLimit(1)
                .font(.footnote)

            Spacer()
        }
        .padding(.vertical, 6)
//        .frame(maxHeight: .infinity)
//        .background(Color.green.opacity(0.2))
    }

    var widgetShape: some View {
        Color.red
            .frame(width: 357, height: 166)
            .clipShape(.rect(cornerRadius: 21))
    }
}

@available(iOS 26.0, *)
private extension View {
    func widgetShape() -> some View {
        self
            .frame(width: 357, height: 166)
//            .clipShape(.rect(cornerRadius: 21))
            .overlay {
                ConcentricRectangle()
                    .foregroundStyle(Color.red.opacity(0.2))
                    .padding()
            }
            .overlay {
                RoundedRectangle(cornerRadius: 21)
                    .stroke()
            }
    }

    func widgetShapeTwo() -> some View {
        Color.clear
            .frame(width: 357, height: 166)
            .overlay {
                ConcentricRectangle()
                    .foregroundStyle(Color.red.opacity(0.2))
                    .overlay {
                        self
                    }
                    .padding()
            }
            .overlay {
                RoundedRectangle(cornerRadius: 21)
                    .stroke()
            }
            .clipShape(.rect(cornerRadius: 21))
    }
}

@available(iOS 26.0, *)
#Preview {
    WidgetLikeLayoutView()
}
