//
//  LoginController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 11/21/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit
import Firebase
import AuthenticationServices
import CryptoKit

@available(iOS 13.0, *)
extension LoginController: ASAuthorizationControllerDelegate {

  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let nonce = currentNonce else {
        fatalError("Invalid state: A login callback was received, but no login request was sent.")
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        return
      }
      // Initialize a Firebase credential.
      let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                idToken: idTokenString,
                                                rawNonce: nonce)
      // Sign in with Firebase.
      Auth.auth().signIn(with: credential) { (authResult, error) in
        if (error != nil) {
          // Error. If error.code == .MissingOrInvalidNonce, make sure
          // you're sending the SHA256-hashed nonce as a hex string with
          // your request to Apple.
          print(error!.localizedDescription)
          return
        }
        // User is signed in to Firebase with Apple.
        // ...
        print("User successfully signed in with Apple")
        self.transitionToHome()
      }
    }
  }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
    print("Sign in with Apple errored: \(error)")
  }

}

class LoginController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    fileprivate var currentNonce: String?
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 5;
        registerButton.layer.cornerRadius = 5;
        setupProviderLoginView()
        print("Hello");
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: ASAuthorizationAppleIDButton.ButtonType.signIn, authorizationButtonStyle: ASAuthorizationAppleIDButton.Style.white)
        authorizationButton.addTarget(self, action: #selector(startSignInWithAppleFlow), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc @available(iOS 13, *)
    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self as ASAuthorizationControllerDelegate
        authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
      authorizationController.performRequests()
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }

    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if length == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if validateFields(){
            let email = emailTextField.text!
            let password = passwordTextField.text!
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let user = authResult?.user {
                    print(user)
                    self.transitionToHome()
                }
                else{
                    self.showAlert(title: "Error", alertMessage: "Login not successful");
                }
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        if validateFields(){
            let email = emailTextField.text!
            let password = passwordTextField.text!
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                print(user)
                self.showAlert(title: "Message", alertMessage: "Registration successful");
                self.transitionToHome()
            }
            else{
                self.showAlert(title: "Error", alertMessage: "Unable to create user");
            }
            }
        }
    }
    
    func showAlert(title: String, alertMessage: String){
        let alertController = UIAlertController(title: NSLocalizedString(title,comment:""), message: NSLocalizedString(alertMessage,comment:""), preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:     NSLocalizedString("Ok", comment: ""), style: .default, handler: { (pAlert) in
                        //Do whatever you wants here
                })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validateFields() -> Bool {
        let email = emailTextField.text
        let password = passwordTextField.text
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if(NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)){
            if(password!.count >= 8){
                return true
            }
            else{
                showAlert(title: "Error", alertMessage: "Password must be at least 8 characters long")
                return false
            }
        }
        else{
            showAlert(title: "Error", alertMessage: "Invalid Email")
            return false
        }
    }
    
    func transitionToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        self.present(controller, animated: true, completion: nil)
    }


}

