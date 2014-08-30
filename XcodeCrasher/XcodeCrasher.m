//
//  XcodeCrasher.m
//  XcodeCrasher
//
//  Created by Katsuma Tanaka on 2014/08/30.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "XcodeCrasher.h"


@implementation XcodeCrasher

+ (void)pluginDidLoad:(NSBundle *)bundle
{
    static dispatch_once_t _onceToken;
    static id _sharedPlugin = nil;
    dispatch_once(&_onceToken, ^{
        _sharedPlugin = [[self alloc] init];
    });
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setUpMenuItem];
    }
    
    return self;
}


#pragma mark - Menu Item

- (void)setUpMenuItem
{
    NSMenuItem *xcodeMenuItem = [[NSApp mainMenu] itemWithTitle:@"Xcode"];
    
    if (xcodeMenuItem) {
        // Kill Xcode
        NSMenuItem *killXcodeMenuItem = [[NSMenuItem alloc] initWithTitle:@"Kill Xcode"
                                                                   action:@selector(killXcode:)
                                                            keyEquivalent:@""];
        killXcodeMenuItem.target = self;
        [xcodeMenuItem.submenu insertItem:killXcodeMenuItem atIndex:2];
        
        // Separator
        [xcodeMenuItem.submenu insertItem:[NSMenuItem separatorItem]
                                  atIndex:3];
    }
}

- (void)killXcode:(id)sender
{
    abort();
}

@end
