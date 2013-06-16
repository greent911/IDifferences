//
//  MoveImageView.h
//  moveImageView
//
//  Created by greent on 13/6/9.
//  Copyright (c) 2013年 greent. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MoveImageViewDelegate
@optional
-(void) playTouchSound;

@end


@interface MoveImageView : UIImageView
{
    CGPoint location;
    UIImage *iImg;
    UIImage *touchedImg;
    CGPoint endlocation;
    BOOL isShow;
}
@property (nonatomic, weak) id<MoveImageViewDelegate> moveImageViewDelegate;


- (id)initWithImage:(UIImage *)img;
- (id)initWithRandomPointImage:(UIImage *)img andTouchedImage:(UIImage *)timg;
- (id)initWitPoint:(CGPoint)point Image:(UIImage *)img andTouchedImage:(UIImage *)timg;
-(void) startAppear;
//-(void) restartRandomAppear;
//-(void) restartAppear:(CGPoint) point;
-(void) resetPoint;
-(void) showViewMoveToBack;
@end
