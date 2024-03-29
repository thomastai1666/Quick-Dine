//
//  OrderviewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 11/29/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit
import CoreNFC

class OrderViewController: UIViewController, UISearchBarDelegate {
    
    func MenuDismissed() {
        print("Menu Dismissed - Delegate Success")
        updateBadgeNumber()
    }
    
    var session: NFCNDEFReaderSession?
    @IBOutlet var orderSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Order Up")
        orderSearchBar.delegate = self
    }
    
    func updateBadgeNumber(){
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[2]
            if(orderedItems.count == 0){
                tabItem.badgeValue = nil
            }
            else{
                tabItem.badgeValue = String(orderedItems.count)
            }
        }
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        startNFC()
    }
    
    
    func startNFC(){
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iPhone near the Quick Dine Sticker."
        session?.begin()
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "scannerVC") as! ScannerViewController
        controller.myTabController = tabBarController
        self.present(controller, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count == 5){
            //table ID
            print(searchText)
            if(restaurauntDoesExist(searchText: searchText)){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
                controller.tableID = searchText
                controller.myTabBarController = tabBarController
                orderSearchBar.text = ""
                self.present(controller, animated: true, completion: nil)
            }
            else{
                showAlert(title: "Error", alertMessage: "Table not found")
                orderSearchBar.text = ""
            }
        }
    }
}

extension OrderViewController: NFCNDEFReaderSessionDelegate {
    
    
    // MARK: - NFCNDEFReaderSessionDelegate
    
    /// - Tag: processingTagData
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        guard
            let ndefMessage = messages.first,
            let record = ndefMessage.records.first,
            record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
            let payloadText = String(data: record.payload, encoding: .utf8),
            let table = payloadText.components(separatedBy: "thomastai.com/quickdine/?table=").last else {
                return
        }
        
        
        self.session = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.presentMenuViewController(tableID: String(table))
        }
    }
    
    func presentMenuViewController(tableID: String) {
        print(tableID)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        controller.tableID = tableID
        controller.myTabBarController = tabBarController
        self.present(controller, animated: true, completion: nil)
    }
    
    
    /// - Tag: endScanning
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Check the invalidation reason from the returned error.
        if let readerError = error as? NFCReaderError {
            // Show an alert when the invalidation reason is not because of a success read
            // during a single tag read mode, or user canceled a multi-tag read mode session
            // from the UI or programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(
                    title: "Session Invalidated",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        // A new session instance is required to read new tags.
        self.session = nil
    }
    
    
    
}
