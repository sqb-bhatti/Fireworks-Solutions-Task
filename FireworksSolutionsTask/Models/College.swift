//
//  
//  Created by Saqib Bhatti on 28/12/23.
//

import Foundation


struct College: Decodable {
    let name: String
    let country: String
    let alpha_two_code: String
    let domains: [String]
    let web_pages: [String]
}
