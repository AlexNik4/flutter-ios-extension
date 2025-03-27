//
//  PacketTunnelProvider.swift
//  MyNetworkExtension
//
//  Created by Alex Niko on 3/26/25.
//

import NetworkExtension
import Flutter

class PacketTunnelProvider: NEPacketTunnelProvider {
    private var flutterEngine: FlutterEngine?
    private var methodChannel: FlutterMethodChannel?

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        NSLog("XXXX Tunnel STARTED!!!!!!!!")
        
        // Initialize Flutter engine
        self.flutterEngine = FlutterEngine(
            name: "extension_engine",
            project: nil,
            allowHeadlessExecution: true
        )
        
        guard let engine = self.flutterEngine else {
            NSLog( "XXXX Failed to create Flutter engine")
            completionHandler(nil)
            return
        }
        
        NSLog("XXXX Flutter engine created successfully")
        
        // Start engine with error handling
        if !engine.run(
            withEntrypoint: "mainHeadless",
            libraryURI: "package:flutter_ios_extension/headless.dart"
        ) {
            NSLog("XXXX Failed to run Flutter engine")
            completionHandler(nil)
            return
        }
        
        NSLog("XXXX Flutter engine started successfully")
        
         self.methodChannel = FlutterMethodChannel(
             name: "com.example.flutterIosExtension/my_channel",
             binaryMessenger: engine.binaryMessenger
         )
        
         NSLog("XXXX Sending message to Flutter...")
        
         methodChannel?.invokeMethod("getData", arguments: nil) { response in
             NSLog("XXXX Received: \(response ?? "")")
         }
        
        NSLog("XXXX start completed")
        completionHandler(nil)
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        NSLog("XXXX Tunnel STOPPED!!!!!!!!")
        self.flutterEngine?.destroyContext()
        completionHandler()
    }
    
    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Add code here to handle the message.
        if let handler = completionHandler {
            handler(messageData)
        }
    }
    
    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
    }
    
    override func wake() {
        // Add code here to wake up.
    }
}
