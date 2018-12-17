//
//  CGImageHelper.m
//  CoreMLHelper
//
//  Created by mabaoyan on 2018/12/17.
//  Copyright © 2018 mabaoyan. All rights reserved.
//

#import "CGImageHelper.h"

@implementation CGImageHelper

+ (CVPixelBufferRef)pixelBufferWithImage:(CGImageRef)image
                                   Width:(NSUInteger)width
                                  height:(NSUInteger)height
                         pixelFormatType:(OSType)pixelFormatType
                              colorSpace:(CGColorSpaceRef)colorSpace
                               alphaInfo:(CGImageAlphaInfo)alphaInfo
                             orientation:(CGImagePropertyOrientation)orientation{
    assert(orientation == kCGImagePropertyOrientationUp);
    
    CVPixelBufferRef maybePixelBuffer = NULL;
    CFStringRef keys[2];
    keys[0] = kCVPixelBufferCGImageCompatibilityKey;
    keys[1] = kCVPixelBufferCGBitmapContextCompatibilityKey;
    
    CFBooleanRef values[2];
    values[0] = kCFBooleanTrue;
    values[1] = kCFBooleanTrue;
    
    CFDictionaryRef attrs = CFDictionaryCreate(kCFAllocatorDefault,
                                               (void*)keys,
                                               (void*)values,
                                               2,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          width,
                                          height,
                                          pixelFormatType,
                                          attrs,
                                          &maybePixelBuffer);
    
    CFRelease(attrs);
    if (status != kCVReturnSuccess || !maybePixelBuffer) {
        CFRelease(status);
        return nil;
    }
    
    CFRelease(status);
    
    CVPixelBufferLockFlags flags = 0;
    if (CVPixelBufferLockBaseAddress(maybePixelBuffer, flags) != kCVReturnSuccess) {
        return nil;
    }
    
    CVPixelBufferUnlockBaseAddress(maybePixelBuffer, flags);
    
    CGContextRef context = CGBitmapContextCreate(CVPixelBufferGetBaseAddress(maybePixelBuffer),
                                                 width,
                                                 height,
                                                 8, CVPixelBufferGetBytesPerRow(maybePixelBuffer),
                                                 colorSpace,
                                                 alphaInfo);
    if (!context) {
        return nil;
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CFRelease(context);
    return maybePixelBuffer;
}


@end
