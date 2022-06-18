//
//  ExercisesListTableViewCell.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import UIKit

protocol ExercisesListTableViewCellInterface: AnyObject {
    func setExerciseName(_ text: String)
}

final class ExercisesListTableViewCell: UITableViewCell {
    @IBOutlet private weak var exerciseName: UILabel!
    
    private var vm: ExercisesListTableViewCellViewModel! {
        didSet {
            vm.load()
        }
    }
}

// MARK: - ExercisesListTableViewCellInterface implementation
extension ExercisesListTableViewCell: ExercisesListTableViewCellInterface {
    func setExerciseName(_ text: String) {
        self.exerciseName.text  = text
    }
}
