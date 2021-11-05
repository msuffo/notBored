import Foundation
import Alamofire

struct Activity: Codable {
    let activity: String
    let accessibility: Float
    let type: String
    let participants: Int
    let price: Float
    let link: String
    let key: String
}

struct ActivityRes: Codable {
    let activity: Activity
}

class ActivitiesService {
    
    static let shared = ActivitiesService()
    
    private let apiClient = AlamofireAPIClient()
    private let baseUrl: String = "https://www.boredapi.com/api/activity"
    
    func getActivity( key: String? = nil, type: String? = nil, participants: Int? = nil, price: Float? = nil, minPrice: Float? = nil, maxPrice: Float? = nil, accessibility: Float? = nil, minAccessibility: Float? = nil, maxAccessibility: Float? = nil, completion: @escaping (  Activity  ) -> Void, onError: @escaping() -> Void ) {
        let url = "\( baseUrl )?"
            + ( key != nil ? "key=\( key! )&" : "" )
            + ( type != nil ? "type=\( type! )&" : "" )
            + ( participants != nil ? "participants=\( participants! )&" : "" )
            + ( price != nil ? "price=\( price! )&" : "" )
            + ( minPrice != nil && maxPrice != nil ? "minprice=\( minPrice! )&maxprice=\( maxPrice! )&" : "" )
            + ( accessibility != nil ? "accessibility=\( accessibility! )&" : "" )
            + ( minAccessibility != nil && maxAccessibility != nil ? "minaccessibility=\( minAccessibility! )&maxaccessibility\( maxAccessibility! )&" : ""
        )
        print( url )
        sendGetRequest( url, completion, onError )
    }
    
    private func sendGetRequest(_ url: String,_ completion: @escaping ( Activity ) -> Void,_ onError: @escaping() -> Void ) {
        apiClient.get(url: url) { response in
            switch response {
                case .success(let data):
                    do {
                        print( data )
                        if let data = data {
                            let activityRes = try JSONDecoder().decode( Activity.self, from: data )
                            completion( activityRes )
                        }
                    } catch let error {
                        print( error )
                        onError()
                    }
                case .failure(_):
                    onError()
            }
        }
    }
}
