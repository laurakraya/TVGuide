import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let screenFrame = UIScreen.main.bounds
           
        window = UIWindow(frame: screenFrame)
       
        let mainController = ShowsBuilder.buildShows()
       
        window?.rootViewController = UINavigationController(rootViewController: mainController)
       
        window?.makeKeyAndVisible()
        
        return true
    }




}

