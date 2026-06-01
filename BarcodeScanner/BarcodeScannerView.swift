//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Manuel Alejandro Rey Cruz on 29/05/26.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationView{
            VStack{
                Rectangle()
                    .frame(maxWidth: .infinity , maxHeight: 300)
                
                Spacer()
                    .frame(height: 60)
                
                Label("Scann barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text("Not Yet Scanned")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
            }.navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
