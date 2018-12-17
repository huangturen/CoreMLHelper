//
//  CGImageHelper.h
//  CoreMLHelper
//
//  Created by mabaoyan on 2018/12/17.
//  Copyright © 2018 mabaoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>
#import <ImageIO/ImageIO.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGImageHelper : NSObject

+ (CVPixelBufferRef)pixelBufferWithImage:(CGImageRef)image
                                   Width:(NSUInteger)width
                                  height:(NSUInteger)height
                         pixelFormatType:(OSType)pixelFormatType
                              colorSpace:(CGColorSpaceRef)colorSpace
                               alphaInfo:(CGImageAlphaInfo)alphaInfo
                             orientation:(CGImagePropertyOrientation)orientation;


@end

NS_ASSUME_NONNULL_END
