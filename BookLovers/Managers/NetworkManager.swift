//
//  NetworkManager.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI
import Network

public enum NetworkStatus: String {
    case connected
    case disconnected
}

public enum NetworkType: String {
    case wifi
    case cellular
    case wiredEthernet
    case other
}

public final class NetworkManager: ObservableObject {
    
    // MARK: - Publishers
    
    @Published public var isMonitoring = false
    @Published public var status: NetworkStatus = .disconnected
    @Published public var isConnected = false
    
    // MARK: - Public properties
    
    public var networkType: NetworkType? {
        guard let monitor = monitor else { return nil }
        let type = monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type
       return getNetworkType(interFaceType: type)
    }
    
    // MARK: - Private properties
    
    private var monitor: NWPathMonitor?
    private var pathStatus = NWPath.Status.requiresConnection
    private var isStatusSatisfied: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    private var availableNetworkTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    // MARK: - Lifecycle
    
    public init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    // MARK: - Public methods
    
    public func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkStatus_Monitor")
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if self.pathStatus != path.status {
                    self.pathStatus = path.status
                    self.status = self.pathStatus == .satisfied ? .connected : .disconnected
                    self.isConnected = self.status == .connected ? true : false
                }
            }
        }
        isMonitoring = true
    }
    
    public func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
    }
    
    // MARK: - Private methods
    
    private func getNetworkType(interFaceType: NWInterface.InterfaceType?) -> NetworkType {
        switch interFaceType {
        case .wifi:
            return .wifi
        case .cellular:
            return .cellular
        case .wiredEthernet:
            return .wiredEthernet
        default:
            return .other
        }
    }
}
