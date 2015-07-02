//
//  RedLiningViewController.m
//  RedLiningMapProj
//
//  Created by MFluid Apps on 24/06/14.
//  Copyright (c) 2014 Mfluid Mobile Apps Pvt. Ltd. All rights reserved.
//

#import "RedLiningViewController.h"
#import <MapKit/MapKit.h>
@interface RedLiningViewController ()

@end

@implementation RedLiningViewController

@synthesize point;
@synthesize LattitudeArray1;
@synthesize LongitudeArray1;
@synthesize TicketNumber;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIImage *)imageNamed1:(NSString *)nameq withColor:(UIColor *)color
{
    // load the image
   
    UIImage *img = [UIImage imageNamed:nameq];
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}
-(UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    // load the image
    
    UIImage *img = [UIImage imageNamed:name];
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}
-(UIImage*)doHueAdjustFilterWithBaseImageName:(NSString*)baseImageName hueAdjust:(CGFloat)hueAdjust
{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:baseImageName]];
    CIFilter * controlsFilter = [CIFilter filterWithName:@"CIHueAdjust"];
    [controlsFilter setValue:inputImage forKey:kCIInputImageKey];
    
    [controlsFilter setValue:[NSNumber numberWithFloat:hueAdjust] forKey:@"inputAngle"];
    
    NSLog(@"%@",controlsFilter.attributes);
    CIImage *displayImage = controlsFilter.outputImage;
    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    if (displayImage == nil || finalImage == nil) {
        // We did not get output image. Let's display the original image itself.
        return  [UIImage imageNamed:baseImageName];
    }else {
        // We got output image. Display it.
        return  [UIImage imageWithCGImage:[context createCGImage:displayImage fromRect:displayImage.extent]];
    }
    
    
}

- (IBAction)changeHueOfImage:(id)sender {
    
    
    UISlider *slider1=(UISlider *)sender;
    
    NSLog(@"%f",slider1.value);
    
    testImage.image=[self doHueAdjustFilterWithBaseImageName:@"badge" hueAdjust:slider1.value];
}

- (IBAction)orangeColorButtonPressed:(id)sender {
  //  testImage.image=[self imageNamed:@"print" withColor:[UIColor whiteColor]];
    testImage.image=[self imageNamed1:@"badge" withColor:[UIColor whiteColor]];
}

- (IBAction)blueColorButtonPressed:(id)sender {
   // testImage.image=[self imageNamed:@"print" withColor:[UIColor blueColor]];
     testImage.image=[self imageNamed1:@"badge" withColor:[UIColor blueColor]];
}

- (IBAction)greenColorButtonPressed:(id)sender {
   // testImage.image=[self imageNamed:@"print" withColor:[UIColor greenColor]];
     testImage.image=[self imageNamed1:@"badge" withColor:[UIColor greenColor]];
}

- (IBAction)redColorButtonPressed:(id)sender {
   // testImage.image=[self imageNamed:@"print" withColor:[UIColor redColor]];
    // testImage.image=[self imageNamed1:@"badge" withColor:[UIColor redColor]];
    
    
    [UIView animateWithDuration:20.0 animations:^{
        
        testImage.image=[self imageNamed1:@"badge" withColor:[UIColor redColor]];
        
    } completion:^(BOOL finished) {
        
        //testImage.image=[self imageNamed1:@"badge" withColor:[UIColor whiteColor]];
    }];
}
- (void)viewDidLoad
{
   
   
    
    // self.MapView=[[MKMapView alloc]init];
    
    slider.hidden=YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    self.MapView.mapType = MKMapTypeStandard;
    self.MapView.delegate=self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    MKCoordinateSpan span1= MKCoordinateSpanMake(.0045, .0057);
    MKCoordinateRegion region1 = {coordinate, span1};
    [self.MapView setRegion:region1];
    self.MapView.showsUserLocation=YES;
    
    
  // [self showInMap:[NSString stringWithFormat:@"%f",coordinate.latitude] :[NSString stringWithFormat:@"%f",coordinate.longitude]];
    
    self.point = [[MKPointAnnotation alloc] init];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5;; //user needs to press for 2 seconds
    [self.MapView addGestureRecognizer:lpgr];
    [lpgr release];
    
    
    self.LattitudeArray1=[[NSMutableArray alloc]init];
    self.LongitudeArray1=[[NSMutableArray alloc]init];
    
    
    
    NSString* langPrefix = [NSLocale preferredLanguages][0];
    NSLog(@"%@",langPrefix);
    
    [[NSUserDefaults standardUserDefaults] setObject:@[@"ar"] forKey:@"AppleLanguages"];
    
    NSString* langPrefix1 = [NSLocale preferredLanguages][0];
    NSLog(@"%@",langPrefix1);
    
    TestLanguageLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Yesterday you sold %@ apps", nil), @(1000000)];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
}
//********* Method : handleLongPress
//********* allocating UIGestureRecognizer for handling long press
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    
    
    
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.MapView];
        
        CLLocationCoordinate2D touchMapCoordinate =
        [self.MapView convertPoint:touchPoint toCoordinateFromView:self.MapView];
        
        [self.LattitudeArray1 addObject:[NSString stringWithFormat:@"%f",touchMapCoordinate.latitude] ];
        [self.LongitudeArray1 addObject:[NSString stringWithFormat:@"%f",touchMapCoordinate.longitude] ];
        NSLog(@"%@",self.LattitudeArray1);
        NSLog(@"%@",self.LongitudeArray1);
        
        CurrentSelectedCoordinate=touchMapCoordinate;
        
        CLLocationCoordinate2D *coordsForFillingPolygon =malloc(sizeof(CLLocationCoordinate2D) *[self.LattitudeArray1 count]);
        
        for (int idx=0;idx<[self.LattitudeArray1 count]; idx++) {
            
            
            coordsForFillingPolygon[idx] = CLLocationCoordinate2DMake([[self.LattitudeArray1 objectAtIndex:idx]floatValue ],[[self.LongitudeArray1 objectAtIndex:idx] floatValue]);
        }
        
        if (OverlayModel==1) {
            
           
            
            MKPolygon *commuterParkingPolygon=[MKPolygon polygonWithCoordinates:coordsForFillingPolygon count:[self.LattitudeArray1 count]];
            [self.MapView addOverlay:commuterParkingPolygon];
        }
        else if (OverlayModel==2) {
            
            
            
            MKPolyline *commuterParkingPolygon=[MKPolyline polylineWithCoordinates:coordsForFillingPolygon count:[self.LattitudeArray1 count]];
            [self.MapView addOverlay:commuterParkingPolygon];
        }
        if (OverlayModel==3) {
            
           
            
            MKCircle *commuterParkingPolygon=[MKCircle circleWithCenterCoordinate:touchMapCoordinate radius:110];
            [self.MapView addOverlay:commuterParkingPolygon];
            
        }
        
        
        self.point.coordinate=touchMapCoordinate;
        self.point.title=@"Location";
        
        // point.title=[NSString stringWithFormat:@"Lat :%@ \n Lon: %@",point.coordinate.latitude,point.coordinate.longitude];
        
        MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
        
        point1.coordinate=touchMapCoordinate;
        
        point1.title=@"Location";
        
        MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:point1 reuseIdentifier:nil] ;
        
        
        
        
        
        customPinView.pinColor = MKPinAnnotationColorGreen;
        
        // customPinView.animatesDrop = YES;
        customPinView.draggable=YES;
        customPinView.canShowCallout = YES;
        // [customPinView animatesDrop];
        
        UIImageView *leftIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company.png"]];
        leftIconView.frame = CGRectMake(0,0,31,30);
        customPinView.leftCalloutAccessoryView=leftIconView;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        [rightButton addTarget:self action:@selector(annotationViewClick) forControlEvents:UIControlEventTouchUpInside];
        
        customPinView.rightCalloutAccessoryView=rightButton;
        
        CGRect endFrame = customPinView.frame;
        
        customPinView.frame = CGRectMake(customPinView.frame.origin.x, customPinView.frame.origin.y - 230.0, customPinView.frame.size.width, customPinView.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.45];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [customPinView setFrame:endFrame];
        [UIView commitAnimations];
        
        
        [self.MapView addAnnotation:customPinView.annotation];
        
        
        
        //         MKCoordinateRegion region;
        //        MKCoordinateSpan span;
        //        region.center = touchMapCoordinate;
        //        span.latitudeDelta=.047;  //THIS IS HARDCODED
        //        span.longitudeDelta=.047; //THIS IS HARDCODED
        //        region.span = span;
        //        //
        //        [self.MapView setRegion:region animated:YES];
        
        
    }
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id < MKOverlay >)overlay
{
    
    
   
        
        if ([overlay isKindOfClass:[MKCircle class]]) {
            
            MKCircleRenderer *renderer =
            [[MKCircleRenderer alloc] initWithCircle:overlay];
            renderer.strokeColor = [UIColor orangeColor];
            renderer.alpha=0.3;
            renderer.fillColor=[UIColor redColor];
            renderer.lineWidth = 6.0;
            return renderer;
            
            
           
            
        }
        else if ([overlay isKindOfClass:[MKPolygon class]])
        {
            MKPolygonRenderer *renderer =
            [[MKPolygonRenderer alloc] initWithPolygon:overlay];
            renderer.strokeColor = [UIColor orangeColor];
            renderer.fillColor=[UIColor redColor];
            renderer.alpha=0.3;
            renderer.lineWidth = 6.0;
            return renderer;
        }
    else 
    {
        MKPolylineRenderer *renderer =
        [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        renderer.strokeColor = [UIColor orangeColor];
        
        renderer.lineWidth = 6.0;
        return renderer;
    }
    

    
   
}
- (IBAction)sliderChanged:(UISlider*)sender
{
    for (id<MKOverlay>  v1 in [self.MapView overlays]) {
        
        if ([v1 isKindOfClass:[MKCircle class]]) {
            
             [self.MapView removeOverlay:v1];
            
        }
        else
        {
           // [self.MapView removeOverlay:v1];
        }
    }
    
    
    [self.MapView removeOverlays:[self.MapView overlays]];
    
    double radius = (sender.value * 100);
    
    [self addCircleWithRadius:radius];
}
- (void)addCircleWithRadius:(double)radius
{
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:CurrentSelectedCoordinate radius:radius];
    [circle setTitle:@"background"];
    [self.MapView addOverlay:circle];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    
    if( annotation == mapView.userLocation ){ return nil; }
    
    
    //MKPinAnnotationView *annView = nil;
    // MKPinAnnotationView *annView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"currentloc"];
    MKPinAnnotationView *annView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:Nil];
    if( annView == nil ){
        annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    }
    
    // annView.pinColor =  [UIColor redColor]CGColor;
    //NSLog(@"Pin color: %d", [defaults integerForKey:@"currPinColor"]);
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    annView.draggable=YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    return annView;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    
    
   // Removing drag and drop conditions for task location annotation view
    
    if([annotationView.annotation.title isEqualToString:@"Inspection Location"])
    {
        return;
    }
    
    if (newState == MKAnnotationViewDragStateEnding)
    {
        
        [self performSelector:@selector(removeOverlays) withObject:Nil];
        
        NSLog(@"dropped at %f,%f", draggedCoordinate.latitude, draggedCoordinate.longitude);
        NSLog(@"index %lu",(unsigned long)[self.LattitudeArray1 indexOfObject:[NSString stringWithFormat:@"%f",draggedCoordinate.latitude] ] );
        
        NSUInteger index = [self.LattitudeArray1 indexOfObject:[NSString stringWithFormat:@"%f",draggedCoordinate.latitude] ] ;
        
        [self.LattitudeArray1 removeObjectAtIndex:index];
        [self.LongitudeArray1 removeObjectAtIndex:index];
        
        NSLog(@"%@",self.LattitudeArray1);
        NSLog(@"%@",self.LongitudeArray1);
        
        
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        
        
        
        CurrentSelectedCoordinate=droppedAt;
        
        [self.LattitudeArray1 insertObject:[NSString stringWithFormat:@"%f",droppedAt.latitude] atIndex:index];
        [self.LongitudeArray1 insertObject:[NSString stringWithFormat:@"%f",droppedAt.longitude] atIndex:index];
        NSLog(@"%@",self.LattitudeArray1);
        NSLog(@"%@",self.LongitudeArray1);
        
        
        CLLocationCoordinate2D *coordsForFillingPolygon =malloc(sizeof(CLLocationCoordinate2D) *[self.LattitudeArray1 count]);
        
        
        
        
        for (int idx=0;idx<[self.LattitudeArray1 count]; idx++) {
            
            
            coordsForFillingPolygon[idx] = CLLocationCoordinate2DMake([[self.LattitudeArray1 objectAtIndex:idx]floatValue ],[[self.LongitudeArray1 objectAtIndex:idx] floatValue]);
        }
        
        if (OverlayModel==1) {
            
            MKPolygon *commuterParkingPolygon=[MKPolygon polygonWithCoordinates:coordsForFillingPolygon count:[self.LattitudeArray1 count]];
            [self.MapView addOverlay:commuterParkingPolygon];
        }
        else if (OverlayModel==2) {
            MKPolyline *commuterParkingPolygon=[MKPolyline polylineWithCoordinates:coordsForFillingPolygon count:[self.LattitudeArray1 count]];
            [self.MapView addOverlay:commuterParkingPolygon];
        }
        if (OverlayModel==3) {
            MKCircle *commuterParkingPolygon=[MKCircle circleWithCenterCoordinate:droppedAt radius:110];
            [self.MapView addOverlay:commuterParkingPolygon];
            
        }
        
        
    }
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    draggedCoordinate = view.annotation.coordinate;
    
}
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
    
    
    
    
    //   [self performSelector:@selector(removeOverlays) withObject:Nil];
    
    
    
    NSLog(@"%lu",(unsigned long)[[self.MapView overlays] count]);
    
    
    
    if([overlay isKindOfClass:[MKPolygon class]]){
        
        
        PolygonView = [[MKPolygonView alloc] initWithOverlay:overlay];
        PolygonView.lineWidth=5;
        PolygonView.tag=222;
        PolygonView.strokeColor=[UIColor redColor];
        PolygonView.fillColor=[[UIColor orangeColor] colorWithAlphaComponent:0.2];
        return [PolygonView autorelease];
        
        
    }
    else if([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleView* circleView = [[[MKCircleView alloc] initWithOverlay:overlay] autorelease];
        circleView.fillColor = [UIColor blackColor];
        circleView.strokeColor = [UIColor blackColor];
        circleView.lineWidth = 5.0;
        circleView.alpha = 0.20;
        return circleView;
    }
    else if([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *view = [[MKPolylineView alloc] initWithOverlay:overlay];
        view.lineWidth=5;
        view.tag=222;
        view.strokeColor=[UIColor redColor];
        view.fillColor=[[UIColor orangeColor] colorWithAlphaComponent:0.2];
        return [view autorelease];
        
    }
    
    return nil;
}

- (IBAction)saveItAsImageButtonPressed:(id)sender {
    
    
    self.TicketNumber=@"345344e";
    
    UIGraphicsBeginImageContext(self.MapView.bounds.size);
	[self.MapView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage* image1 = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
	// If you go to the folder below, you will find those pictures
	NSLog(@"%@",docDir);
    
	NSLog(@"saving png");
	NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@_RedLined.png",docDir,self.TicketNumber];
	NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image1)];
	[data1 writeToFile:pngFilePath atomically:YES];
    
	NSLog(@"saving jpeg");
	NSString *jpegFilePath =  [NSString stringWithFormat:@"%@/%@_RedLined.png",docDir,self.TicketNumber];
	NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image1, 1.0f)];//1.0f = 100% quality
	[data2 writeToFile:jpegFilePath atomically:YES];
    
	NSLog(@"saving image done");
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_testView release];
    
    [TestLanguageLabel release];
    [slider release];
    [testImage release];
    [super dealloc];
}
- (IBAction)addImageButtonPressed:(id)sender {
    
    UIImageView *img=[[UIImageView alloc]initWithImage:selectedImage];
    
    if (holderView) {
        [holderView removeFromSuperview];
    }
    
    holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, img.frame.size.width, img.frame.size.height)];
    
    [holderView addSubview:img];
    
    [img release];
    
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [holderView addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [rotationRecognizer setDelegate:self];
    [holderView addGestureRecognizer:rotationRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [holderView addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setDelegate:self];
    [holderView addGestureRecognizer:tapRecognizer];
    
    
    
    [self.testView addSubview:holderView];
    
    
}
-(void)scale:(id)sender {
	
	[self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
	
	if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
		
		lastScale = 1.0;
		return;
	}
	
	CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
	
	CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
	CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
	
	[[(UIPinchGestureRecognizer*)sender view] setTransform:newTransform];
	
	lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

-(void)rotate:(id)sender {
	
	[self.view bringSubviewToFront:[(UIRotationGestureRecognizer*)sender view]];
	
	if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
		
		lastRotation = 0.0;
		return;
	}
	
	CGFloat rotation = 0.0 - (lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
	
	CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
	CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
	
	[[(UIRotationGestureRecognizer*)sender view] setTransform:newTransform];
	
	lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
}

-(void)move:(id)sender {
	
	[[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
	
	[self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		
		firstX = [[sender view] center].x;
		firstY = [[sender view] center].y;
	}
	
	translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
	
	[[sender view] setCenter:translatedPoint];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
		
		CGFloat finalX = translatedPoint.x + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
		CGFloat finalY = translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
		
		if(UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
			
			if(finalX < 0) {
				
				finalX = 0;
			}
			
			else if(finalX > 768) {
				
				finalX = 768;
			}
			
			if(finalY < 0) {
				
				finalY = 0;
			}
			
			else if(finalY > 1024) {
				
				finalY = 1024;
			}
		}
		
		else {
			
			if(finalX < 0) {
				
				finalX = 0;
			}
			
			else if(finalX > 1024) {
				
				finalX = 768;
			}
			
			if(finalY < 0) {
				
				finalY = 0;
			}
			
			else if(finalY > 768) {
				
				finalY = 1024;
			}
		}
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.35];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[[sender view] setCenter:CGPointMake(finalX, finalY)];
		[UIView commitAnimations];
	}
}

-(void)tapped:(id)sender {
	
	[[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	
	return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}
- (IBAction)pointButtonPressed:(id)sender {
    
    
    
    for ( id<MKAnnotation> annotation in self.MapView.annotations ) {
        
        
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            
        }
        else
        {
            [self.MapView removeAnnotation:annotation];
        }
        
    }
    
    
    slider.hidden=YES;
    [self.LattitudeArray1 removeAllObjects];
    [self.LongitudeArray1 removeAllObjects];
    
    OverlayModel=1;
    
    selectedImage=[UIImage imageNamed:@"Point"];
    
    [self performSelector:@selector(addImageButtonPressed:) withObject:Nil afterDelay:0.0];
}

- (IBAction)squareButtonPressed:(id)sender {
    
   
    
    
    
    for ( id<MKAnnotation> annotation in self.MapView.annotations ) {
        
        
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            
        }
        else
        {
            [self.MapView removeAnnotation:annotation];
        }
        
    }
    
     slider.hidden=YES;
    
    [self.LattitudeArray1 removeAllObjects];
    [self.LongitudeArray1 removeAllObjects];
    
    OverlayModel=2;
    
    selectedImage=[UIImage imageNamed:@"Box"];
    
    [self performSelector:@selector(addImageButtonPressed:) withObject:Nil afterDelay:0.0];
}

- (IBAction)circleButtonPressed:(id)sender {
    
    
    for ( id<MKAnnotation> annotation in self.MapView.annotations ) {
        
        
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            
        }
        else
        {
            [self.MapView removeAnnotation:annotation];
        }
        
    }
    
    
    
    for (id<MKOverlay>  v1 in [self.MapView overlays]) {
        
        if ([v1 isKindOfClass:[MKCircle class]]) {
            
            [self.MapView removeOverlay:v1];
            
        }
        else
        {
            // [self.MapView removeOverlay:v1];
        }
    }
    
    slider.hidden=NO;
    [self.LattitudeArray1 removeAllObjects];
    [self.LongitudeArray1 removeAllObjects];
    
    
    OverlayModel=3;
    
    selectedImage=[UIImage imageNamed:@"circle"];
    
    [self performSelector:@selector(addImageButtonPressed:) withObject:Nil afterDelay:0.0];
}
- (IBAction)removeAllOverlaysButtonPressed:(id)sender {
    
    
    NSLog(@"%@",[self.MapView overlays]);
    
    for (UIView *view in [self.MapView overlays]) {
        
        
        if ([view isKindOfClass:[MKCircle class]])
        {
            [self.MapView removeOverlay:(MKCircle *)view];
        }
        else if ([view isKindOfClass:[MKPolyline class]])
        {
            [self.MapView removeOverlay:(MKPolyline *)view];
        }
        else if ([view isKindOfClass:[MKPolygon class]])
        {
            [self.MapView removeOverlay:(MKPolygon *)view];
        }
    }
    
    for (UIView *view in [self.MapView subviews]) {
        
        
        id userLocation = [self.MapView userLocation];
        NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[self.MapView annotations]];
        if ( userLocation != nil ) {
            [pins removeObject:userLocation]; // avoid removing user location off the map
        }
        
        [self.MapView removeAnnotations:pins];
        [pins release];
        pins = nil;
    }
    
}
-(void)removeOverlays
{
    NSLog(@"%@",[self.MapView overlays]);
    
    for (UIView *view in [self.MapView overlays]) {
        
        
        if ([view isKindOfClass:[MKCircle class]])
        {
            [self.MapView removeOverlay:(MKCircle *)view];
        }
        else if ([view isKindOfClass:[MKPolyline class]])
        {
            [self.MapView removeOverlay:(MKPolyline *)view];
        }
        else if ([view isKindOfClass:[MKPolygon class]])
        {
            [self.MapView removeOverlay:(MKPolygon *)view];
        }
    }
}
-(void)showInMap :(NSString *)latitude :(NSString *)longitude
{
    
    NSString* TaskLattitude = latitude;
    NSString* TaskLongitude = longitude;
    float t1 = [TaskLattitude floatValue];
    float t2 = [TaskLongitude floatValue];
    
    
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:t1 longitude:t2];;
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    MKCoordinateSpan span1= MKCoordinateSpanMake(.0045, .0057);
    MKCoordinateRegion region1 = {coordinate, span1};
    [self.MapView setRegion:region1 animated:YES];
    self.MapView.showsUserLocation=NO;
    
    MKPointAnnotation *points = [[MKPointAnnotation alloc] init];
    points.coordinate=coordinate;

    points.title=[NSString stringWithFormat:@"Inspection Location"];
    
    
    if (pointsA.annotation) {
        
        [self.MapView removeAnnotation:pointsA.annotation];
    }
    
    pointsA = [[MKPinAnnotationView alloc] initWithAnnotation:points reuseIdentifier:nil] ;
    pointsA.pinColor = MKPinAnnotationColorGreen;
    pointsA.draggable=NO;
    pointsA.userInteractionEnabled=NO;
    pointsA.canShowCallout = YES;
    pointsA.canShowCallout=YES;
    
    [self.MapView addAnnotation:pointsA.annotation];
    
   // [self.MapView addAnnotation:pointsA.annotation];
    

    
    
    
}



- (IBAction)cancelRedLiningButtonPressed:(id)sender {
}

- (IBAction)undoRedLiningButtonPressed:(id)sender {
    
    
    NSLog(@"%@",self.MapView.annotations);
    
    id<MKAnnotation> annotation =self.MapView.annotations.lastObject;
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        
    }
    else
    {
        [self.MapView removeAnnotation:annotation];

        
       NSLog(@"%@",self.MapView.annotations); 
    }
    
    
    
    
    
    
    
    if ([self.LattitudeArray1 count]==0) {
        
        
        NSLog(@"%@",self.MapView.annotations);
        for ( id<MKAnnotation> annotation in self.MapView.annotations ) {
            
            
            if ([annotation isKindOfClass:[MKUserLocation class]]) {
                
            }
            else
            {
                [self.MapView removeAnnotation:annotation];
            }
            
        }
   
    }
    
    
    
    [self.MapView removeAnnotation:annotation];
    NSLog(@"%@",self.MapView.annotations);
    
    
    [self removeOverlays];
    
    NSLog(@"%@",self.LattitudeArray1);
    NSLog(@"%@",self.LongitudeArray1);
    
    [self.LattitudeArray1 removeLastObject];
    [self.LongitudeArray1 removeLastObject];
    

   
    
    NSLog(@"%@",self.LattitudeArray1);
    NSLog(@"%@",self.LongitudeArray1);
    
    
    CLLocationCoordinate2D droppedAt = CurrentSelectedCoordinate;
    NSLog(@"dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
    
    
    
   // CurrentSelectedCoordinate=droppedAt;
    
    
    CLLocationCoordinate2D *coordsForFillingPolygon =malloc(sizeof(CLLocationCoordinate2D) *[self.LattitudeArray1 count]);
    
    
    
    if ([self.LattitudeArray1 count] >0) {
        
   
    
    for (int idx=0;idx<[self.LattitudeArray1 count]; idx++) {
        
        
        coordsForFillingPolygon[idx] = CLLocationCoordinate2DMake([[self.LattitudeArray1 objectAtIndex:idx]floatValue ],[[self.LongitudeArray1 objectAtIndex:idx] floatValue]);
    }
    
    if (OverlayModel==1) {
        
        MKPolygon *commuterParkingPolygon=[MKPolygon polygonWithCoordinates:coordsForFillingPolygon count:[self.LattitudeArray1 count]];
        [self.MapView addOverlay:commuterParkingPolygon];
    }
    else if (OverlayModel==2) {
        MKPolyline *commuterParkingPolygon=[MKPolyline polylineWithCoordinates:coordsForFillingPolygon count:[self.LattitudeArray1 count]];
        [self.MapView addOverlay:commuterParkingPolygon];
    }
    if (OverlayModel==3) {
        MKCircle *commuterParkingPolygon=[MKCircle circleWithCenterCoordinate:droppedAt radius:110];
        [self.MapView addOverlay:commuterParkingPolygon];
        
    }

    }
}

- (IBAction)drawButtonPressed:(id)sender {
}

- (IBAction)userLocationButtonPressed:(id)sender {
    
    
    self.MapView.mapType = MKMapTypeStandard;
    self.MapView.delegate=self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    MKCoordinateSpan span1= MKCoordinateSpanMake(.0045, .0057);
    MKCoordinateRegion region1 = {coordinate, span1};
    [self.MapView setRegion:region1 animated:YES];
    self.MapView.showsUserLocation=YES;

}

- (IBAction)taskLocationButtonPressed:(id)sender {
    
    

    
    [self showInMap:@"8.822459" :@"76.678620"];
    
}
@end
