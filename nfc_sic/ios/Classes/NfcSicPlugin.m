#import "NfcSicPlugin.h"
#if __has_include(<nfc_sic/nfc_sic-Swift.h>)
#import <nfc_sic/nfc_sic-Swift.h>
#else
#import "nfc_sic-Swift.h"
#endif

@implementation NfcSicPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNfcSicPlugin registerWithRegistrar:registrar];
}
@end