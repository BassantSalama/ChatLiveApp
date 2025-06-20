
import FirebaseAuth
import FirebaseFirestore

class RegisterUseCase: RegisterUseCaseProtocol {
    func execute(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                let uid = user.uid
                let email = user.email ?? ""
                let name = email.components(separatedBy: "@").first ?? "User"
                
                let userData: [String: Any] = [
                    "id": uid,
                    "email": email,
                    "name": name,
                    "imageURL": ""
                ]
                Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .setData(userData) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
            }
        }
    }
}
