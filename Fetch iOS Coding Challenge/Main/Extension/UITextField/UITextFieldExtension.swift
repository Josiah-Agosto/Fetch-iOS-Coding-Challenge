//
//  UITextFieldExtension.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import UIKit
import Combine

extension UITextField {
    
    var textDidChangePublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { notification in
                (notification.object as? UITextField)?.text
            }
            .eraseToAnyPublisher()
    }
    
}
