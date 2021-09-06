//
//  UIView+Extensions.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 6.09.2021.
//

import UIKit

extension UIView {
    
    /// Default identifier to reuse in tableview, collectionview, map annotation etc.
    static var defaultReuseIdentifier: String {
        guard let substring: Substring = String(describing: self).split(separator: "<").first else {
            return String(describing: self)
        }
        return String(substring)
    }
    
    /// Loads, Instantiates and returns view instance from nib file
    /// - Parameter name: Name of NIB file to load.  Default value is Self.defaultReuseIdentifier (class name)
    static func instantiateFromNib(with name: String? = nil) -> Self? {
        func instanceFromNib<T: UIView>(with nibName: String? = nil) ->T? {
            let nibName = nibName ?? T.defaultReuseIdentifier
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: nil, options: nil).first as? T
        }
        
        return instanceFromNib(with: name)
    }

}
