//
//  KeyboardInteraction.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/11/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public typealias KeyboardInputView = UIView & UITextInput // or [UITextField]

public protocol KeyboardInteracting: class {
    var scrollView: UIScrollView! { get }
    var keyboardInputViews: [KeyboardInputView] { get }
    
    func handleKeyboardShow(userInfo: [AnyHashable: Any])
    func handleKeyboardHide()
}

extension KeyboardInteracting where Self: UIViewController {
    
    private var activeView: UIView? {
        return keyboardInputViews.first { $0.isFirstResponder }
    }
    
    func handleKeyboardShow(userInfo: [AnyHashable: Any]) {
        guard
            let activeInputView = self.activeView,
            let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        else {
            return
        }
        addTapGesture()

        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        setScrollInsets(contentInsets)

        // If active text field is hidden by keyboard, scroll it so it's visible.
        let activeViewFrame = activeInputView.frame
        guard let activeRect = activeInputView.superview?.convert(activeViewFrame, to: scrollView) else {
            return
        }
        var rootFrame = self.view.frame
        rootFrame.size.height -= keyboardSize.height

        if !(rootFrame.contains(activeRect)) {
            scrollView?.scrollRectToVisible(activeRect, animated: true)
        }
    }

    func handleKeyboardHide() {
        setScrollInsets(.zero)
        removeTapGesture()
    }
    
    private func setScrollInsets(_ insets: UIEdgeInsets) {
        scrollView?.contentInset = insets
        scrollView?.scrollIndicatorInsets = insets
    }
    
    private func addTapGesture() {
        /// Workaround to use gesture recognizer in protocol extension.
        /// Swift 4 requires that methods called with selectors must be marked as @objc which is not allowed in protocol extentions
        let tap = ClosureTapRecognizer { [weak self] recognizer in
            self?.tapOnWhiteSpace(recognizer: recognizer)
        }
        self.view.addGestureRecognizer(tap)
    }
    
    private func removeTapGesture() {
        let tap = self.view.gestureRecognizers?.first { $0 is ClosureTapRecognizer }
        if let tap = tap {
            self.view.removeGestureRecognizer(tap)
        }
    }
    
    private func tapOnWhiteSpace(recognizer: UITapGestureRecognizer) {
        activeView?.resignFirstResponder()
        removeTapGesture()
    }
}

extension UIViewController {
    public func registerForKeyboardNotifications() {
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardDidShow(notification:)),
                           name: NSNotification.Name.UIKeyboardDidShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:)),
                           name: NSNotification.Name.UIKeyboardWillHide,
                           object: nil)
    }
    
    public func unregisterForKeyboardNotifications() {
        let center = NotificationCenter.default
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        (self as? KeyboardInteracting)?.handleKeyboardShow(userInfo: userInfo)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        (self as? KeyboardInteracting)?.handleKeyboardHide()
    }
}
