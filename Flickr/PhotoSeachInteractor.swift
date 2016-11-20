//
//  PhotoSeachInteractor.swift
//  Flickr
//
//  Created by Timofey Lavrenyuk on 11/20/16.
//  Copyright © 2016 Timofey Lavrenyuk. All rights reserved.
//

import Foundation

protocol PhotoSearchInteractorInput: class {
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger)
}

class PhotoSearchInteractor: PhotoSearchInteractorInput {
    
    var APIDataManager: FlickrPhotoSearchProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger) {
        APIDataManager.fetchPhotosByTag(searchTag: searchTag, page: page) { (error, totalPages, photos) in
            if photos != nil {
                print(photos)
            } else if let error = error {
                print(error)
            }
        }
    }
    
}
