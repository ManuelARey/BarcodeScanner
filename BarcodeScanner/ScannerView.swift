//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Manuel Alejandro Rey Cruz on 01/06/26.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedBarcode: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        private let scannerView: ScannerView
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        func didFind(bardCode: String) {
            scannerView.scannedBarcode = bardCode
        }
        
        func showError(error: CamaraError) {
            print(error.rawValue)
        }
        
        
    }
    
}

#Preview {
    ScannerView(scannedBarcode: .constant("1234"))
}
