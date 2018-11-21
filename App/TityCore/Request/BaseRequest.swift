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
    func executeRequest( method: HTTPMethod, url: String, headers: [String: Any], params: [String: Any], _ completionHandler:@escaping (Data?, URLResponse?, Error?) -> Void) {
//        var requestParams = createDefaultParams()
//        for (key, value) in params {
//            requestParams[key] = value
//        }
//        var requestHeaders = createDefaultHeaders()
//        for (key, val) in headers {
//            requestHeaders[key] = val as? String ?? ""
//        }
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        let headers = [
            "Content-Type": "application/json"
        ]
        
        
        if method == .post || method == .put {
            let postData = try! JSONSerialization.data(withJSONObject: params, options: [])
            request.httpBody = postData as Data
        }
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
        
        dataTask.resume()
        
//        let _ = Alamofire.request(url, method: method, parameters: params,encoding: URLEncoding.default, headers: headers).responseData(completionHandler: completionHandler)
        
    }
    
    func createResponseObservable(method: HTTPMethod, url: String, headers: [String: Any], params: [String: Any]) -> Observable<HttpResponse> {
        return Observable<HttpResponse>.create({subscribe in
            let urlRequest = "\(FDefined.hostUrl)\(url)"
            self.executeRequest(method: method, url: urlRequest, headers: headers, params: params, { (data, response, error) in
                if (error != nil) {
                    subscribe.on(.error(error!))
                } else {
                    if let json = data {
                        let jsonResponse = HttpResponse(fromJson: JSON(json))
                        subscribe.onNext(jsonResponse)
                        subscribe.onCompleted()
                    }
                }
            })
            return Disposables.create()
        })
    }
   
//    func processResponse(response:  (Data?, URLResponse?, Error?) -> Void, subscribe: AnyObserver<HttpResponse>) {
//        if let error = response.error {
//            print(error)
//            subscribe.on(.error(error))
//        } else {
//            if let  json = response.data {
//                print(json)
//                let jsonResponse = HttpResponse(fromJson: JSON(json))
//                subscribe.onNext(jsonResponse)
//            }
//
//        }
//        subscribe.onCompleted()
//    }
    
}
