import CoreNFC
import Flutter

public class NfcSession: NSObject {
//    private var gap = DispatchTime.now()
    private let channel: FlutterMethodChannel
    private let reader: NfcReader

    @available(iOS 13.0, *)
    private lazy var session: NFCTagReaderSession? = nil

    @available(iOS 13.0, *)
    private lazy var polling: NFCTagReaderSession.PollingOption? = nil

    @available(iOS 13.0, *)
    private lazy var alertMessage: String? = nil

    public init(_ channel: FlutterMethodChannel, reader: NfcReader) {
        self.channel = channel
        self.reader = reader
    }

    @available(iOS 13.0, *)
    public func isAvailable(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        result(NFCTagReaderSession.readingAvailable)
    }

    @available(iOS 13.0, *)
    public func startSession(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        guard NFCTagReaderSession.readingAvailable else {
            result(FlutterError(
                    code: "unavailable",
                    message: "NFC tag reader unavailable in your phone.",
                    details: nil))
            return
        }

        let polling = self.getPollingOption(arguments["pollingOptions"] as! [String])

        self.polling = polling

        self.session = NFCTagReaderSession(
            pollingOption: polling,
            delegate: self,
            queue: .main)

        if let alertMessage = arguments["alertMessage"] as? String {
            self.alertMessage = alertMessage
            self.session?.alertMessage = alertMessage
        }

        self.session?.begin()

//        debugPrint("startSession: \(NSDate.now.description)")
//        self.gap = DispatchTime.now()

        result(nil)
    }

    @available(iOS 13.0, *)
    public func stopSession(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        guard let session = session else {
            result(nil)
            return
        }

        if let errorMessage = arguments["errorMessage"] as? String {
            session.invalidate(
                errorMessage: errorMessage)

            result(nil)

            self.reader.setTag(
                nil,
                tag: nil,
                tech: nil)
            self.session = nil
            return
        }

        if let alertMessage = arguments["alertMessage"] as? String {
            session.alertMessage = alertMessage
        }

        session.invalidate()

        result(nil)

//        debugPrint("stopSession: \(NSDate.now.description)")
//        debugPrint("\((DispatchTime.now().uptimeNanoseconds - self.gap.uptimeNanoseconds) / 1000000)")
//        self.gap = DispatchTime.now()

        self.reader.setTag(
            nil,
            tag: nil,
            tech: nil)
        self.session = nil
    }
}

@available(iOS 13.0, *)
extension NfcSession {
    private func getPollingOption(_ options: [String]) -> NFCTagReaderSession.PollingOption {
        var option = NFCTagReaderSession.PollingOption()

        options.forEach { opt in
            switch opt {
            case "iso14443":
                option.insert(.iso14443)
            case "iso15693":
                option.insert(.iso15693)
            case "iso18092":
                option.insert(.iso18092)
            default:
                return
            }
        }

        return option
    }

    private func getErrorTypeString(_ code: NFCReaderError.Code) -> String {
        switch code {
        case .readerSessionInvalidationErrorUserCanceled:
            return "userCanceled"
        case .readerSessionInvalidationErrorSessionTimeout:
            return "sessionTimeout"
        case .readerSessionInvalidationErrorSessionTerminatedUnexpectedly:
            return "sessionTerminatedUnexpectedly"
        case .readerSessionInvalidationErrorSystemIsBusy:
            return "systemIsBusy"
        case .readerSessionInvalidationErrorFirstNDEFTagRead:
            return "firstNDEFTagRead"
        default:
            return "unknown"
        }
    }

    private func getErrorMap(_ error: Error) -> [String : Any?] {
        if let err = error as? NFCReaderError {
            return [
                "type": self.getErrorTypeString(err.code),
                "message": err.localizedDescription,
                "details": err.userInfo,
            ]
        }

        let err: NSError = error as NSError

        return [
            "type": "\(err.code)",
            "message": err.localizedDescription,
            "details": err.userInfo,
        ]
    }
}

@available(iOS 13.0, *)
extension NfcSession: NFCTagReaderSessionDelegate {
    public func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
//        debugPrint("SessionDidBecomeActive: \(NSDate.now.description)")
//        debugPrint("\((DispatchTime.now().uptimeNanoseconds - self.gap.uptimeNanoseconds) / 1000000)")
//        self.gap = DispatchTime.now()

//        channel.invokeMethod("onSessionBecomeActive", arguments: nil)
    }

    public func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
//        debugPrint("didInvalidateWithError: \(NSDate.now.description)")
//        debugPrint("\((DispatchTime.now().uptimeNanoseconds - self.gap.uptimeNanoseconds) / 1000000)")
//        self.gap = DispatchTime.now()

//        session.sessionQueue.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(1000)) {
//            self.session = NFCTagReaderSession(
//                pollingOption: self.polling
//                    ?? [ .iso14443 ],
//                delegate: self,
//                queue: session.sessionQueue)
//
//            self.session?.alertMessage = "Please tap a tag."
//            self.session?.begin()
//        }

        channel.invokeMethod("onSessionError", arguments: self.getErrorMap(error))

        if let err = error as? NFCReaderError {
            if err.code == .readerSessionInvalidationErrorSessionTimeout {
                DispatchQueue.global().asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(2000)) {
                    self.session = NFCTagReaderSession(
                        pollingOption: self.polling
                            ?? [ .iso14443 ],
                        delegate: self,
                        queue: .main)

                    self.session?.alertMessage = "Please tap a tag."
                    self.session?.begin()
                }
            }
        }
    }

    public func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
//        debugPrint("didDetectTags")
//        debugPrint("\((DispatchTime.now().uptimeNanoseconds - self.gap.uptimeNanoseconds) / 1000000)")
//        self.gap = DispatchTime.now()

        let tag = tags.first!

        switch tag {
        case let .miFare(tech):
            session.connect(to: tag) { error in
                if error != nil {
                    // Restart polling in 500ms
                    let retryInterval = DispatchTimeInterval.milliseconds(500)
                    session.alertMessage = "Unable to connect to tag.\nPlease remove tag and try again."
                    DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                        session.restartPolling()
                    })
//                    session.invalidate(errorMessage: "Unable to connect to tag.")
                    return
                }

//                DispatchQueue.global().asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(17000)) {
//                    debugPrint("restartPolling: \(NSDate.now.description)")
//                    self.gap = DispatchTime.now()
//                    session.restartPolling()
//                }

                session.alertMessage = "Now, this app process on NFC tag.\nPlease don\'t move your phone."

                self.reader.setTag(
                    session,
                    tag: tag,
                    tech: tech)
                self.channel.invokeMethod("onTagDiscovered", arguments: tech.identifier)
            }

        case .feliCa(_), .iso7816(_), .iso15693(_):
            // Restart polling in 500ms
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "This can\'t support NFC tag type.\nPlease remove tag and try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })

        @unknown default:
            // Restart polling in 500ms
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "Unknown NFC tag type.\nPlease remove tag and try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
        }
    }
}