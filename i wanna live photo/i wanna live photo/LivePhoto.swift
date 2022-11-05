//
//  LivePhoto.swift
//  i wanna live photo
//
//  Created by 위대연 on 2022/11/01.
//

import UIKit
import Photos

class LivePhoto {
    struct LivePhotoResources {
        var pairedImage: URL
        var pairedVideo: URL
    }
    
    func requestPhotosPermission() -> PHAuthorizationStatus {
        let photoStatus: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoStatus {
        case .notDetermined:
            <#code#>
        case .restricted:
            <#code#>
        case .denied: return .denied
        case .authorized: return .authorized
        case .limited:
            <#code#>
        }
    }
    
    var livePhotoResource: LivePhotoResources?
    
    func saveToLibrary(_ resource: LivePhotoResources) async throws -> Result<Bool, Error> {
        return await withCheckedContinuation { continuation in
            PHPhotoLibrary.shared().performChanges ({
                let creationRequest = PHAssetCreationRequest.forAsset()
                let options = PHAssetResourceCreationOptions()
                
                creationRequest.addResource(with: .pairedVideo, fileURL: resource.pairedVideo, options: options)
                creationRequest.addResource(with: .photo, fileURL: resource.pairedImage, options: options)
            }) { success, error in
                if let error {
                    print(error)
                    continuation.resume(returning: .failure(error))
                    return
                }
                continuation.resume(returning: .success(success))
            }
        }
    }
}
