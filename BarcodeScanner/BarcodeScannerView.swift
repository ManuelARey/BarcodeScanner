//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Manuel Alejandro Rey Cruz on 29/05/26.
//

import SwiftUI
struct BarcodeScannerView: View {
    @State private var barCode =  ""

    var body: some View {
        NavigationView{
            VStack{
                ScannerView(scannedBarcode: $barCode)
                    .frame(maxWidth: .infinity , maxHeight: 300)
                
                Spacer()
                    .frame(height: 60)
                
                Label("Scann barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(barCode.isEmpty ? "Not Yet Scanned" : barCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(barCode.isEmpty ? .red : .green)
                    .padding()
            }.navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
