//
//  BaseRequest.swift
//  SotatekCore
//
//  Created by Thanh Tran on 9/14/16.
//  Copyright © 2016 SotaTek. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import Alamofire
import RealmSwift

public class BaseRequest {
    
    
    //MARK: Get Method
    func getOne(_ id: DataIdType, url: String, options: [String : Any] = [:]) -> Observable<HttpResponse> {
        let (headers, params) = createRequestParams(options: options)

        return createResponseObservable(method: .get, url: "\(url)/\(id)", headers: headers, params: params)
    }
    
    func getAll(url: String, options: [String: Any] = [:]) -> Observable<HttpResponse> {
        let (headers, params) = createRequestParams(options: options)
        return createResponseObservable(method: .get, url: url, headers: headers,  params: params)
    }
    
    //MARK: Post Method
    func create(url: String, options: [String: Any] = [:]) -> Observable<HttpResponse> {
        let (headers, params) = createRequestParams(options: options)
        return createResponseObservable(method: .post, url: url, headers: headers,  params: params)
    }
    
    //MARK: Put Method
    func updateOne(id: DataIdType, url: String, options: [String: Any] = [:]) -> Observable<HttpResponse> {
        let (headers, params) = createRequestParams(options: options)
        return createResponseObservable(method: .put, url: "\(url)/\(id)", headers: headers,  params: params)
    }
    
    func update(url: String, options: [String: Any] = [:]) -> Observable<HttpResponse> {
        let (headers, params) = createRequestParams(options: options)
        return createResponseObservable(method: .put, url: url, headers: headers,  params: params)
    }
    
    //MARK: Delete Method
    func deleteOne(id: DataIdType, url: String, options: [String: Any] = [:]) -> Observable<HttpResponse> {
        let (headers, params) = createRequestParams(options: options)
        return createResponseObservable(method: .delete, url: "\(url)/\(id)", headers: headers,  params: params)
    }
    
    func delete(url: String, options: [String: Any] = [:]) -> Observable<HttpResponse> {
        let (headers, params) = createRequestParams(options: options)
        return createResponseObservable(method: .delete, url: url, headers: headers,  params: params)
    }
    
    private func createRequestParams(options: [String: Any]) -> ([String: Any], [String: Any]) {
        let params = options[Constant.RepositoryParam.requestParams] as? [String: Any] ?? [:]
        let headers = options[Constant.RepositoryParam.requestHeader] as? [String: Any] ?? [:]
        return (headers, params)
    }
    
    private func createDefaultParams() -> [String: Any] {
        return [:]
    }
    
    private func createDefaultHeaders() -> [String: String] {
        return [:]
    }
    
    // MARK: Configure Request
    func executeRequest( method: HTTPMethod, url: String, headers: [String: Any], params: [String: Any], _ completionHandler:@escaping ((DataResponse<Any>) -> ())) {
//        var requestParams = createDefaultParams()
//        for (key, value) in params {
//            requestParams[key] = value
//        }
        var requestHeaders = createDefaultHeaders()
        for (key, val) in headers {
            requestHeaders[key] = val as? String ?? ""
        }
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
        BLogInfo(url)
//        BLogInfo(requestParams.description)

//        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
//        request.httpMethod = method.rawValue
//
//        request.timeoutInterval = TimeInterval(kTimeOut)
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if let responseHTTP = response as? HTTPURLResponse {
//                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
//                    if (error != nil) {
//                        print(error!)
//                        completion(false,nil)
//                    } else {
//                        var arrRecentSearch = [String]()
//                        let json = JSON(data!)
//
//                        for title in json["products"].arrayValue {
//                            arrRecentSearch.append(title["title"].stringValue)
//                        }
//                        completion(true, arrRecentSearch)
//                    }
//                } else {
//                    completion(false , nil)
//                }
//            } else {
//                completion(false , nil)
//            }
//
//        })
//
//        dataTask.resume()
        
        if method == .put || method == .post {
            let _ = Alamofire.request(url, method: method, parameters: params,encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: completionHandler)
        } else {
            let _ = Alamofire.request(url, method: method, parameters: params,encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON(completionHandler: completionHandler)
        }
        
//        let _ = Alamofire.request(url, method: method, parameters: params,encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON(completionHandler: completionHandler)
        
    }
    
    func createResponseObservable(method: HTTPMethod, url: String, headers: [String: Any], params: [String: Any]) -> Observable<HttpResponse> {
        return Observable<HttpResponse>.create({subscribe in
            let urlRequest = "\(FDefined.hostUrl)\(url)"
            self.executeRequest(method: method, url: urlRequest, headers: headers, params: params, {response in
                self.processResponse(response: response, subscribe: subscribe)
            })
            return Disposables.create()
        })
    }
   
    func processResponse(response: DataResponse<Any>, subscribe: AnyObserver<HttpResponse>) {
        if let error = response.error {
            print(error)
            subscribe.on(.error(error))
        } else {
            if let  json = response.result.value {
                print(json)
                let jsonResponse = HttpResponse(fromJson: JSON(json))
                subscribe.onNext(jsonResponse)
            }
            
        }
        subscribe.onCompleted()
    }
    
}
