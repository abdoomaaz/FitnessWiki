//
//  ExercisesListTableViewCellViewModel.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import Foundation

protocol ExercisesListTableViewCellViewModelInterface {
    func load()
}


final class ExercisesListTableViewCellViewModel {
    let exercise: Exercise
    weak var view: ExercisesListTableViewCellInterface?
    
    init(exercise: Exercise, view: ExercisesListTableViewCellInterface) {
        self.exercise = exercise
        self.view = view
    }
}

// MARK: - ExercisesListTableViewCellViewModelInterface implementation
extension ExercisesListTableViewCellViewModel: ExercisesListTableViewCellViewModelInterface {
    func load() {
        view?.setExerciseName(exercise.name)
    }
}

