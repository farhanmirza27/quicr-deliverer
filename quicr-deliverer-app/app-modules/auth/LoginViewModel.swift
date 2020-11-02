//
//  LoginViewModel.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//


protocol LoginViewModelDelegate {
    func success()
    func failure(message : String)
}

class LoginViewModel {
    
    var delegate : LoginViewModelDelegate?
    
    func loginIn(email : String, password : String) {
        FirebaseClient.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success(_):
                self.delegate?.success()
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}
