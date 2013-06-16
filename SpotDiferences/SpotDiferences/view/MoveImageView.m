//
//  MoveImageView.m
//  moveImageView
//
//  Created by greent on 13/6/9.
//  Copyright (c) 2013年 greent. All rights reserved.
//

#import "MoveImageView.h"

@implementation MoveImageView

@synthesize moveImageViewDelegate;

- (id)initWithImage:(UIImage *)img
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
		self.backgroundColor = [UIColor clearColor];
        self.image = img;
//        NSLog(@"%f,%f",img.size.width, img.size.height);
        [self setFrame:CGRectMake(200, 200, img.size.width, img.size.height)];
        
    }
    return self;
}
- (id)initWithRandomPointImage:(UIImage *)img andTouchedImage:(UIImage *)timg
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
		self.backgroundColor = [UIColor clearColor];
        iImg=img;
        self.image = img;
        touchedImg=timg;
//        NSLog(@"%f,%f",img.size.width, img.size.height);
//        NSLog(@"%fx%f",[ UIScreen mainScreen].bounds.size.width,[ UIScreen mainScreen].bounds.size.height);
        int x=arc4random()%(int)([ UIScreen mainScreen].bounds.size.height-img.size.width);
        int y=arc4random()%(int)([ UIScreen mainScreen].bounds.size.width-img.size.height);
        location=CGPointMake(x, y);
        endlocation=CGPointMake(0, 0);
        isShow=NO;

//        [self setFrame:CGRectMake(x, y, img.size.width, img.size.height)];
//        NSLog(@"initloc:%f %f",self.frame.origin.x,self.frame.origin.y);
    }
    return self;
}
- (id)initWitPoint:(CGPoint)point Image:(UIImage *)img andTouchedImage:(UIImage *)timg
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
		self.backgroundColor = [UIColor clearColor];
        iImg=img;
        self.image = img;
        touchedImg=timg;
//        NSLog(@"%f,%f",img.size.width, img.size.height);
        location=CGPointMake(point.x, point.y);
        endlocation=CGPointMake(0, 0);

//        [self setFrame:CGRectMake(point.x, point.y, img.size.width, img.size.height)];
        
    }
    return self;
}

-(CGPoint) randomGo
{
    CGPoint loc;
    loc.x=0-self.image.size.width;
    loc.y=0-self.image.size.height;
    int randomDirect=(arc4random()%8);
//    NSLog(@"randomDirect:%d",randomDirect);
    switch (randomDirect) {
        case 0:
            loc.x=0-self.image.size.width;
            loc.y=0-self.image.size.height;
            break;
        case 1:
            loc.x=(arc4random()%((int)[ UIScreen mainScreen].bounds.size.height+1));
            loc.y=0-self.image.size.height;
            break;
        case 2:
            loc.x=[UIScreen mainScreen].bounds.size.height;
            loc.y=0-self.image.size.height;
            break;
        case 3:
            loc.x=[UIScreen mainScreen].bounds.size.height;
            loc.y=(arc4random()%((int)[ UIScreen mainScreen].bounds.size.width+1));
            break;
        case 4:
            loc.x=[UIScreen mainScreen].bounds.size.height;
            loc.y=[ UIScreen mainScreen].bounds.size.width;
            break;
        case 5:
            loc.x=(arc4random()%((int)[ UIScreen mainScreen].bounds.size.height+1));
            loc.y=[ UIScreen mainScreen].bounds.size.width;
            break;
        case 6:
            loc.x=0-self.image.size.width;
            loc.y=[ UIScreen mainScreen].bounds.size.width;
            break;
        case 7:
            loc.x=0-self.image.size.width;
            loc.y=(arc4random()%((int)[ UIScreen mainScreen].bounds.size.width+1));
            break;
        default:
            break;
    }
    return loc;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    //將被觸碰到鍵移動到所有畫面的最上層
    [[self superview] bringSubviewToFront:self];
    
//    CGPoint point = [[touches anyObject] locationInView:self];
//    while (self.frame.origin.y != [ UIScreen mainScreen].bounds.size.height-100) {
        [self setImage:touchedImg];
    [self.moveImageViewDelegate playTouchSound];
    
    endlocation=[self randomGo];
    [UIView animateWithDuration:1.0f animations:^{
            self.frame = CGRectOffset(self.frame, endlocation.x-self.frame.origin.x, endlocation.y-self.frame.origin.y);
    }];
    isShow=NO;
//    }
}
-(void) showViewMoveToBack
{
    if (isShow) {
        [self setImage:touchedImg];
        endlocation=[self randomGo];
        [UIView animateWithDuration:1.0f animations:^{
            self.frame = CGRectOffset(self.frame, endlocation.x-self.frame.origin.x, endlocation.y-self.frame.origin.y);
        }];
        isShow=NO;
    }
}

-(void) resetPoint{
    [self setImage:iImg];
    CGPoint randomLoc=[self randomGo];

    [self setFrame:CGRectMake(randomLoc.x, randomLoc.y, self.image.size.width, self.image.size.height)];
    endlocation.x=0;
    endlocation.y=0;
    isShow=NO;
}

-(void) startAppear
{
    CGPoint randomLoc=[self randomGo];
    [self setFrame:CGRectMake(randomLoc.x, randomLoc.y, self.image.size.width, self.image.size.height)];

    [UIView animateWithDuration:1.0f animations:^{
        self.frame = CGRectOffset(self.frame, location.x-randomLoc.x, location.y-randomLoc.y);
    }];
    isShow=YES;
}

//-(void) restartRandomAppear
//{
//    if(endlocation.x !=0 && endlocation.y !=0){
//    [self setImage:iImg];
//    int x=arc4random()%(int)([ UIScreen mainScreen].bounds.size.width-iImg.size.width);
//    int y=arc4random()%(int)([ UIScreen mainScreen].bounds.size.height-iImg.size.height);
//    CGPoint randomNewLoc=CGPointMake(x, y);
//    [UIView animateWithDuration:1.0f animations:^{
//        self.frame = CGRectOffset(self.frame, randomNewLoc.x-endlocation.x, randomNewLoc.y-endlocation.y);
//    }];
//        endlocation.x=0;
//        endlocation.y=0;
//    }
//
//}
//
//-(void) restartAppear:(CGPoint) point
//{
//    if(endlocation.x !=0 && endlocation.y !=0){
//        [self setImage:iImg];
//        CGPoint randomNewLoc=CGPointMake(point.x, point.y);
//        [UIView animateWithDuration:1.0f animations:^{
//            self.frame = CGRectOffset(self.frame, randomNewLoc.x-endlocation.x, randomNewLoc.y-endlocation.y);
//        }];
//        endlocation.x=0;
//        endlocation.y=0;
//    }
//    
//}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    CGPoint point = [[touches anyObject] locationInView:self];
//    
//    CGRect frame = self.frame;
//    
//    frame.origin.x += point.x - location.x;
//    frame.origin.y += point.y - location.y;
//    [self setFrame:frame];
//    
//    NSLog(@"x:%@",[NSString stringWithFormat:@"%.f", frame.origin.x]);
//    NSLog(@"y:%@",[NSString stringWithFormat:@"%.f", frame.origin.y]);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
