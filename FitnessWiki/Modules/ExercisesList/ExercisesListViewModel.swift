//
//  ExercisesListViewModel.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import Foundation

protocol ExercisesListViewModelInterface {
    func load()
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
    func load() {
        view?.prepareTableView()
        fetchExercises()
    }
}

// MARK: - Fetch Exercises
extension ExercisesListViewModel {
    func fetchExercises() {
        let request = ExercisesListRequest(params: [:], headers: ["X-Api-Key":"API_KEY"])
        provider?.fetchExercises(req: request)
    }
}

// MARK: - ExercisesServiceProviderOutput implementation
extension ExercisesListViewModel: ExercisesServiceProviderOutput {
    func handleExercisesResult(_ result: ExercisesListResult) {
        switch result {
        case .success(let exercises): print(exercises)
        case .failure(let err):
            print(err)
        }
    }
}

