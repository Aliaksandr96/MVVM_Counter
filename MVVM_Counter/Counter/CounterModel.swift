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
    init() {
        configureBundings()
    }
    
    // MARK: - Configure Bundings
    private func configureBundings() {
        incrementActionSubject
            .sink(receiveValue: { [weak self] in
                self?.counter += 1
                self?.counterTitleSubject.send("Counter - \(self?.counter ?? 0)")
            })
            .store(in: &cancellables)
        
        decrementActionSubject
            .sink(receiveValue: { [weak self] in
                self?.counter -= 1
                self?.counterTitleSubject.send("Counter - \(self?.counter ?? 0)")
            })
            .store(in: &cancellables)
        
        multiplyActionSubject
            .sink(receiveValue: { [weak self] in
                    self?.counter *= 2
                self?.counterTitleSubject.send("Counter - \(self?.counter ?? 0)")
            })
            .store(in: &cancellables)
     
        resetActionSubject
            .sink(receiveValue: { [weak self] in
                self?.counter = 0
                self?.counterTitleSubject.send("Counter - \(self?.counter ?? 0)")
            })
            .store(in: &cancellables)
    }
}
