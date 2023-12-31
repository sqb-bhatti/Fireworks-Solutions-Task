//
//  Created by Saqib Bhatti on 27/12/23.
//

import Foundation


struct CollegeListViewModel {
    var colleges: [College]
    
    init(colleges: [College]) {
        self.colleges = colleges
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return colleges.count
    }
    
    func collegeAtIndex(_ index: Int) -> CollegeViewModel {
        let college = self.colleges[index]
        return CollegeViewModel(college: college)
    }
    
    func getColleges(for country: String, completion: @escaping(CollegeListViewModel?) -> Void) {
        let countryURL = Constants.Urls.urlForCollegesByCountry(country: country)
        let countryResource = Resource<[College]>(url: countryURL) { data in
            let weatherResponse = try? JSONDecoder().decode([College].self, from: data)
            
            return weatherResponse
        }
        
        WebService().load(resource: countryResource) { (result) in
            if let countryResource = result {
                let vm = CollegeListViewModel(colleges: countryResource)
                completion(vm)
            } else {
                completion(nil)
            }
        }
    }
}



struct CollegeViewModel {
    let college: College
    
    var name: String {
        return self.college.name
    }
    
    var country: String {
        return self.college.country
    }
}
