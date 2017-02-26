import lf
import GPUImage
import Foundation

class HaishinGPUImageRawOutput: GPUImageRawDataOutput {
    weak var delegate:NetStream?

    var status:OSStatus = noErr {
        didSet {
        }
    }

    var width:Int = 0
    var height:Int = 0

    init(imageSize: CGSize) {
        super.init(imageSize: imageSize, resultsInBGRAFormat: true)
        width = Int(imageSize.width)
        height = Int(imageSize.height)
    }

    override func setImageSize(_ newImageSize: CGSize) {
        super.setImageSize(newImageSize)
        width = Int(newImageSize.width)
        height = Int(newImageSize.height)
    }

    override func newFrameReady(at frameTime: CMTime, at textureIndex: Int) {
        super.newFrameReady(at: frameTime, at: textureIndex)

        var pixelBuffer:CVPixelBuffer?
        status = CVPixelBufferCreateWithBytes(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32BGRA,
            rawBytesForImage,
            width * 4,
            nil,
            nil,
            nil,
            &pixelBuffer
        )

        guard let _pixelBuffer:CVPixelBuffer = pixelBuffer else {
            return
        }

        var description:CMVideoFormatDescription?
        status = CMVideoFormatDescriptionCreateForImageBuffer(kCFAllocatorDefault, _pixelBuffer, &description)

        guard let _description:CMVideoFormatDescription = description else {
            return
        }

        var sampleBuffer:CMSampleBuffer?
        var timing:CMSampleTimingInfo = CMSampleTimingInfo()
        timing.presentationTimeStamp = frameTime
        status = CMSampleBufferCreateForImageBuffer(
            kCFAllocatorDefault,
            _pixelBuffer,
            true,
            nil,
            nil,
            _description,
            &timing,
            &sampleBuffer
        )

        if (sampleBuffer != nil) {
            delegate?.appendSampleBuffer(sampleBuffer!, withType: .video)
        }
    }
}
