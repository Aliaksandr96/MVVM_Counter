import Combine

final class CounterModel {
    // MARK: - Properties
    let counterTitleSubject = CurrentValueSubject<String, Never>("Counter - 0")
    let incrementActionSubject = PassthroughSubject<Void, Never>()
    let decrementActionSubject = PassthroughSubject<Void, Never>()
    let multiplyActionSubject = PassthroughSubject<Void, Never>()
    let resetActionSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Private
    private var counter = 0
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    init() {}
    
    // MARK: - API
}
