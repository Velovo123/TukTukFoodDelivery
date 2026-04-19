
//
//  TaxiViewModel.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI
import MapKit

@Observable
final class TaxiViewModel {
    
    var order = TaxiOrder()
    var isLoading = false
    var errorMessage: String?
    
    var coordinate = CLLocationCoordinate2D(
        latitude: 49.8038,
        longitude: 24.9014
    )

    var mapPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 49.8038,
                longitude: 24.9014
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    )
    
    var isFormValid: Bool {
        !order.pickupAddress.isEmpty &&
        !order.destinationAddress.isEmpty
    }
    
    func callTaxi() async {
        guard isFormValid else { return }
        isLoading = true
        defer { isLoading = false }
        
        try? await Task.sleep(for: .seconds(1))
    }
}
