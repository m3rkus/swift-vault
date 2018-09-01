// MARK: - State Protocols
protocol SuccessStatable {
  func setSuccessState()
}

protocol LoadingStatable {
  func setLoadingState()
}

protocol ErrorStatable {
  func setErrorState(error: Error)
}

// MARK: - Default States
class DefaultLoadingState: LoadingStatable {
	let viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func setLoadingState() {
		viewController.view = DefaultLoadingView()
	}
}

class DefaultErrorState: ErrorStatable {
	let viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func setErrorState(error: Error) {
		viewController.view = DefaultErrorView(error: error)
	}
}

// MARK: - Usage, overload specific state if needed
class MyViewController: UIViewController, SuccessStatable, LoadingStatable, ErrorStatable {

  func setSuccessState() {
    //e.g. stop loading, enable buttons actions or stop animating
  }

  func setLoadingState() {
    //e.g. show loading, disable buttons actions or start animating
  }

  func setErrorState(error: Error) {
    //e.g. Build and alert to show error
  }
}
