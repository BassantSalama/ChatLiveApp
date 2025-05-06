

class RegisterViewModel {
    
    var onRegisterSuccess: (() -> Void)?
    var onRegisterFailure: ((String) -> Void)?
    
    private let registerUseCase: RegisterUseCaseProtocol
    
    init(registerUseCase: RegisterUseCaseProtocol = RegisterUseCase()) {
        self.registerUseCase = registerUseCase
    }
    
    func register(email: String, password: String, confirmPassword: String) {
        guard validate(email: email, password: password, confirmPassword: confirmPassword) else {
            onRegisterFailure?("Please enter valid data. Passwords must match and be at least 6 characters.")
            return
        }
        
        registerUseCase.execute(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.onRegisterSuccess?()
            case .failure(let error):
                self?.onRegisterFailure?(error.localizedDescription)
            }
        }
    }
    
    private func validate(email: String, password: String, confirmPassword: String) -> Bool {
        return !email.isEmpty &&
               email.contains("@") &&
               password.count >= 6 &&
               password == confirmPassword
    }
}

