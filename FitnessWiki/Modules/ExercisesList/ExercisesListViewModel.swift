//
//  ExercisesListViewModel.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import Foundation

protocol ExercisesListViewModelInterface {
    var numberOfRows: Int { get }
    func load()
    func exercise(for index: Int) -> Exercise?
}


final class ExercisesListViewModel {
    private weak var view: ExercisesListViewInterface?
    private let provider: ExercisesServiceProviderInterface?
    private var exercises: [Exercise]?
    
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
        guard let apiKey = Constants.apiNinjaKey else {return}
        let request = ExercisesListRequest(params: [:], headers: [Constants.apiHeaderKey: apiKey])
        provider?.fetchExercises(req: request)
    }
}

// MARK: - ExercisesServiceProviderOutput implementation
extension ExercisesListViewModel: ExercisesServiceProviderOutput {
    func handleExercisesResult(_ result: ExercisesListResult) {
        switch result {
        case .success(let exercises):
            self.exercises = exercises
            view?.reloadTableView()
        case .failure(let err):
            print(err)
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
