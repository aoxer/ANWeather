//
//  UIView+awesomeMenu.m
//  ANWeather
//
//  Created by a on 16/1/14.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "UIView+awesomeMenu.h"

@implementation UIView (awesomeMenu)


+ (void)awesomeMenu
{
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
    
    NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:window.bounds startItem:startItem menuItems:menuItems];

    menu.menuWholeAngle = M_PI_2;
    menu.farRadius = 110.0f;
    menu.endRadius = 100.0f;
    menu.nearRadius = 90.0f;
    menu.animationDuration = 0.3f;
    menu.startPoint = CGPointMake(50, ANScreenHeight - 50);
    
    [window addSubview:menu];
    
    
}
/**
 *  拿到awesomeMenu
 */
+ (AwesomeMenu *)getAwesomeMenu
{
    AwesomeMenu *menu;
    for (id subView in [[UIApplication sharedApplication].keyWindow subviews]) {
        if ([subView isKindOfClass:[AwesomeMenu class]]) {
            menu = (AwesomeMenu *)subView;
        }
    }
    return menu;
}

@end
