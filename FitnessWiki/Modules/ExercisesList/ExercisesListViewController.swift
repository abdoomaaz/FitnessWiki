//
//  ExercisesListViewController.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import UIKit

protocol ExercisesListViewInterface: AnyObject {
    func prepareTableView()
    func reloadTableView()
}

final class ExercisesListViewController: UIViewController {
    @IBOutlet weak var exercisesListTableView: UITableView!
    
    private var vm: ExercisesListViewModelInterface! {
        didSet {
            vm?.load()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit() {
        let provider = ExercisesServiceProvider()
        let listVm = ExercisesListViewModel(view: self, provider: provider)
        provider.output = listVm
        exercisesListTableView.delegate = listVm
        vm = listVm
    }
}


// MARK: - ExercisesListViewInterface Implementation
extension ExercisesListViewController: ExercisesListViewInterface {
    func prepareTableView() {
        exercisesListTableView.dataSource = self
        exercisesListTableView.register(cellType: ExercisesListTableViewCell.self)
    }
    
    func reloadTableView() {
        exercisesListTableView.reloadData()
    }
}

//MARK: - TableViewDataSource
extension ExercisesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ExercisesListTableViewCell.self, for: indexPath)
        if let exercise = vm.exercise(for: indexPath.row) {
            let cellVm = ExercisesListTableViewCellViewModel(exercise: exercise, view: cell)
            cell.vm = cellVm
        }
        return cell
    }
}
