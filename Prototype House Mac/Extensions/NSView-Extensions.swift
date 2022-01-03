//
//  NSView-Extensions.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import AppKit

public extension NSView {
    /// Convenience initalizer to create views ready to be used with autoLayout
    /// - Parameter withAutoLayout
    convenience init(withAutoLayout: Bool) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = !withAutoLayout
    }

    func pinToSuperview() {
        guard let superview = superview else { return }
        pin(to: superview)
    }

    func centerInSuperview() {
        guard let superview = superview else { return }
        center(in: superview)
    }

    func centerAndConstraintInSuperview() {
        guard let superview = superview else { return }
        centerAndConstraint(in: superview)
    }

    /// Make all side anchors match the given anchorable's sides
    /// - Parameter anchorable: an instance of UIView or UILayoutGuide
    func pin(to anchorable: Anchorable) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: anchorable.leadingAnchor),
            trailingAnchor.constraint(equalTo: anchorable.trailingAnchor),
            topAnchor.constraint(equalTo: anchorable.topAnchor),
            bottomAnchor.constraint(equalTo: anchorable.bottomAnchor),
        ])
    }

    func center(in view: Anchorable) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    /// Centers a view within the passed area and
    /// ensures the size of this view is not bigger than the area is being centered into
    func centerAndConstraint(in view: Anchorable) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),

            widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor),
        ])
    }

    /// Fixed size utility method that makes the height equal to a width
    func fixed(size: CGFloat) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size),
        ])
    }

    /// Set fixed width or height if provided
    ///
    /// If a dimension is not provided, it won't be set.
    func fixed(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

/// A protocol to combine UIView and UILayoutGuide in order to define layout methods in an easier way
public protocol Anchorable {
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }

    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }

    var topAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

extension NSView: Anchorable {}
extension NSLayoutGuide: Anchorable {}
