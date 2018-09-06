//
//  FoodGridViewController.swift
//  FlashDiet
//
//  Created by Vincent on 2018-08-31.
//  Copyright © 2018 Vincent. All rights reserved.
//

import UIKit
import CoreData

class FoodGridViewController: UICollectionViewController {
    
    lazy var photoPickerManager = { [unowned self] in
        return PhotoPickerManager(viewController: self)
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<FoodEntry> = {
        let context = CoreData.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FoodEntry> = FoodEntry.fetchRequest()
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: "date",
                                             cacheName: nil)
        
        return frc
    }()

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        present(photoPickerManager.imagePickerController, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource
extension FoodGridViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return fetchedResultsController.sections?.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections?[section].objects?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell",
                                                      for: indexPath) as! FoodCell
        
        configure(cell, at: indexPath)
        return cell
    }
    
    private func configure(_ cell: FoodCell, at indexPath: IndexPath) {
        let foodEntry = fetchedResultsController.object(at: indexPath)
        cell.imageView.image = UIImage(data: foodEntry.image!)!
    }
}

extension FoodGridViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let foodEntry = FoodEntry(context: fetchedResultsController.managedObjectContext)
        configure(foodEntry, with: info)
    }
    
    private func configure(_ foodEntry: FoodEntry,
                           with info: [UIImagePickerController.InfoKey : Any]) {
        
        foodEntry.date = Date()
        foodEntry.image = (info[UIImagePickerController.InfoKey.originalImage] as! Data)
    }
}

// MARK: - UICollectionViewDelegate
extension FoodGridViewController {
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */

}
