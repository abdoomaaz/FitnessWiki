//
//  ExercisesListTableViewCell.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import UIKit

protocol ExercisesListTableViewCellInterface: AnyObject {
    func setExerciseName(_ text: String)
    func setTargetedMuscle(_ text: String)
    func setExerciseType(_ text: String)
    func setDifficulty(_ text: String)

}

final class ExercisesListTableViewCell: UITableViewCell {
    @IBOutlet private weak var exerciseName: UILabel!
    
    // Used buttons instead of labels as they will be used filter exercises in upcoming features
    @IBOutlet private weak var targetedMuscle: UIButton!
    @IBOutlet private weak var exerciseType: UIButton!
    @IBOutlet private weak var difficulty: UIButton!
    
    var vm: ExercisesListTableViewCellViewModelInterface! {
        didSet {
            vm.load()
        }
    }
}

// MARK: - ExercisesListTableViewCellInterface implementation
extension ExercisesListTableViewCell: ExercisesListTableViewCellInterface {
    func setDifficulty(_ text: String) {
        self.difficulty.setTitle(text, for: .normal)
    }
    
    func setTargetedMuscle(_ text: String) {
        self.targetedMuscle.setTitle(text, for: .normal)
    }
    
    func setExerciseType(_ text: String) {
        self.exerciseType.setTitle(text, for: .normal)
    }
    
    func setExerciseName(_ text: String) {
        self.exerciseName.text = text
    }
}
