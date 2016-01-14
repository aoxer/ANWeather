//
//  ANAwesomeMenu.m
//  ANWeather
//
//  Created by a on 16/1/14.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANAwesomeMenu.h"

@implementation ANAwesomeMenu

static ANAwesomeMenu *_instance;

/**
 *  alloc方法内部会调用这个方法
 */
+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (_instance == nil) { // 防止频繁加锁
        @synchronized(self) {
            if (_instance == nil) { // 防止创建多次
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

+ (instancetype)sharedAwesomeMenu
{
    if (_instance == nil) { // 防止频繁加锁
        @synchronized(self) {
            if (_instance == nil) { // 防止创建多次
                UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
                UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
                
                UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
                
                // Default Menu
                
                AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                       highlightedImage:storyMenuItemImagePressed
                                                                           ContentImage:starImage
                                                                highlightedContentImage:nil];
                AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                       highlightedImage:storyMenuItemImagePressed
                                                                           ContentImage:starImage
                                                                highlightedContentImage:nil];
                AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                       highlightedImage:storyMenuItemImagePressed
                                                                           ContentImage:starImage
                                                                highlightedContentImage:nil];
                
                NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2,starMenuItem3, nil];
                
                AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                                   highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                                       ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                            highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
                
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                
                _instance = [[self alloc] initWithFrame:window.bounds startItem:startItem menuItems:menuItems];
                
                _instance.menuWholeAngle = M_PI_2;
                _instance.farRadius = 110.0f;
                _instance.endRadius = 100.0f;
                _instance.nearRadius = 90.0f;
                _instance.animationDuration = 0.3f;
                _instance.startPoint = CGPointMake(50, ANScreenHeight - 50);
                
                [window addSubview:_instance];
            }
        }
    }
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
    
    if ([ANSettingTool isBigHand]) {\
        ANAwesomeMenu *awm = [ANAwesomeMenu sharedAwesomeMenu];\
        awm.alpha = 0;
        awm.hidden = YES;\
    } else {\
        ANAwesomeMenu *awm = [ANAwesomeMenu sharedAwesomeMenu];\
        [UIView animateWithDuration:2 animations:^{\
            awm.alpha = 1;\
        } completion:^(BOOL finished) {\
            awm.hidden = NO;\
        }];\
    }
}




@end
