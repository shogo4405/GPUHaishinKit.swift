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

## RTMP Usage
Real Time Messaging Protocol (RTMP).

```swift
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

## Installation

## License
New BSD

## Donation
Bitcoin
```txt
1HtWpaYkRGZMnq253QsJP6xSKZRPoJ8Hrs
```
