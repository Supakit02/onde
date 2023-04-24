import CoreNFC
import Flutter

public class SwiftNfcSicPlugin: NSObject, FlutterPlugin {
    private let channel: FlutterMethodChannel
    private let session: NfcSession
    private let reader: NfcReader

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "plugin.sic.co.th/nfc_sic",
            binaryMessenger: registrar.messenger())
        let reader = NfcReader()
        let instance = SwiftNfcSicPlugin(channel, reader: reader)

        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private init(_ channel: FlutterMethodChannel, reader: NfcReader) {
        self.channel = channel
        self.reader = reader
        self.session = NfcSession(channel, reader: reader)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 13.0, *) else {
            result(FlutterError(
                    code: "unavailable",
                    message: "Only available in iOS 13.0 or newer",
                    details: nil))
            return
        }

        switch call.method {
        case "isAvailable":
            self.session.isAvailable(call.arguments as! [String: Any?], result: result)
        case "startSession":
            self.session.startSession(call.arguments as! [String: Any?], result: result)
        case "stopSession":
            self.session.stopSession(call.arguments as! [String: Any?], result: result)
        case "transceive":
            self.reader.transceive(call.arguments as! [String: Any?], result: result)
        case "transceives":
            self.reader.transceives(call.arguments as! [String: Any?], result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}