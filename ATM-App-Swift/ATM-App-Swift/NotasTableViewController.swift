//
//  NotasTableViewController.swift
//  ATM-App-Swift
//
//  Created by Marcos Matsuda on 22/10/2018.
//  Copyright © 2018 Marcos Matsuda. All rights reserved.
//

import UIKit
import CoreData

class NotasTableViewController: UITableViewController {
    
    var fetchResultsController: NSFetchedResultsController<Notas>!

    override func viewDidLoad() {
        super.viewDidLoad()
        carregaNotas()
    }
    
    @IBAction func btDeleteAll(_ sender: Any) {
        let managedContext = self.getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Notas")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            
        } catch {
            print ("There is an error in deleting records")
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
            return appDelegate.persistentContainer.viewContext
    }
    func carregaNotas(){
        let fetchRequest: NSFetchRequest<Notas> = Notas.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "valor", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self

        do{
            try fetchResultsController.performFetch()
            print(try fetchResultsController.performFetch())

        }catch{
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fetchResultsController.fetchedObjects?.count ?? 0
        return count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotasTableViewCell

        guard let nota = fetchResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: nota)
        return cell
        
    }

}

extension NotasTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
