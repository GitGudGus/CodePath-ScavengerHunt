//
//  PhotoPicker.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import SwiftUI
import PhotosUI
import Photos
import CoreLocation
import UIKit

/// Presents PHPicker and returns the picked UIImage plus optional location coordinate (from PHAsset).
struct PhotoPicker: UIViewControllerRepresentable {
    var onComplete: (_ image: UIImage, _ coordinate: CLLocationCoordinate2D?) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(self) }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        init(_ parent: PhotoPicker) { self.parent = parent }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Dismiss first so UI responds quickly
            picker.dismiss(animated: true)

            guard let result = results.first else { return }
            let provider = result.itemProvider

            // Load the UIImage
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { object, error in
                    if let error = error {
                        print("PhotoPicker: loadObject error:", error)
                        return
                    }
                    guard let image = object as? UIImage else { return }

                    // Try to fetch PHAsset location using assetIdentifier (if available)
                    var coord: CLLocationCoordinate2D? = nil
                    if let assetId = result.assetIdentifier {
                        let assets = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
                        if let asset = assets.firstObject, let loc = asset.location {
                            coord = loc.coordinate
                        }
                    }

                    DispatchQueue.main.async {
                        self.parent.onComplete(image, coord)
                    }
                }
            }
        }
    }
}


