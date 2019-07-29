//
//  String.swift
//  Reciplease
//
//  Created by Maxime on 30/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation

extension String {
    
    /// Transform text to an array without ponctuation
    var transformToArrayWithoutPonctuation: [String] {
        return self.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ").filter({!$0.isEmpty})
    }

    /// Update the size of url image
    var updateSizeOfUrlImage: String {
        return self.dropLast(2) + "360"
    }
    
    /// Transform url into data
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }

}
