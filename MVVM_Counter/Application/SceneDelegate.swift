import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        let view = CounterView()
        let viewModel = CounterModel()
        view.viewModel = viewModel
        let navigationController = UINavigationController()
        navigationController.pushViewController(view, animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
}

