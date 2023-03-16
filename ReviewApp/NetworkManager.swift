//
//  NetworkManager.swift
//  ReviewApp
//
//  Created by Nayan Pawar on 02/03/23.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
        private init(){}
    
    
    func getReviews(completion: @escaping (Json4Swift_Base) -> Void){
        
        //        Get url of the server
        guard let url = URL(string: "http://52.76.221.73/demo/get_ratings.json")
        else{
            fatalError()
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data, error == nil
            else{
                fatalError()
            }
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Json4Swift_Base.self, from: data)
                print("Data is decoded from JSON")
                completion(decodedData)
            }catch let error{
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func getReviewAlamofire(comp : @escaping (Json4Swift_Base?,String?)->Void) {
        let url = "http://52.76.221.73/demo/get_ratings.json"
        AF.request(url).responseDecodable(of: Json4Swift_Base.self) { resonce in
            switch resonce.result {
            case .success(let decodedData) :
                
//                guard let data else {return}
//                do {
//                    let decodedData = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                    comp(decodedData, nil)
//                } catch {
//                    comp(nil,error.localizedDescription)
//                }
            case.failure(let error) :
                comp(nil,error.localizedDescription)
            }
        }
    }
    
    func postReq(comp : @escaping (String)->Void){
        let url = "https://dummyjson.com/posts/add"
        let header:HTTPHeaders = ["Content-Type" : "application/json"]
        let params = ["title": "I am in love with someone.",
                     "userId": "5"]
        let par = PostModel(title: "I am in love with ios and macbook air.", userId: 5)
        AF.request(url, method: .post, parameters: par, encoder: JSONParameterEncoder.default, headers: header).response { respone in
            switch respone.result {
            case .success(let data) :
                guard let data else {return}
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    let title:String = (json as AnyObject).value(forKey: "title") as! String
                    comp(title)
                } catch {
                    comp(error.localizedDescription)
                }
            case.failure(let error) :
                comp(error.localizedDescription)
            }
        }
    }
}
