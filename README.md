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
var camera:GPUImageVideoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset352x288, cameraPosition: .back)
var rtmpConnection:RTMPConnection = RTMPConnection()
var rtmpStream:RTMPStream = RTMPStream(connection: rtmpConnection)
rtmpStream.attachGPUImageVideoCamera(camera)

var filter:GPUImageSepiaFilter = GPUImageSepiaFilter()
camera?.addTarget(filter)
filter?.addTarget(outputView)
filter?.addTarget(rtmpStream.rawDataOutput)

camera.outputImageOrientation = .portrait
camera.startCapture()

rtmpConnection.connect("rtmp://localhost/appName/instanceName")
rtmpStream.publish("streamName")
```

## Installation

## License
New BSD

## Donation
Bitcoin
```txt
1HtWpaYkRGZMnq253QsJP6xSKZRPoJ8Hrs
```
