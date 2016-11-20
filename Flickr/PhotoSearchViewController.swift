//
//  PhotoViewController.swift
//  Flickr
//
//  Created by Timofey Lavrenyuk on 11/20/16.
//  Copyright © 2016 Timofey Lavrenyuk. All rights reserved.
//

import UIKit

protocol PhotoSearchViewControllerOutput {
    func fetchPhotos(_ searchTag: String, page: NSInteger)
}

class PhotoSearchViewController: UIViewController {

    var presenter: PhotoSearchViewControllerOutput!
    
    var photos: [FlickrPhotoModel] = []
    var currentPage = 1
    var totalPages = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoSearchAssembly.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        performSearchWith(searchPhotoTag)
    }

    func performSearchWith(_ searchTag: String) {
        presenter.fetchPhotos(searchTag, page: currentPage)
    }
    
}
