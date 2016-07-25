//
//  URL+Equality.swift
//  DVR
//
//  Created by Mihai Georgescu on 25/07/16.
//  Copyright © 2016 Venmo. All rights reserved.
//

import Foundation

/**
 Structure with the URLComponents
 */
public struct URLComponent: OptionSetType {
    /// Raw value
    public let rawValue: Int
    
    /// Fragment
    public static let Fragment = URLComponent(rawValue: 1 << 0)
    /// Host
    public static let Host     = URLComponent(rawValue: 1 << 1)
    /// Password
    public static let Password = URLComponent(rawValue: 1 << 2)
    /// Path
    public static let Path     = URLComponent(rawValue: 1 << 3)
    /// Port
    public static let Port     = URLComponent(rawValue: 1 << 4)
    /// Query
    public static let Query    = URLComponent(rawValue: 1 << 5)
    /// Scheme
    public static let Scheme   = URLComponent(rawValue: 1 << 6)
    /// User
    public static let User     = URLComponent(rawValue: 1 << 7)
    
    /**
     Initialization function
     
     - parameter rawValue: integer raw value
     */
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

/**
 Extension for checking URL equality
 */
extension NSURL {
    
    /**
     Function for checking if is equal to a url
     - Info: If you need to check that two URL are equal but with different hosts, just add the Host to the ignored URL
       Components
     - parameter url:                 the url to check against
     - parameter ignoreURLComponents: array of url components that should be ignored in the equality check
     
     - returns: true if is equal to url, otherwise false
     */
    func isEqual(toURL url: NSURL, ignoreURLComponents: URLComponent = []) -> Bool {
        guard let lhs = NSURLComponents(URL: self, resolvingAgainstBaseURL: true),
            rhs = NSURLComponents(URL: url, resolvingAgainstBaseURL: true) else {
                return false
        }
        
        return lhs.isEqua(toCompoents: rhs, ignoreComponents: ignoreURLComponents)
    }
}

/**
 Extension for checking URLComponents equality
 */
extension NSURLComponents {
    
    /**
     Function for checking if is equal with other URLComponents
     
     - parameter components:       the urlComponents to check against
     - parameter ignoreComponents: array of url components that should be ignored in the equality check
     
     - returns: true if is equal to url, otherwise false
     */
    func isEqua(toCompoents components: NSURLComponents, ignoreComponents: URLComponent = []) -> Bool {
        let equalFragment   = ignoreComponents.contains(.Fragment)  ? true : self.fragment == components.fragment
        let equalHost       = ignoreComponents.contains(.Host)      ? true : self.host == components.host
        let equalPassword   = ignoreComponents.contains(.Password)  ? true : self.password == components.password
        let equalPath       = ignoreComponents.contains(.Path)      ? true : self.path == components.path
        let equalPort       = ignoreComponents.contains(.Port)      ? true : self.port == components.port
        let equalQuery      = ignoreComponents.contains(.Query)     ? true : self.query == components.query
        let equalScheme     = ignoreComponents.contains(.Scheme)    ? true : self.scheme == components.scheme
        let equalUser       = ignoreComponents.contains(.User)      ? true : self.user == components.user
        
        return equalFragment &&
            equalHost &&
            equalPassword &&
            equalPath &&
            equalPort &&
            equalQuery &&
            equalScheme &&
        equalUser
    }
}
