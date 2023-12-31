//
//  WebPageViewModel.swift
//  FireworksSolutionsTask
//
//  Created by Saqib Bhatti on 31/12/23.
//

import UIKit

struct WebPageViewModel {
    var didSelectRow: ((IndexPath) -> Void)?
    
    // URL to load in the WebView
    var url: URL?
    
    init(url: URL? = nil) {
        self.url = url
    }
    
    // Function to be called when a row is selected
    func rowSelected(at indexPath: IndexPath) {
        didSelectRow?(indexPath)
    }
}
