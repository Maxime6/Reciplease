//
//  String.swift
//  Reciplease
//
//  Created by Maxime on 30/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation

extension String {
    var transformToArrayWithoutPonctuation: [String] {
        return self.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ").filter({!$0.isEmpty})
    }
    
//    func changeImageResolution(url: String) -> String {
//        let newString = url.replacingCharacters(in: Substring(), with: <#T##StringProtocol#>)
//    }

    var updateSizeOfUrlImage: String {
        return self.dropLast(2) + "360"
    }

}