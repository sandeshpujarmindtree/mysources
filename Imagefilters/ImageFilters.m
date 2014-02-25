//
//  ImageFilters.m
//  ImageFilters
//
//  Created by ernesto on 14/07/13.
//  Copyright (c) 2013 raywenderlich. All rights reserved.
//

#import "ImageFilters.h"
@interface ImageFilters()

@property (nonatomic,strong) CIContext  *context;
@property (nonatomic,strong) CIImage    *beginImage;

@end
@implementation ImageFilters
-(id)initWithImage:(UIImage*)image
{
    self = [super init];
    if( self )
    {
        _originalImage  = image;
        _context        = [CIContext contextWithOptions:nil];
        _beginImage     = [[CIImage alloc] initWithImage:_originalImage];
        
    }
    return self;
    
}

-(UIImage*)imageWithCIImage:(CIImage*)ciImage
{
    CGImageRef cgiImage = [self.context createCGImage:ciImage fromRect:ciImage.extent];
    UIImage *image = [UIImage imageWithCGImage:cgiImage];
    CGImageRelease(cgiImage);
    
    return image;
}


-(UIImage*)grayScaleImage
{
    if( !self.originalImage)
        return nil;
    
    CIImage *grayScaleFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, self.beginImage, @"inputBrightness", [NSNumber numberWithFloat:0.0], @"inputContrast", [NSNumber numberWithFloat:1.1], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil].outputImage;
    
    
    
    CIImage *output = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, grayScaleFilter, @"inputEV", [NSNumber numberWithFloat:0.7], nil].outputImage;
    
    UIImage *filteredImage = [self imageWithCIImage:output];
    return filteredImage;
    
}

-(UIImage*)oldImageWithIntensity:(CGFloat)intensity
{
    if( !self.originalImage )
        return nil;
    
    // 1
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
    [sepia setValue:self.beginImage forKey:kCIInputImageKey];
    [sepia setValue:@(intensity) forKey:@"inputIntensity"];
    
    // 2
    CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    // 3
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:random.outputImage forKey:kCIInputImageKey];
    [lighten setValue:@(1 - intensity) forKey:@"inputBrightness"];
    [lighten setValue:@0.0 forKey:@"inputSaturation"];
    
    // 4
    CIImage *croppedImage = [lighten.outputImage imageByCroppingToRect:[self.beginImage extent]];
    
    // 5
    CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
    [composite setValue:sepia.outputImage forKey:kCIInputImageKey];
    [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];
    
    // 6
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setValue:composite.outputImage forKey:kCIInputImageKey];
    [vignette setValue:@(intensity * 2) forKey:@"inputIntensity"];
    [vignette setValue:@(intensity * 30) forKey:@"inputRadius"];
    
    // 7
    UIImage *filteredImage = [self imageWithCIImage:vignette.outputImage];
    
    
    return filteredImage;
}
@end
