import CoreNFC
import Flutter

public class NfcReader: NSObject {
    @available(iOS 13.0, *)
    private lazy var session: NFCTagReaderSession? = nil

    @available(iOS 13.0, *)
    private lazy var tag: NFCTag? = nil

    @available(iOS 13.0, *)
    private lazy var tech: NFCMiFareTag? = nil

    private var isFoundTag: Bool {
        get {
            return (self.tag != nil) && (self.tech != nil)
        }
    }

    @available(iOS 13.0, *)
    public func setTag(_ session: NFCTagReaderSession?, tag: NFCTag?, tech: NFCMiFareTag?) {
        self.session = session
        self.tag = tag
        self.tech = tech
    }

    @available(iOS 13.0, *)
    public func transceive(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        guard self.isFoundTag else {
            result(FlutterError(
                    code: "not_found",
                    message: "Tag is not found.",
                    details: nil))
            return
        }

//        if ( !(self.session?.isReady ?? false) ) {
//            result(FlutterError(
//                    code: "not_ready",
//                    message: "Session is not ready.",
//                    details: nil))
//            return
//        }

        let command = (arguments["data"] as! FlutterStandardTypedData).data

        self.sendCommand(command: command) { data, error in
            if let error = error {
                result(self.getFlutterError(error))
                return
            }

            result(data)
        }
    }

    @available(iOS 13.0, *)
    public func transceives(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        guard self.isFoundTag else {
            result(FlutterError(
                    code: "not_found",
                    message: "Tag is not found.",
                    details: nil))
            return
        }

//        if ( !(self.session?.isReady ?? false) ) {
//            result(FlutterError(
//                    code: "not_ready",
//                    message: "Session is not ready.",
//                    details: nil))
//            return
//        }

        let packets = arguments["data"] as! [FlutterStandardTypedData]
        var response = [UInt8]()

        for packet in packets {
            let command = packet.data

            self.sendCommand(command: command) { data, error in
                if let error = error {
                    result(self.getFlutterError(error))
                    return
                }

                if let data = data {
                    response += data
                }
            }
        }

        result(response)
    }
}

@available(iOS 13.0, *)
extension NfcReader {
    private func sendCommand(command commandPacket: Data, completionHandler: @escaping (Data?, Error?) -> Void) {
        if #available(iOS 14, *) {
            self.tech?.sendMiFareCommand(commandPacket: commandPacket) { result in
                switch result {
                case let .success(response):
                    completionHandler(response, nil)
                case let .failure(error):
                    completionHandler(nil, error)
                }
            }
        } else {
            self.tech?.sendMiFareCommand(commandPacket: commandPacket) { data, error in
                completionHandler(data, error)
            }
        }
    }
}

extension NfcReader {
    private func getFlutterError(_ error: Error) -> FlutterError {
        if let err = error as? NFCReaderError {
            return FlutterError(
                code: self.getErrorTypeString(err.code),
                message: err.localizedDescription,
                details: err.userInfo)
        }

        let err = error as NSError

        return FlutterError(
            code: "\(err.code)",
            message: err.localizedDescription,
            details: err.userInfo)
    }

    private func getErrorTypeString(_ code: NFCReaderError.Code) -> String {
        switch code {
        case .readerTransceiveErrorTagConnectionLost:
            return "\(code.rawValue) TagConnectionLost"
        case .readerTransceiveErrorRetryExceeded:
            return "\(code.rawValue) RetryExceeded"
        case .readerTransceiveErrorTagResponseError:
            return "\(code.rawValue) TagResponseError"
        case .readerTransceiveErrorSessionInvalidated:
            return "\(code.rawValue) SessionInvalidated"
        case .readerTransceiveErrorTagNotConnected:
            return "\(code.rawValue) TagNotConnected"
        case .readerTransceiveErrorPacketTooLong:
            return "\(code.rawValue) PacketTooLong"
        default:
            return "\(code.rawValue) unknown"
        }
    }
}