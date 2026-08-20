import UIKit
import Capacitor
import CoreLocation

@UIApplicationMain
class AppDelegate: CAPBridgeAppDelegate, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 1. Khởi tạo bộ định vị Native
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager?.distanceFilter = 2
        
        // 2. Cấu hình chạy ngầm liên tục khi khóa màn hình
        self.locationManager?.pausesLocationUpdatesAutomatically = false
        self.locationManager?.allowsBackgroundLocationUpdates = true
        self.locationManager?.showsBackgroundLocationIndicator = true
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.startUpdatingLocation()

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Tiến trình nhận GPS ngầm được duy trì liên tục
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
    }

    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return ApplicationDelegateProxy.shared.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
}
