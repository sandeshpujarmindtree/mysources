//
//  ImageFilters.h
//  ImageFilters
//
//  Created by ernesto on 14/07/13.
//  Copyright (c) 2013 raywenderlich. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

@interface ImageFilters : NSObject
@property (nonatomic,readonly) UIImage *originalImage;

-(id)initWithImage:(UIImage*)image;
-(UIImage*)grayScaleImage;
-(UIImage*)oldImageWithIntensity:(CGFloat)level;
@end
