# GPUHaishinKit.swift
[![GitHub license](https://img.shields.io/badge/license-New%20BSD-blue.svg)](https://raw.githubusercontent.com/shogo4405/lf.swift/master/LICENSE.txt)

GPUImage + HaishinKit(lf). Camera and Microphone streaming library via RTMP, HLS for iOS, macOS.

## Features
* Support GPUImage with a (RTMP/HLS)Stream.
* see also
 - https://github.com/shogo4405/lf.swift/blob/master/README.md

## Cocoa Keys
iOS10.0+
* NSMicrophoneUsageDescription
* NSCameraUsageDescription
* NSPhotoLibraryUsageDescription

## Installation
### CocoaPods
```rb
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def import_pods
    pod 'GPUHaishinKit', '~> 1.0.0'
end

target 'Your Target'  do
    platform :ios, '8.0'
    import_pods
end
```
### Carthage
```
github "shogo4405/GPUHaishinKit.swift" ~> 1.0.0
```

## License
New BSD

## Donation
Bitcoin
```txt
1HtWpaYkRGZMnq253QsJP6xSKZRPoJ8Hrs
```

## RTMP Usage
```swift
// must import lf and GPUHaishinKit
import lf 
import GPUHaishinKit

import GPUImage

class ViewController: UIViewController {
    @IBOutlet weak var outputView: GPUImageView?

    var camera:GPUImageVideoCamera?
    var filter:GPUImageSepiaFilter?
    var rtmpConnection:RTMPConnection?
    var rtmpStream:RTMPStream?

    var output:GPUImageRawDataOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        camera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset1280x720, cameraPosition: .back)
        rtmpConnection = RTMPConnection()
        rtmpStream = RTMPStream(connection: rtmpConnection!)
        filter = GPUImageSepiaFilter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rtmpStream?.attachGPUImageVideoCamera(camera!)
        rtmpStream?.attachAudio(AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio))
        rtmpStream?.videoSettings = [
            "width": 720,
            "height": 1280,
        ]
        camera?.addTarget(filter!)
        filter?.addTarget(outputView)
        filter?.addTarget(rtmpStream!.rawDataOutput)
        camera?.outputImageOrientation = .portrait
        camera?.startCapture()
    }

    override func viewWillDisappear(_ animated: Bool) {
        rtmpStream?.close()
        rtmpStream?.dispose()
        camera?.stopCapture()
        super.viewWillDisappear(animated)
    }
}
```
