//
//  MockExercisesServiceProvider.swift
//  FitnessWikiTests
//
//  Created by AbdooMaaz's playground on 28.06.22.
//
@testable import FitnessWiki
import Foundation

final class MockExercisesServiceProvider: ExercisesServiceProviderInterface {

    var invokedFetchExercises = false
    var invokedFetchExercisesCount = 0
    var invokedFetchExercisesParameters: (req: ExercisesListRequest, Void)?
    var invokedFetchExercisesParametersList = [(req: ExercisesListRequest, Void)]()

    func fetchExercises(req: ExercisesListRequest) {
        invokedFetchExercises = true
        invokedFetchExercisesCount += 1
        invokedFetchExercisesParameters = (req, ())
        invokedFetchExercisesParametersList.append((req, ()))
    }
}
