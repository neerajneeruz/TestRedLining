//
//  RedLiningViewController.h
//  RedLiningMapProj
//
//  Created by MFluid Apps on 24/06/14.
//  Copyright (c) 2014 Mfluid Mobile Apps Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RedLiningViewController : UIViewController<MKMapViewDelegate,UIGestureRecognizerDelegate,CLLocationManagerDelegate>
{
    CGPoint startLocation;
    NSString *data;
    
    UIImageView *image2;
    
    CGFloat lastScale;
	CGFloat lastRotation;
	
	CGFloat firstX;
	CGFloat firstY;
    
    NSMutableArray *randomArray;
    
    
    UIView *holderView;
    
    UIImage *selectedImage;
    IBOutlet UILabel *TestLanguageLabel;
    
    NSMutableArray *LattitudeArray1;
    NSMutableArray *LongitudeArray1;
    
    MKOverlayView* routeLineView;
    MKPolyline *routeLine;
    
    
    int OverlayModel;
    
    MKPolygonView *PolygonView;
    
    MKPointAnnotation *point;;
    
    CLLocationCoordinate2D draggedCoordinate;
  
    CLLocationCoordinate2D CurrentSelectedCoordinate;
    
    NSString *TicketNumber;
    
    UISlider *ZoomSlider;
    IBOutlet UISlider *slider;
    
    
    CLLocationManager* locationManager;
    
    MKPinAnnotationView *pointsA ;
    
    IBOutlet UIImageView *testImage;
}
- (IBAction)changeHueOfImage:(id)sender;

- (IBAction)orangeColorButtonPressed:(id)sender;
- (IBAction)blueColorButtonPressed:(id)sender;
- (IBAction)greenColorButtonPressed:(id)sender;
- (IBAction)redColorButtonPressed:(id)sender;
- (IBAction)cancelRedLiningButtonPressed:(id)sender;
- (IBAction)undoRedLiningButtonPressed:(id)sender;
- (IBAction)drawButtonPressed:(id)sender;
- (IBAction)userLocationButtonPressed:(id)sender;
- (IBAction)taskLocationButtonPressed:(id)sender;
@property(nonatomic,retain)NSString *TicketNumber;
- (IBAction)sliderChanged:(UISlider*)sender;
@property(nonatomic,retain) MKPointAnnotation *point;;
- (IBAction)removeAllOverlaysButtonPressed:(id)sender;
@property(nonatomic,retain)  NSMutableArray *LattitudeArray1;
@property(nonatomic,retain) NSMutableArray *LongitudeArray1;
- (IBAction)pointButtonPressed:(id)sender;
- (IBAction)squareButtonPressed:(id)sender;
- (IBAction)circleButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet MKMapView *MapView;
- (IBAction)addImageButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *testView;
- (IBAction)saveItAsImageButtonPressed:(id)sender;
@end
