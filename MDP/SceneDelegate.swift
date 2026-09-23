//
//  SceneDelegate.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var isInternetAvailable: Bool = true
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let networkManager: NetworkProtocol = NetworkManager.shared
        
        let viewModel: MovieViewModelProtocol
        
        if isInternetAvailable {
            viewModel = MovieViewModel(objNetwork: networkManager)
        } else {
            viewModel = MockMovieViewModel()
        }
        
        let movieViewController = MovieViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: movieViewController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        /* SceneDelegate acts as the composition point where I create and connect the dependencies. I get the shared NetworkManager as a NetworkProtocol, inject it into MovieViewModel, then inject that ViewModel as a MovieViewModelProtocol into MovieViewController. This keeps the ViewModel and ViewController from creating their own dependencies.
         
         To test dependency injection, I can inject MockMovieViewModel instead of the real MovieViewModel in SceneDelegate. The ViewController does not need to change because it depends only on MovieViewModelProtocol. The mock provides predefined data without using NetworkManager, URLSession, or the real API.
          
         I declare viewModel outside the if/else using the protocol type. Depending on the condition, I assign either the real MovieViewModel or MockMovieViewModel. Since both conform to MovieViewModelProtocol, the same MovieViewController can accept either implementation without changing its code.
         
         */
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

