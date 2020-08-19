//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flute_music_player/MusicFinderPlugin.h>)
#import <flute_music_player/MusicFinderPlugin.h>
#else
@import flute_music_player;
#endif

#if __has_include(<system_shortcuts/SystemShortcutsPlugin.h>)
#import <system_shortcuts/SystemShortcutsPlugin.h>
#else
@import system_shortcuts;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [MusicFinderPlugin registerWithRegistrar:[registry registrarForPlugin:@"MusicFinderPlugin"]];
  [SystemShortcutsPlugin registerWithRegistrar:[registry registrarForPlugin:@"SystemShortcutsPlugin"]];
}

@end
