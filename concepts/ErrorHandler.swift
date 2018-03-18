// MARK: - Convenient error handling in the project

protocol AppError: Error {
    var title: String { get }
    var description: String { get }
}

enum ApiError: AppError {
    case invalidToken
    case invalidAppError
    case serverError
    case other(message: String)

    var title: String {
        return "Error"
    }

    var description: String {
        switch self {
        case .invalidToken:
	        return "Invalid credentials. Please log in again"
	    case .invalidAppError:
	        return "Your app is out of date. Please update it"
        default:
            return "Unexpected error. Please try again"
    }
}

protocol ErrorPresentable {
    func presentError(_ error: Error)
}

extension ErrorPresentable where Self: UIViewController {
    func presentError(_ error: Error) {
        if let appError = error as? AppError {
            let title = appError.title
            let message = appError.description
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: nil)
            alertController.addAction(dismissAction)
            present(alertController, animated: true)
        } else {
            print(error)
        }
    }
}
