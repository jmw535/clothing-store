import Foundation

class MenuController {
    let baseURL = URL(string: "http://localhost:8090/")!


// GET request
func fetchCategories(completion: @escaping ([String]?) -> Void)
{
    let categoryURL =
        baseURL.appendingPathComponent("categories")
    // Parse server response
    let task = URLSession.shared.dataTask(with: categoryURL)
    { (data, response, error) in
        if let data = data,
            let jsonDictionary = try?
                JSONSerialization.jsonObject(with: data) as?
                    [String:Any],
            let categories = jsonDictionary?["categories"] as?
                [String] {
            completion(categories)
        } else {
            completion(nil)
        }
    }
}

// GET request
func fetchMenuItems(categoryName: String, completion: @escaping
    ([MenuItem]?) -> Void) {
    let initialMenuURL = baseURL.appendingPathComponent("menu")
    var components = URLComponents(url: initialMenuURL,
                                   resolvingAgainstBaseURL: true)!
    components.queryItems = [URLQueryItem(name: "category",
                                          value: categoryName)]
    let menuURL = components.url!
    // Parse server response
    let task = URLSession.shared.dataTask(with: menuURL)
    { (data, response, error) in
        var menuItems = [MenuItem]()
        if let data = data,
            let jsonDictionary = try?
                JSONSerialization.jsonObject(with: data) as?
                    [String: Any],
            let menuArray = jsonDictionary?["items"] as?
                [[String: Any]] {
            let menuItems = menuArray.flatMap { MenuItem(json: $0) }
            completion(menuItems)
        } else {
            completion(nil)
        }
    }
}

// POST request
func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
    let orderURL = baseURL.appendingPathComponent("order")
    var request = URLRequest(url: orderURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField:
        "Content-Type")
    let data: [String: Any] = ["menuIds": menuIds]
    let jsonData = try? JSONSerialization.data(withJSONObject:
        data, options: [])
    request.httpBody = jsonData
    // Parse server response
    let task = URLSession.shared.dataTask(with: request)
    { (data, response, error) in
        if let data = data,
            let jsonDictionary = try? JSONSerialization.jsonObject(with:
                data) as? [String: Any],
            let prepTime = jsonDictionary?["preparation_time"]
                as? Int {
            completion(prepTime)
        } else {
            completion(nil)
        }
    }
}

}
