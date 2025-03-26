import Flutter
import UIKit
import NetworkExtension

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let extensionIdentifier = "com.example.flutterIosExtension.MyNetworkExtension"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        startTestTunnel()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func startTestTunnel() {
        NETunnelProviderManager.loadAllFromPreferences { managers, error in
            let tunnelManager = managers?.first ?? NETunnelProviderManager()
            tunnelManager.localizedDescription = "Test Tunnel"

            let protocolConfig = NETunnelProviderProtocol()
            protocolConfig.providerBundleIdentifier = self.extensionIdentifier
            protocolConfig.serverAddress = "1.1.1.1"
            protocolConfig.username = "test"
            protocolConfig.passwordReference = Data()

            tunnelManager.protocolConfiguration = protocolConfig
            tunnelManager.isEnabled = true

            tunnelManager.saveToPreferences { saveError in
                if let saveError = saveError {
                    print("XXXX Save error: \(saveError)")
                    return
                }
                
                tunnelManager.loadFromPreferences { _ in
                    do {
                        try tunnelManager.connection.startVPNTunnel(options: [
                            "username": "test" as NSObject,
                            "password": "test" as NSObject
                        ])
                        print("XXXX Tunnel started successfully!")
                    } catch {
                        print("XXXX Start error: \(error)")
                    }
                }
            }
        }
    }
}
