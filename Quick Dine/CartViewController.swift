//
//  CartViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/3/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import Foundation
import UIKit
import PassKit
import Stripe
import FirebaseAuth
import Firebase

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CartTableDelegate{
    
    var applePayButton: PKPaymentButton!
    @IBOutlet var applePayStackView: UIStackView!
    var paymentSucceeded = false
    
    @IBOutlet var cartTableView: UITableView!
    
    let db = Firestore.firestore()
    
    func reloadTable() {
        cartTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applePayButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .whiteOutline)
        applePayButton.isEnabled = Stripe.deviceSupportsApplePay()
        STPPaymentConfiguration.shared().appleMerchantIdentifier = "merchant.com.thomastai.quickdinne"
        if(applePayButton.isEnabled){
            setupApplePay()
        }
        print("Cart Loaded")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            applePayButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .white)
        } else {
            // User Interface is Light
            applePayButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .white)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Show empty cell
        if(orderedItems.count == 0){
            return 1
        }
        //Show regular menu items
        return orderedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(orderedItems.count == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptycell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! CartViewCell
        cell.selectionStyle = .none
        cell.menuName.text = orderedItems[indexPath.row].name
        cell.menuCalorieCount.text = String(orderedItems[indexPath.row].calories) + " Calories"
        cell.menuPrice.text = "$" + String(orderedItems[indexPath.row].price)
        cell.menuImage.image = orderedItems[indexPath.row].image
        cell.itemcount = orderedItems[indexPath.row].quantity
        cell.MenuViewCellItem = orderedItems[indexPath.row]
        cell.menuImage.layer.cornerRadius = 5.0
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func setupApplePay() {
        applePayButton.addTarget(self, action: #selector(handleApplePayButtonTapped), for: .touchUpInside)
        self.applePayStackView.addArrangedSubview(applePayButton)
    }
    
    func getCartTotal() -> NSDecimalNumber{
        var total: Float = 0
        let handler = NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        for item in orderedItems{
            total = total + (item.price * Float(item.quantity))
        }
        return NSDecimalNumber(value: total).rounding(accordingToBehavior: handler)
    }
    
    @objc func handleApplePayButtonTapped() {
        let merchantIdentifier = "merchant.com.thomastai.quickdinne"
        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")

        // Configure the line items on the payment request
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Food", amount: getCartTotal()),
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "Quickdine, Inc", amount: getCartTotal()),
        ]
        // Present Apple Pay payment sheet
        if Stripe.canSubmitPaymentRequest(paymentRequest),
            let paymentAuthorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            paymentAuthorizationViewController.delegate = self
            present(paymentAuthorizationViewController, animated: true)
        } else {
            // There is a problem with your Apple Pay configuration
        }
    }
    
}

extension CartViewController: PKPaymentAuthorizationViewControllerDelegate {

    @available(iOS 11.0, *)
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Convert the PKPayment into a Token
        STPAPIClient.shared().createToken(with: payment) { token, error in
              guard let token = token else {
                  // Handle the error
                  return
              }
            let tokenID = token.tokenId
            // Send the token identifier to your server to create a Charge...
            // If the server responds successfully, set self.paymentSucceeded to YES
            let url = URL(string:"http://thomastai.com:3000/pay")
                guard let apiUrl = url else {
                    print("Error creating url")
                    return
                }

                var request = URLRequest(url: apiUrl)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")

                // Stripe doesn't allow decimal, so have to convert the amount
                // into cents by multiplying by 100
                let body:[String : Any] = ["stripeToken" : tokenID,
                                           "amount" : self.getCartTotalForStripe(),
                                           "description" : "Food"]

                // Convert the body to JSON
                try? request.httpBody = JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)

                // Make an HTTP request to our backend
                let task = URLSession.shared.dataTask(with: request) {data, response, error in
                    guard error == nil else {
                        print (error!)
                        completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                        return
                    }

                    guard let response = response else {
                        print ("Empty or erronous response")
                        completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                        return
                    }
                    
                    print (response)
                    
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        // Once the payment is successful, show the user that the purchase has been successful
                        self.paymentSucceeded = true
                        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
                    } else {
                        completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                    }
                }

                task.resume()
            }
            
            self.paymentSucceeded = true
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        // Dismiss payment authorization view controller
        print("Test")
        dismiss(animated: true, completion: {
            if (self.paymentSucceeded) {
                //Prepare data for submission to database
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                let formatedDate = formatter.string(from: date)
                let price = self.getCartTotal().stringValue
                let user = Auth.auth().currentUser
                //Add information to Firestore DB
                if (user != nil) {
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("orders").addDocument(data: [
                        "userID": user!.uid,
                        "orderDate": formatedDate,
                        "orderPrice": price,
                        "restaurauntID": "0"
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                }
                //Empty cart
                orderedItems = []
                //Reload table
                self.cartTableView.reloadData()
                // Show a confirmation page
                self.showPopOver()
            } else {
                //Something went wrong, display an error
                self.showAlert(title: "Payment not Successful", alertMessage: "An error has occured")
            }
        })
    }
    
    func showPopOver(){
        //Shows success message
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "popupVC")
        self.present(controller, animated: true, completion: nil)
    }
    
    func getCartTotalForStripe() -> Int{
        //Displays total multiplied by 100, Ex. $3.00 = 300
        var total: Float = 0
        for item in orderedItems{
            total = total + (item.price * Float(item.quantity))
        }
        return Int(total * 100)
    }
    
    func showAlert(title: String, alertMessage: String){
        //Shows popup alert with given content to user
        let alertController = UIAlertController(title: NSLocalizedString(title,comment:""), message: NSLocalizedString(alertMessage,comment:""), preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:     NSLocalizedString("Ok", comment: ""), style: .default, handler: { (pAlert) in
                        //Do whatever you wants here
                })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
