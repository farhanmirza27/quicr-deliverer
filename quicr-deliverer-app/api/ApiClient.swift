//
//  ApiClient.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 29/10/2020.
//

import Foundation

protocol APIClientProtocol {
    func createStripeCustomer(completion : @escaping (Result<StripeCustomer,Error>) -> Void)
    func processPayment(customerId : String, paymentId : String, amount : Double,completion : @escaping (Result<PaymentResponse,Error>) -> Void)
  
}

// apiClient class to handle network requests
class ApiClient  : APIClientProtocol {
  
    static let shared = ApiClient()
    
    // MARK: GenericRequest
    private func performRequest<T:Decodable>(url:String, decoder: JSONDecoder = JSONDecoder(), parameters : [String :Any]?  = nil, requestType : HttpRequest ,completion:@escaping (Result<T,Error>)->Void)  {
        guard let url = URL(string: url) else {return}
        var request = URLRequest(url: url)
        
        request.httpMethod = requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters = parameters {
            // add parameters for future request...
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // failure
                completion(.failure(error))
            }
            do {
                guard let data = data else {return }
                let convertedString = String(data: data, encoding: String.Encoding.utf8) // the data will be converted to the string
                print(convertedString ?? "defaultvalue")
                
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            }
            catch let jsonError {
                // json parse failure
                completion(.failure(jsonError))
            }
        }.resume()
    }

    func createStripeCustomer(completion : @escaping (Result<StripeCustomer,Error>) -> Void) {
        performRequest(url: "https://quicr-app.herokuapp.com/create-customer", requestType: HttpRequest.Post) { result in
            completion(result)
        }
    }
    
    func setupPaymentIntent(completion : @escaping (Result<StripeCustomer,Error>) -> Void) {
        performRequest(url: "https://quicr-app.herokuapp.com/create-setup-intent", requestType: HttpRequest.Post) { result in
            completion(result)
        }
    }
    
    func processPayment(customerId: String, paymentId: String,amount : Double, completion: @escaping (Result<PaymentResponse, Error>) -> Void) {
        performRequest(url: "https://quicr-app.herokuapp.com/process-payment", parameters: ["customerId": customerId, "paymentId": paymentId, "amount" : amount], requestType: HttpRequest.Post) { result in
            completion(result)
        }
    }
    

}


