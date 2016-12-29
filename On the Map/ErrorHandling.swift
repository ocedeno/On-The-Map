//
//  File.swift
//  On the Map
//
//  Created by Octavio Cedeno on 12/28/16.
//  Copyright © 2016 Octavio Cedeno. All rights reserved.
//

import Foundation

struct ErrorHandling {
    var title: String
    var message: String
}

var errorDictionary = [
    "emptyUsername" : ErrorHandling(title: "Blank Email Address", message: "No email address was provided."),
    "emtpyPassword" : ErrorHandling(title: "Blank Password", message: "No password was provided.")
]
