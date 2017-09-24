import UIKit
import GPUImage
import HaishinKit
import GPUHaishinKit

struct Preference {
    static let defaultInstance:Preference = Preference()
    
    var uri:String? = "rtmp://test:test@192.168.11.9/live"
    var streamName:String? = "live"
}

class ViewController: UIViewController {
    @IBOutlet weak var outputView: GPUImageView?

    var camera:GPUImageVideoCamera?
    var filter:GPUImageSepiaFilter?
    var rtmpConnection:RTMPConnection?
    var rtmpStream:RTMPStream?

    var output:GPUImageRawDataOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        camera = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.hd1280x720.rawValue, cameraPosition: .back)
        rtmpConnection = RTMPConnection()
        rtmpStream = RTMPStream(connection: rtmpConnection!)
        filter = GPUImageSepiaFilter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let camera = camera {
            rtmpStream?.attachGPUImageVideoCamera(camera)
        }
        rtmpStream?.attachAudio(AVCaptureDevice.default(for: AVMediaType.audio))
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

    @IBAction
    func on(publish:UIButton) {
        if (publish.isSelected) {
            UIApplication.shared.isIdleTimerDisabled = false
            rtmpConnection?.close()
            rtmpConnection?.removeEventListener(Event.RTMP_STATUS, selector:#selector(ViewController.on(status:)), observer: self)
            publish.setTitle("●", for: UIControlState())
        } else {
            UIApplication.shared.isIdleTimerDisabled = true
            rtmpConnection?.addEventListener(Event.RTMP_STATUS, selector:#selector(ViewController.on(status:)), observer: self)
            rtmpConnection?.connect(Preference.defaultInstance.uri!)
            publish.setTitle("■", for: UIControlState())
        }
        publish.isSelected = !publish.isSelected
    }

    @objc func on(status:Notification) {
        let e:Event = Event.from(status)
        guard let data:ASObject = e.data as? ASObject , let code:String = data["code"] as? String else {
            return
        }
        switch code {
        case RTMPConnection.Code.connectSuccess.rawValue:
            rtmpStream!.publish(Preference.defaultInstance.streamName!)
        default:
            break
        }
    }
}


