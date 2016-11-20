//
//  FlickrPhotoModel.swift
//  Flickr
//
//  Created by Timofey Lavrenyuk on 11/20/16.
//  Copyright © 2016 Timofey Lavrenyuk. All rights reserved.
//

import Foundation

struct FlickrPhotoModel {
    let photoId: String
    let farm: Int
    let secret: String
    let serverId: String
    let title: String
    
    var photoUrl: NSURL {
        return flickrImageUrl()
    }
    
    var largePhotoUrl: NSURL {
        return flickrImageUrl(size: "b")
    }
    
    private func flickrImageUrl(size: String = "m") -> NSURL {
        //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(serverId)/\(photoId)_\(secret)_\(size).jpg")!
    }
}
