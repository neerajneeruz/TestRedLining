//
//  MKCircleView.h
//  MapKit
//
//  Copyright (c) 2010-2013, Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKCircle.h>
#import <MapKit/MKFoundation.h>
#import <MapKit/MKOverlayPathView.h>

// Prefer MKCircleRenderer
MK_CLASS_AVAILABLE(NA, 4_0)
@interface MKCircleView : MKOverlayPathView

- (id)initWithCircle:(MKCircle *)circle NS_DEPRECATED_IOS(4_0, 7_0);

@property (nonatomic, readonly) MKCircle *circle NS_DEPRECATED_IOS(4_0, 7_0);

@end
