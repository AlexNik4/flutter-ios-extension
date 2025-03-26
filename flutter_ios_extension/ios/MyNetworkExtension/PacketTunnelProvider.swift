//
//  PacketTunnelProvider.swift
//  MyNetworkExtension
//
//  Created by Alex Niko on 3/26/25.
//

import NetworkExtension

class PacketTunnelProvider: NEPacketTunnelProvider {

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        NSLog("XXXX Tunnel started!!!!!!!!")
        
        let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "1.1.1.1")
        settings.ipv4Settings = NEIPv4Settings(addresses: ["192.168.1.100"], subnetMasks: ["255.255.255.0"])
        settings.mtu = 1400
        
        self.setTunnelNetworkSettings(settings) { error in
            if let error = error {
                completionHandler(error)
                return
            }
            
            self.reasserting = true
            completionHandler(nil)
        }
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Add code here to start the process of stopping the tunnel.
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
