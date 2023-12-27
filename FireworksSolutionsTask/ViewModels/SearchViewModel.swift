//
//  SearchViewModel.swift
//  FireworksSolutionsTask
//
//  Created by Saqib Bhatti on 27/12/23.
//

import UIKit
import CoreLocation

class SearchViewModel {
    // MARK: - Properties
    
    var labelText: String {
        return "Where to?"
    }
    
    var labelFont: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    
    var textFieldText: String {
        return "Enter Destination"
    }
    
    var textFieldBackgroundColor: UIColor {
        return .tertiarySystemBackground
    }
    
    var textFieldLeftView: UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
    }
    
    var textFieldMode: UITextField.ViewMode {
        return .always
    }
    
    var textFieldCornerRadius: CGFloat {
        return 9.0
    }
    
    var tableViewBackgroundColor: UIColor {
        return .secondarySystemBackground
    }
    
    var locations: [Location] = []
    
    var hasLocations: Bool { return numberOfLocations > 0 }
    var numberOfLocations: Int { return locations.count }
    
}
