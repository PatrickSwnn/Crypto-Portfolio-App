//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 04/05/2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError : LocalizedError {
        case badServerResponse(url:URL)
        case unknown(url:URL)
        //make a computed property based on this enum
        
        var errorDescription: String? {
            switch self {
            case .badServerResponse(url: let url) : return "[🔥] There was a bad server response from url: \(url)"
            case .unknown(url:let url) : return " [⚠️] Unknown error occured from url: \(url)"
            }
        }
        
    }
    
    
    //when the func is static, you don't need to initialize the object to use it
    static func downloadData(forURL url : URL) -> AnyPublisher<Data, Error> {
            return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .retry(3) //retry if the publisher fails
            .tryMap({ try dataValidation(output: $0, url: url)})
            //erasetoAnyPublisher will convert some type of publisher to AnyPublisher
            .eraseToAnyPublisher()
    }
    
    

    static func dataValidation(output : URLSession.DataTaskPublisher.Output,url:URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.badServerResponse(url: url) }
            return output.data

        }
    
    
    static func completionHandler( completion : Subscribers.Completion<any Error>){
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        
    }
    
    
    
}




