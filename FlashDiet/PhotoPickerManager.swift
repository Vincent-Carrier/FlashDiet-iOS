//
//  ImagePickerDelegate.swift
//  FlashDiet
//
//  Created by Vincent on 2018-08-31.
//  Copyright © 2018 Vincent. All rights reserved.
//

import UIKit
import CoreData

class PhotoPickerManager: NSObject {
    
    weak var viewController: UIViewController?
    
    let imagePickerController = UIImagePickerController()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = (viewController
            as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        super.init()
    }
}
