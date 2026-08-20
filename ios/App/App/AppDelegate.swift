import UIKit
import Capacitor
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    let nativeLocationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 1. Cấu hình bộ định vị Native độ chính xác cao nhất cho dẫn đường
        nativeLocationManager.delegate = self
        nativeLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        nativeLocationManager.distanceFilter = 2 // Bắt tọa độ mỗi khi di chuyển từ 2 mét
        
        // 2. Ép buộc iOS KHÔNG ĐƯỢC TẮT GPS khi khóa màn hình
        nativeLocationManager.pausesLocationUpdatesAutomatically = false
        nativeLocationManager.allowsBackgroundLocationUpdates = true
        nativeLocationManager.showsBackgroundLocationIndicator = true
        
        // 3. Yêu cầu quyền luôn luôn chạy ngầm
        nativeLocationManager.requestAlwaysAuthorization()
        nativeLocationManager.startUpdatingLocation()

        return true
    }

    // Hàm nhận tọa độ Native liên tục từ vệ tinh để giữ ứng dụng luôn thức
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // iOS duy trì tiến trình chạy ngầm liên tục
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return ApplicationDelegateProxy.shared.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
}
