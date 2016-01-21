//
//  UINavigationBar+CustomHeight.m
//  isHipster2
//
//  Created by Kirill on 14.01.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import "UINavigationBar+CustomHeight.h"

#import "UINavigationBar+CustomHeight.h"
#import "objc/runtime.h"

static char const *const heightKey = "Height";

@implementation UINavigationBar (CustomHeight)

- (void)setHeight:(CGFloat)height
{
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)height
{
    return objc_getAssociatedObject(self, heightKey);
}



@end