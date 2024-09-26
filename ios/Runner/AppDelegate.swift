import UIKit
import Firebase
import GoogleSignIn

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // تكوين Firebase
    FirebaseApp.configure()

    // تكوين Google Sign-In
    let signInConfig = GIDConfiguration(clientID: "629900219506-qo42vm94bi3k9cvd67a0g5o4uhtu0m5u.apps.googleusercontent.com")
    GIDSignIn.sharedInstance.configuration = signInConfig

    // تسجيل الإضافات المولدة
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    // معالجة عودة المستخدم بعد تسجيل الدخول باستخدام Google
    return GIDSignIn.sharedInstance.handle(url)
  }
}
