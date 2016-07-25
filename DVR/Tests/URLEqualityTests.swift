//
//  URLEqualityTests.swift
//  DVR
//
//  Created by Mihai Georgescu on 25/07/16.
//  Copyright © 2016 Venmo. All rights reserved.
//

import XCTest
@testable import DVR

class URLEqualityTests: XCTestCase {

    var firstURL: NSURL!
    var secondURL: NSURL!
    
    override func tearDown() {
        firstURL = nil
        secondURL = nil
        super.tearDown()
    }
    
    func setupURLs(firstURL firstURL: String, secondURL: String) {
        self.firstURL = NSURL(string: firstURL)
        self.secondURL = NSURL(string: secondURL)
    }
    
    func testSameURL() {
        setupURLs(firstURL: "http://username:password@www.example.com:8080/news/there?name=ferret&age=22#jumpLocation",
                  secondURL: "http://username:password@www.example.com:8080/news/there?name=ferret&age=22#jumpLocation")
        
        XCTAssertEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL))
    }
    
    func testDifferentFragment() {
        setupURLs(firstURL: "http://www.example.com/index.html#jumpLocation",
                  secondURL: "http://www.example.com/index.html#jumpLocation2")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Fragment]))
    }
    
    func testIgnoreEverything() {
        setupURLs(firstURL: "https://admin:pass@www.example.ro:8081/map/here?city=SanFrancisco&population=20102#cupertino",
                  secondURL: "http://username:password@www.example.com:8080/news/there?name=ferret&age=22#jumpLocation")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Host, .Fragment, .Path, .Password, .Port, .Query, .Scheme, .User]))
    }
    
    func testDifferentHosts() {
        setupURLs(firstURL: "http://www.example.com/news/there?name=ferret&age=22",
                  secondURL: "http://www.example.ro/news/there?name=ferret&age=22")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Host]))
    }
    
    func testDifferentPaths() {
        setupURLs(firstURL: "http://www.example.com/index.html",
                  secondURL: "http://www.example.com/index2.html")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Path]))
    }
    
    func testDifferentPassword() {
        setupURLs(firstURL: "http://username:password1@www.example.com/index.html",
                  secondURL: "http://username:password2@www.example.com/index.html")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Password]))
    }
    
    func testDifferentPort() {
        setupURLs(firstURL: "http://www.example.com:8080/index.php",
                  secondURL: "http://www.example.com:8081/index.php")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Port]))
    }
    
    func testDifferentQuery() {
        setupURLs(firstURL: "http://www.example.com/news/there?name=ferret&age=22",
                  secondURL: "http://www.example.com/news/there?name=ferret&age=21")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Query]))
    }
    
    func testDifferentScheme() {
        setupURLs(firstURL: "https://www.example.com/news/there?name=ferret&age=22",
                  secondURL: "http://www.example.com/news/there?name=ferret&age=22")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.Scheme]))
    }
    
    func testDifferentUser() {
        setupURLs(firstURL: "http://username:password@www.example.com/news/there?name=ferret&age=22",
                  secondURL: "http://admin:password@www.example.com/news/there?name=ferret&age=22")
        
        XCTAssertNotEqual(firstURL, secondURL)
        XCTAssertTrue(firstURL.isEqual(toURL: secondURL, ignoreURLComponents: [.User]))
    }
}
