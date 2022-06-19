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
    
    init(view: ExercisesListViewInterface, provider: ExercisesServiceProviderInterface ){
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

// MARK: - Fetch Exercises
extension ExercisesListViewModel {
    func fetchExercises() {
        if !ExercisesListViewModel.didFetchVehicles {
            guard let apiKey = Constants.apiNinjaKey else {return}
            let request = ExercisesListRequest(params: ["offset": ExercisesListViewModel.offSet], headers: [Constants.apiHeaderKey: apiKey])
            provider?.fetchExercises(req: request)
            ExercisesListViewModel.offSet += 10
        }
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
        case .failure(let err):
            print(err)
        }
    }
}

// MARK: - TableView Delegate
extension ExercisesListViewModel: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < 7 {
            fetchExercises()
            ExercisesListViewModel.didFetchVehicles = true
        }
    }
}

// MARK: - Constants
private extension ExercisesListViewModel {
    enum Constants {
        static let apiNinjaKey = Bundle.main.infoDictionary?["API_NINJA_KEY"] as? String ?? nil
        static let apiHeaderKey = "X-Api-Key"
    }
}
