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
        vm = listVm
    }
}


// MARK: - ExercisesListViewInterface Implementation
extension ExercisesListViewController: ExercisesListViewInterface {
    func prepareTableView() {
        exercisesListTableView.delegate = self
        exercisesListTableView.dataSource = self
        exercisesListTableView.register(cellType: ExercisesListTableViewCell.self)
    }
    
    func reloadTableView() {
        exercisesListTableView.reloadData()
    }
}

//MARK: - TabelViewDelegate
extension ExercisesListViewController: UITableViewDelegate {}

//MARK: - TableViewDataSource
extension ExercisesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ExercisesListTableViewCell.self, for: indexPath)
//        let cellVm = ExercisesListTableViewCellViewModel(exercise: <#T##Exercise#>, view: cell)
        return cell
    }
    
    
}
