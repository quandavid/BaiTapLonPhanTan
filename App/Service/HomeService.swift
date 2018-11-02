//
//  HomeService.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 10/9/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift
class HomeService: AppService {
//    let homeRequest = RequestFactory.homeRequest
//    
//    func getBanner() -> Observable<[Banner]> {
//        return self.homeRequest.getBanners().flatMap { (response: HttpResponse) -> Observable<[Banner]> in
//            var banners: [Banner] = []
//            response.data["banners"].arrayValue.forEach({ (data) in
//                banners.append(Banner(json: data))
//            })
//            return Observable<[Banner]>.create({ (subscribe) in
//                subscribe.onNext(banners)
//                subscribe.onCompleted()
//                return Disposables.create()
//            })
//        }
//    }
//    
//    func getAllCategories(limit: Int = 0) -> Observable<[CategoryModel]> {
//        return self.homeRequest.getAllCategories().flatMap({ (response: HttpResponse) -> Observable<[CategoryModel]> in
//            let dict = response.data["categories"].dictionaryValue
//            let arr = (dict["vertical"]!.arrayValue.compactMap { CategoryModel(data: $0)} + dict["horizontal"]!.arrayValue.compactMap { CategoryModel(data: $0)}).filter { limit == 0 ? true : $0.index < limit }
//            return Observable<[CategoryModel]>.create({ (subscribe) -> Disposable in
//                subscribe.onNext(arr)
//                subscribe.onCompleted()
//                return Disposables.create()
//            })
//        })
//    }
//    
//    func getListByTag(offset: Int, length: Int, tags: [String] = []) -> Observable<[ProductModel]> {
//        return self.homeRequest.getListByTag(length: length, offset: offset, tags: tags.reduce("") {result, tag in result + tag + (tag != tags.last ? "," : "") }).flatMap({ (response) -> Observable<[ProductModel]> in
//            let products = response.data["products"].arrayValue.compactMap{
//                ProductModel(json: $0)
//            }
//            return Observable<[ProductModel]>.create({ (subscribe) -> Disposable in
//                subscribe.onNext(products)
//                subscribe.onCompleted()
//                return Disposables.create()
//            })
//        })
//    }
}
