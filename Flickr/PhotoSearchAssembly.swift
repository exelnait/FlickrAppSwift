//
//  PhotoSearchAssembly.swift
//  Flickr
//
//  Created by Timofey Lavrenyuk on 11/20/16.
//  Copyright © 2016 Timofey Lavrenyuk. All rights reserved.
//

import Foundation

class PhotoSearchAssembly {
    
    static let sharedInstance = PhotoSearchAssembly()
    
    func configure(_ viewController: PhotoSearchViewController) {
        let APIDataManager = FlickrDataManager()
        let interactor = PhotoSearchInteractor()
        let presenter = PhotoSearchPresenter()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.APIDataManager = APIDataManager
        
    }
    
}
