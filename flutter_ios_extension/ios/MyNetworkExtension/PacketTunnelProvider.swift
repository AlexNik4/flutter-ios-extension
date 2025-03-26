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
        self.flutterEngine = FlutterEngine(name: "extension_engine", project: nil, allowHeadlessExecution: true)
        
        guard let engine = self.flutterEngine else {
            NSLog( "XXXX Failed to create Flutter engine")
            completionHandler(NSError(domain: "FlutterExtension", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create Flutter engine"]))
            return
        }
        
        NSLog("XXXX Flutter engine created successfully")
        
        // Start engine with error handling
        if !engine.run(withEntrypoint: "main") {
            NSLog("XXXX Failed to run Flutter engine")
            completionHandler(NSError(domain: "FlutterExtension", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to run Flutter engine"]))
            return
        }
        
        NSLog("XXXX Flutter engine started successfully")
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        NSLog("XXXX Tunnel STOPPED!!!!!!!!")
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
