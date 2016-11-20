//
//  PhotoSearchPresenter.swift
//  Flickr
//
//  Created by Timofey Lavrenyuk on 11/20/16.
//  Copyright © 2016 Timofey Lavrenyuk. All rights reserved.
//

import Foundation

protocol PhotoSearchPresenterInput: PhotoSearchViewControllerOutput {
}

class PhotoSearchPresenter: PhotoSearchPresenterInput  {
    
    var interactor: PhotoSearchInteractorInput!
    
    //Presenter says to interactor that ViewContoller needs photos
    func fetchPhotos(_ searchTag: String, page: NSInteger) {
        interactor.fetchAllPhotosFromDataManager(searchTag, page: page)
    }
    
}
