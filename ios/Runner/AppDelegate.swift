import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyDmTTd3yiTiyosQb_CYX2Ync20v-xiynYg")
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*30))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
