//
//  ExercisesServiceProvider.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import Foundation

typealias ExercisesListResult = Result<[Exercise],NetworkError>

protocol ExercisesServiceProviderOutput: AnyObject {
    func handleExercisesResult(_ result: ExercisesListResult )
}

protocol ExercisesServiceProviderInterface: AnyObject {
    func fetchExercises(req: ExercisesListRequest)
}

final class ExercisesServiceProvider {
    weak var output: ExercisesServiceProviderOutput?
    private var networkManger = NetworkManger()
}

// MARK: - ExercisesServiceProviderInterface Implementation
extension ExercisesServiceProvider: ExercisesServiceProviderInterface {
    func fetchExercises(req: ExercisesListRequest) {
        networkManger.request(endpoint: ExerciseEndpoint.exersicesList(request: req), type: [Exercise].self) { [weak self] result in
            self?.output?.handleExercisesResult(result)
        }
    }
}
