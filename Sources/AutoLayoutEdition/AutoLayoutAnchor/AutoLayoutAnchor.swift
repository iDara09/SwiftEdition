import UIKit


/// An object used to setup layout anchor constraints.
/// 
/// - Tag: AutoLayoutAnchor
///
public struct AutoLayoutAnchor {
    
    public let view: UIView
    
    public let leading: Anchor<XAxisAnchor>
    public let trailing: Anchor<XAxisAnchor>
    public let centerX: Anchor<XAxisAnchor>
    
    public let top: Anchor<YAxisAnchor>
    public let bottom: Anchor<YAxisAnchor>
    public let centerY: Anchor<YAxisAnchor>
    public let firstBaseline: Anchor<YAxisAnchor>
    public let lastBaseline: Anchor<YAxisAnchor>
    
    public let width: Anchor<DimensionAnchor>
    public let height: Anchor<DimensionAnchor>
    
    /// Create AutoLayoutAnchor.
    ///
    /// - Parameter view: The view to anchor.
    init(view: UIView) {
        self.view = view
        leading = .init(view: view, type: .leading)
        trailing = .init(view: view, type: .trailing)
        centerX = .init(view: view, type: .centerX)
        top = .init(view: view, type: .top)
        bottom = .init(view: view, type: .bottom)
        centerY = .init(view: view, type: .centerY)
        firstBaseline = .init(view: view, type: .firstBaseline)
        lastBaseline = .init(view: view, type: .lastBaseline)
        width = .init(view: view, type: .width)
        height = .init(view: view, type: .height)
    }
    
    /// Pin the specified edges to the view's edges.
    ///
    /// - Parameters:
    ///   - view The reference view.
    ///   - edges: The edges to pin. The default is all edges.
    @discardableResult
    public func pinTo(_ view: UIView, _ edges: Set<XYAxisEdgeAnchor> = [.top, .bottom, .leading, .trailing]) -> Self {
        if edges.contains(.top) { top.equalTo(view) }
        if edges.contains(.bottom) { bottom.equalTo(view) }
        if edges.contains(.leading) { leading.equalTo(view) }
        if edges.contains(.trailing) { trailing.equalTo(view) }
        return self
    }
    
    /// Pin the specified edges to the guide's edges.
    ///
    /// - Parameters:
    ///   - guide The reference guide.
    ///   - edges: The edges to pin. The default is all edges.
    @discardableResult
    public func pinTo(_ guide: UILayoutGuide, _ edges: Set<XYAxisEdgeAnchor> = [.top, .bottom, .leading, .trailing]) -> Self {
        if edges.contains(.top) { top.equalTo(guide) }
        if edges.contains(.bottom) { bottom.equalTo(guide) }
        if edges.contains(.leading) { leading.equalTo(guide) }
        if edges.contains(.trailing) { trailing.equalTo(guide) }
        return self
    }
    
    /// Center to the view's center.
    ///
    /// - Parameter view: The reference view.
    @discardableResult
    public func centerTo(_ view: UIView) -> Self {
        centerX.equalTo(view)
        centerY.equalTo(view)
        return self
    }
    
    /// Center to the guide's center.
    ///
    /// - Parameter guide: The reference guide.
    @discardableResult
    public func centerTo(_ guide: UILayoutGuide) -> Self {
        centerX.equalTo(guide)
        centerY.equalTo(guide)
        return self
    }
    
    /// Size to the view's size.
    ///
    /// - Parameter view: The reference view.
    @discardableResult
    public func sizeTo(_ view: UIView) -> Self {
        width.equalTo(view)
        height.equalTo(view)
        return self
    }
    
    /// Size to the guide's size.
    ///
    /// - Parameter guide: The reference view.
    @discardableResult
    public func sizeTo(_ guide: UILayoutGuide) -> Self {
        width.equalTo(guide)
        height.equalTo(guide)
        return self
    }
    
    /// Set edges' padding after `pinTo(_:)`.
    ///
    /// Chaining will not stack.
    @discardableResult
    public func padding(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> Self {
        self.top.padding(top)
        self.bottom.padding(bottom)
        self.leading.padding(leading)
        self.trailing.padding(trailing)
        return self
    }
    
    /// Set edges' padding after `pinTo(_:)`.
    ///
    /// Chaining will not stack.
    @discardableResult
    public func padding(edges: CGFloat) -> Self {
        padding(top: edges, leading: edges, bottom: edges, trailing: edges)
        return self
    }
    
    /// Set center's padding after `centerTo(_:)`.
    ///
    /// Chaining will not stack.
    @discardableResult
    public func padding(centerX: CGFloat = 0, centerY: CGFloat = 0) -> Self {
        self.centerX.padding(centerX)
        self.centerY.padding(centerY)
        return self
    }
    
    /// Add dimension after `sizeTo(_:)`.
    ///
    /// Chaining will stack up.
    @discardableResult
    public func add(width: CGFloat = 0, height: CGFloat = 0) -> Self {
        self.width.add(width)
        self.height.add(height)
        return self
    }
    
    /// Subtract dimension after `sizeTo(_:)`.
    ///
    /// Chaining will stack up.
    @discardableResult
    public func subtract(width: CGFloat = 0, height: CGFloat = 0) -> Self {
        self.width.subtract(width)
        self.height.subtract(height)
        return self
    }
}


// MARK: - UIView Extension

extension UIView {
    
    /// An anchor object use as a reference to setup constraints.
    ///
    /// The property is intended to be use as a reference to setup anchor within the method `anchor(activate:)` or setup individual anchor.
    /// To access or update anchor's stored values, create a local instance and use it or grab the copied instance in the method.
    ///
    /// - Note: Accessing this property always returns a new anchor object with no stored values.
    ///
    /// ```
    ///     // EXAMPLE: How to store `NSLayoutConstraint` if needed.
    ///
    ///     var variable: NSLayoutConstraint!
    ///
    ///     // CORRECT
    ///     subview.anchor.leading.equalTo(superview).storeIn(&variable)
    ///
    ///     // CORRECT
    ///     subview.anchor.pinTo(superview).leading.storeIn(&variable)
    ///
    ///     // CORRECT
    ///     // because using the same copied anchor instance
    ///     subview.anchor { anchor in
    ///         anchor.pinTo(superview)
    ///         anchor.leading.storeIn(&variable)
    ///     }
    ///
    ///     // INCORRECT
    ///     // because accessing .anchor always give a new instance
    ///     subview.anchor.pinTo(superview)
    ///     subview.anchor.leading.storeIn(&variable)
    ///
    ///     // CORRECTION
    ///     // get a copied instance and setup using that one
    ///     let anchor = subview.anchor
    ///     anchor.pinTo(superview)
    ///     anchor.leading.storeIn(&variable)
    /// ```
    ///
    /// - Tag: AutoLayoutAnchor.anchor
    public var anchor: AutoLayoutAnchor { .init(view: self) }
    
    /// A method used to setup constraint anchor.
    ///
    /// - Parameter activate: The given anchor is the receiver's anchor.
    public func anchor(activate: (AutoLayoutAnchor) -> Void) {
        activate(anchor)
    }
}
