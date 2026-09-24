import Flutter
import UIKit

public class SecureAppSwitcherPlugin: NSObject, FlutterPlugin {
  private var secureView: UIView?

  private enum SecureMaskStyle: Int {
    case light = 0
    case dark = 1
    case blurLight = 2
    case blurDark = 3
  }

  private func createSecureView(styleIdx: Int? = nil) {
    switch styleIdx {
    case SecureMaskStyle.light.rawValue:
      secureView = UIView()
      secureView?.backgroundColor = UIColor.white
    case SecureMaskStyle.dark.rawValue:
      secureView = UIView()
      secureView?.backgroundColor = UIColor.black
    case SecureMaskStyle.blurLight.rawValue:
      secureView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    case SecureMaskStyle.blurDark.rawValue:
      secureView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    default:
      secureView = nil
    }
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "secure_app_switcher",
      binaryMessenger: registrar.messenger()
    )
    let instance = SecureAppSwitcherPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "on":
      if let args = call.arguments as? [String: Any],
         let style = args["style"] as? Int {
        createSecureView(styleIdx: style)
      }
      result(nil)
    case "off":
      createSecureView()
      result(nil)
    default:
      createSecureView()
      result(FlutterMethodNotImplemented)
    }
  }

  public func applicationDidBecomeActive(_ application: UIApplication) {
    secureView?.removeFromSuperview()
  }

  public func applicationWillResignActive(_ application: UIApplication) {
    let window = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap(\.windows)
      .first { $0.isKeyWindow }
    if let window, let view = secureView {
      view.frame = window.bounds
      window.addSubview(view)
    }
  }
}