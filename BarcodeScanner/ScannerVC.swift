//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Manuel Alejandro Rey Cruz on 29/05/26.
//

import UIKit
import AVFoundation


enum CamaraError: String{
    case invalidDeviceInput = "Hay un problema con la cámara. No podemos capturar la señal."
    case invalidScannedValue = "El valor escaneado no es valido. Esta aplicación solo escanea valores EAN-8 y EAN-13."
}

protocol ScannerVCDelegate: class {
    func didFind(bardCode: String)
    func showError(error: CamaraError)
}


final class ScannerVC: UIViewController{
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?
    
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: <#T##String?#>, bundle: <#T##Bundle?#>)
        self.scannerDelegate = scannerDelegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCaptureSession (){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { scannerDelegate?.showError(error: .invalidDeviceInput) }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegate?.showError(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }else{
            scannerDelegate?.showError(error: .invalidDeviceInput)
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .aztec, .dataMatrix, .ean8, .ean13]
        }else{
            scannerDelegate?.showError(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
    }
    
    
}


extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {scannerDelegate?.showError(error: .invalidScannedValue); return }
        }
        
        guard let machineReadableCodeObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.showError(error: .invalidScannedValue); return }
        
        guard let barcode = machineReadableCodeObject.stringValue else {
            scannerDelegate?.showError(error: .invalidScannedValue); return }
        
        scannerDelegate?.didFind(bardCode: barcode)
    }
}
