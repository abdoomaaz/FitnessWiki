//
//  ExercisesListViewModel.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import UIKit
import Foundation

protocol ExercisesListViewModelInterface {
    var numberOfRows: Int { get }
    func load()
    func exercise(for index: Int) -> Exercise?
}


final class ExercisesListViewModel: NSObject {
    private weak var view: ExercisesListViewInterface?
    private let provider: ExercisesServiceProviderInterface?
    private var exercises: [Exercise]?
    
    private static var didFetchVehicles = false
    private static var offSet = 0
    
    init(view: ExercisesListViewInterface, provider: ExercisesServiceProviderInterface) {
        self.view = view
        self.provider = provider
    }
}


// MARK: - ExercisesListViewModelInterface implementation
extension ExercisesListViewModel: ExercisesListViewModelInterface {
    var numberOfRows: Int { exercises?.count ?? 0 }
    
    func load() {
        view?.prepareTableView()
        fetchExercises()
    }
    
    func exercise(for index: Int) -> Exercise? {
        exercises?[safe: index]
    }
}


// MARK: - ExercisesServiceProviderOutput implementation
extension ExercisesListViewModel: ExercisesServiceProviderOutput {
    func handleExercisesResult(_ result: ExercisesListResult) {
        switch result {
        case .success(let response):
            if var exercises = self.exercises {
                exercises += response
                self.exercises = exercises
                
            } else {
                self.exercises = response
            }
            view?.reloadTableView()
            ExercisesListViewModel.didFetchVehicles = false
            
        case .failure(let error):
            switch error {
            case .apiError(let errorMessage):
                if let message = errorMessage {
                    forwardAlert(title: Constants.loadingErrorTitle, message: message)
                }
            case .decodingError, .urlError:
                forwardAlert(title: Constants.loadingErrorTitle, message: Constants.internalErrorMsg)
            }
        }
    }
}

// MARK: - TableView Delegate
extension ExercisesListViewModel: UITableViewDelegate {
    // A trick to load more exercies when the user reaches the bottom of the tableview,
    // numberOfRows != 0 is crucial so the user doesn't spam requests by taping on the view TODO: find a better solution maybe prefetching?
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if numberOfRows != 0 && scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < 7 {
            fetchExercises()
        }
    }
}

// MARK: - Private Functions
private extension ExercisesListViewModel {
    func fetchExercises() {
        if !ExercisesListViewModel.didFetchVehicles {
            guard let apiKey = Constants.apiNinjaKey else {
                forwardAlert(title: Constants.internalErrorTitle , message: Constants.internalErrorMsg )
                NSLog("API-Key is nil, check for typos?")
                return
            }
            
            let request = ExercisesListRequest(params: ["offset": ExercisesListViewModel.offSet], headers: [Constants.apiHeaderKey: apiKey])
            provider?.fetchExercises(req: request)
            ExercisesListViewModel.didFetchVehicles = true
            ExercisesListViewModel.offSet += 10
        }
    }
    
    func forwardAlert(title: String, message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self?.view?.showAlert(alert, animated: true)
        }
    }
}

// MARK: - Constants
private extension ExercisesListViewModel {
    enum Constants {
        static let apiNinjaKey = Bundle.main.infoDictionary?["API_NINJA_KEY"] as? String ?? nil
        static let apiHeaderKey = "X-Api-Key"
        static let loadingErrorTitle = "Loading Error"
        static let internalErrorTitle = "Internal app error"
        static let internalErrorMsg = "please check the documentation or contact the owner"
    }
}
