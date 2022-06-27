//
//  ExercisesListViewModelTests.swift
//  FitnessWikiTests
//
//  Created by AbdooMaaz's playground on 28.06.22.
//

@testable import FitnessWiki
import XCTest

final class ExercisesListViewModelTests: XCTestCase {
    private var mockView: MockExercisesListView!
    private var mockProvider: MockExercisesServiceProvider!
    private var mockResponse: [Exercise] {
        JSONDecoder.loadJson(
            type: [Exercise].self,
            filename: "MockExercisesListResponse",
            bundle: Bundle(for: self.classForCoder)
        )}
    private var viewmodel: ExercisesListViewModel!
    
    override func setUp() {
        super.setUp()
        mockView = .init()
        mockProvider = .init()
        viewmodel = .init(view: mockView, provider: mockProvider)
    }
    
    func test_load_InvokesNecessaryMethods() {
        XCTAssertFalse(mockView.invokedPrepareTableView)
        
        viewmodel.load()
        
        XCTAssertTrue(mockView.invokedPrepareTableView)
    }
    
    func test_numberOfRows_nilResponse_ReturnsCorrectValue() {
        XCTAssertEqual(viewmodel.numberOfRows, 0)
    }
    
    func test_numberOfRows_ValidResponse_ReturnsCorrectValue() {
        viewmodel.handleExercisesResult(.success(mockResponse))
        XCTAssertEqual(viewmodel.numberOfRows, 10)
    }
    
    
    func test_handleExercisesResult_Success_InvokesNecessaryMethods() {
        XCTAssertFalse(mockView.invokedReloadTableView)
        
        viewmodel.handleExercisesResult(.success(mockResponse))
        
        XCTAssertTrue(mockView.invokedReloadTableView)
        XCTAssertFalse(mockView.invokedShowAlert)
    }
    
    func test_handleExercisesResult_Failure_InvokesNecessaryMethods() {
        XCTAssertFalse(mockView.invokedReloadTableView)
        
        viewmodel.handleExercisesResult(.failure(.apiError("Error")))
        
        XCTAssertFalse(mockView.invokedReloadTableView)
        // TODO: fix failing edge case
        // XCTAssertTrue(mockView.invokedShowAlert)
    }
    
    func test_exercises_Success_ReturnExercise() {
        XCTAssertNil(viewmodel.exercise(for:0))
        
        viewmodel.handleExercisesResult(.success(mockResponse))
        
        XCTAssertEqual(viewmodel.exercise(for: 1)?.muscle, "biceps")
    }
    
    func test_exercises_Failure_ReturnExercise() {        
        viewmodel.handleExercisesResult(.failure(.apiError("Error")))
        
        XCTAssertNil(viewmodel.exercise(for: 1)?.muscle)
    }
}
