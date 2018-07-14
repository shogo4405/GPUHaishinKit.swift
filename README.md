# [Archived]GPUHaishinKit.swift

[![Platform](https://img.shields.io/cocoapods/p/GPUHaishinKit.svg?style=flat)](http://cocoapods.org/pods/GPUHaishinKit)
![Language](https://img.shields.io/badge/language-Swift%204.0-orange.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/GPUHaishinKit.svg?style=flat)](http://cocoapods.org/pods/GPUHaishinKit)
[![GitHub license](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://github.com/shogo4405/GPUHaishinKit.swift/blob/master/LICENSE.md)

GPUImage is unmaintained. Also can't maintenance GPUHaishinKit. Goodbye! [07/14 2018]
GPUImage + HaishinKit(lf). Camera and Microphone streaming library via RTMP, HLS for iOS.

## Features
* Support GPUImage with a (RTMP/HLS)Stream.
* see also
  - https://github.com/shogo4405/HaishinKit.swift/blob/master/README.md

## Requirements
|-|iOS|XCode|Swift|CocoaPods|Carthage|
|:----:|:----:|:----:|:----:|:----:|:----:|
|1.2.0|8.0+|8.3+|4.0|1.2.0|0.20.0+|
|1.1.0|8.0+|8.3+|3.1|1.2.0|0.20.0+|

## Cocoa Keys
iOS10.0+
* NSMicrophoneUsageDescription
* NSCameraUsageDescription

## Installation
### CocoaPods
```rb
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def import_pods
    pod 'GPUHaishinKit', '~> 1.2.0'
end

target 'Your Target'  do
    platform :ios, '8.0'
    import_pods
end
```
### Carthage
```
github "shogo4405/GPUHaishinKit.swift" ~> 1.2.0
```

## License
BSD-3-Clause

## RTMP Usage
```swift
// must import HaishinKit and GPUHaishinKit
import HaishinKit
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
