//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<audioplayers/AudioplayersPlugin.h>)
#import <audioplayers/AudioplayersPlugin.h>
#else
@import audioplayers;
#endif

#if __has_include(<flute_music_player/MusicFinderPlugin.h>)
#import <flute_music_player/MusicFinderPlugin.h>
#else
@import flute_music_player;
#endif

#if __has_include(<flutter_media_notification/FlutterMediaNotificationPlugin.h>)
#import <flutter_media_notification/FlutterMediaNotificationPlugin.h>
#else
@import flutter_media_notification;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

#if __has_include(<system_shortcuts/SystemShortcutsPlugin.h>)
#import <system_shortcuts/SystemShortcutsPlugin.h>
#else
@import system_shortcuts;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AudioplayersPlugin registerWithRegistrar:[registry registrarForPlugin:@"AudioplayersPlugin"]];
  [MusicFinderPlugin registerWithRegistrar:[registry registrarForPlugin:@"MusicFinderPlugin"]];
  [FlutterMediaNotificationPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterMediaNotificationPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [SystemShortcutsPlugin registerWithRegistrar:[registry registrarForPlugin:@"SystemShortcutsPlugin"]];
}

@end
