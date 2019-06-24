//
//  DownloadDataService.swift
//  Reciplease
//
//  Created by Maxime on 20/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation

class DownloadDataService {
    
    static func getData(with stringUrl: String, session: URLSession = URLSession.shared, callbBack: @escaping (Data?) -> Void) {
        guard let url = URL(string: stringUrl) else {
            callbBack(nil)
            return
        }
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                callbBack(nil)
                return
            }
            DispatchQueue.main.async {
                callbBack(data)
            }
        }.resume()
    }
    
}
