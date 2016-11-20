//
//  FlickrDataManager.swift
//  Flickr
//
//  Created by Timofey Lavrenyuk on 11/20/16.
//  Copyright © 2016 Timofey Lavrenyuk. All rights reserved.
//

import Foundation

protocol FlickrPhotoSearchProtocol: class {
    func fetchPhotosByTag(searchTag: String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void
}

class FlickrDataManager: FlickrPhotoSearchProtocol {
    
    struct Errors {
        static let invalidApiKeyErrorCode = 100
    }
    
    struct FlickrAPIMeta {
        static let statusCode = "code"
    }
    
    struct FlickrAPI {
        static let APIKey = "cfd214e4dc870b2a80bebb64dfffd993"
        static let searchRequest = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"
    }
    
    func fetchPhotosByTag(searchTag: String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void {
        let escapedSearchTag = searchTag.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let format = FlickrAPI.searchRequest
        let arguments: [CVarArg] = [FlickrAPI.APIKey, escapedSearchTag!, page]
        
        let searchRequestURL = String(format: format , arguments: arguments)
        
        let url = NSURL(string: searchRequestURL)!
        let request = URLRequest(url: url as URL)
        
        let searchRequestTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Error fetching photos: \(error)")
                closure(error as NSError?, 0, nil)
            }
            
            do {
                
                let resultDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as?[String : AnyObject]
                
                guard let result = resultDictionary else { return }
                
                if let statusCode = result[FlickrAPIMeta.statusCode] as? Int {
                    if statusCode == Errors.invalidApiKeyErrorCode {
                        let invalidApiKeyError = NSError(domain: "FlickrAPIDomain", code: statusCode, userInfo: nil)
                        closure(invalidApiKeyError, 0, nil)
                    }
                }
                
                guard let photosResponse = resultDictionary!["photos"] as? NSDictionary else { return }
                guard let totalPageCountString = photosResponse["total"] as? String else { return }
                guard let totalPageCount = NSInteger(totalPageCountString as String) else { return }
                
                guard let photosArray = photosResponse["photo"] as? [NSDictionary] else { return }
                
                let photos: [FlickrPhotoModel] = photosArray.map({ (photoDictionary) -> FlickrPhotoModel in
                    
                    let photoId = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let serverId = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    
                    let photo = FlickrPhotoModel(photoId: photoId, farm: farm, secret: secret, serverId: serverId, title: title)
                    
                    return photo
                })
                
                closure(nil, totalPageCount, photos)

                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                closure(error, 0, nil)
            }
        }
        searchRequestTask.resume()
    }
    
}
