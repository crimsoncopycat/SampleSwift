

import UIKit

protocol StoryboardInstantiable: class {
    static var storyboardName: String { get }
    static var identifier: String { get }
    static func instantiate() -> Self
}

extension StoryboardInstantiable {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: Self.storyboardName, bundle: nil)
    }
    
    /// Instantiates view controller with the specified identifier.
    /// Unless specified it will take the **identifier** as the class name.
    static func instantiate() -> Self {
        return storyboard.instantiateViewController(withIdentifier: identifier) !! "Could not instantiate \(Self.self) from storyboard file."
    }
    static func storyboardInstance() -> Self? {
        let storyboard = UIStoryboard(name:
            String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? Self
    }
}

infix operator !!

/** Improving Force-Unwrap Error Messages.
 - Parameter wrapped: Value you expected to be able to unwrap.
 - Parameter failureText: Descriptive error message when unwrapping fails.
 */
func !! <T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped { return x }
    fatalError("\(failureText()), Function: \(#function), Line: \(#line), Column: \(#column)")
}

/** Improving Force-Unwrap Error Messages when type of wrapped parameter can be inferred.
 - Parameter wrapped: Value you expected to be able to unwrap.
 - Parameter failureText: Descriptive error message when unwrapping fails.
 */
func !! <T>(wrapped: Any?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped as? T { return x }
    fatalError("\(failureText()), Function: \(#function), Line: \(#line), Column: \(#column)")
}
