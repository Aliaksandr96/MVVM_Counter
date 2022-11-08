import UIKit
import Combine
import EasyAutolayout

final class CounterView: UIViewController {
    // MARK: Public
    var viewModel: CounterModel!
    
    // MARK: Private
    private let counterLabel = UILabel()
    private let incrementButton = UIButton()
    private let decrementButton = UIButton()
    private let multiplyButton = UIButton()
    private let resetButton = UIButton()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
        setupBehavior()
        configureBindings()
    }
    // MARK: - API
    private func configureBindings(){
        viewModel.counterTitleSubject
            .assign(to: \.text!, on: counterLabel)
            .store(in: &cancellables)
    }
    
    // MARK: - Setups
    private func setupSubviews() {
        [counterLabel, incrementButton, decrementButton, multiplyButton, resetButton].forEach { view.addSubview($0) }
    }
    private func setupConstraints() {
        counterLabel.pin.center(in: view).leading(to: view, offset: 20).trailing(to: view, offset: 20)
        incrementButton.pin.centerX(in: view).below(of: counterLabel, offset: 40).width(to: 150).height(to: 40)
        decrementButton.pin.centerX(in: view).below(of: incrementButton, offset: 20).width(to: 150).height(to: 40)
        multiplyButton.pin.centerX(in: view).below(of: decrementButton, offset: 20).width(to: 150).height(to: 40)
        resetButton.pin.centerX(in: view).below(of: multiplyButton, offset: 20).width(to: 150).height(to: 40)
    }
    private func configureUI() {
        view.backgroundColor = .white

        counterLabel.text = "Counter - 0"
        counterLabel.textAlignment = .center

        incrementButton.setTitle("Increment", for: .normal)
        decrementButton.setTitle("Decrement", for: .normal)
        multiplyButton.setTitle("Multiply", for: .normal)
        resetButton.setTitle("Reset", for: .normal)
        
        [incrementButton, decrementButton, multiplyButton, resetButton].forEach { $0.layer.cornerRadius = 10 }
        [incrementButton, decrementButton, multiplyButton, resetButton].forEach { $0.backgroundColor = .darkGray }
        [incrementButton, decrementButton, multiplyButton, resetButton].forEach { $0.setTitleColor(.systemOrange, for: .normal)}
    }
    private func setupBehavior() {
        incrementButton.addTarget(self, action: #selector(incrementButtonDidTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementButtonDidTapped), for: .touchUpInside)
        multiplyButton.addTarget(self, action:  #selector(multiplyButtonDidTapped), for: .touchUpInside)
        resetButton.addTarget(self, action:  #selector(resetButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    @objc private func incrementButtonDidTapped() {
        viewModel.incrementActionSubject.send()
    }
    @objc private func decrementButtonDidTapped() {
        viewModel.decrementActionSubject.send()
    }
    @objc private func multiplyButtonDidTapped() {
        viewModel.multiplyActionSubject.send()
    }
    @objc private func resetButtonDidTapped() {
        viewModel.resetActionSubject.send()
    }
}
