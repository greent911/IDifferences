/*
 *  GameViewController.h
 *  SpotDiferences
 *
 *  Copyright 2012 Go4Mobility
 *
 */

#import <UIKit/UIKit.h>
#import "MazeHelper.h"
#import "UikitFramework.h"
#import "ImageMaskView.h"

/**
 *
 * Game Controller
 *
 */
@interface GameViewController : UIViewController<ImageMaskFilledDelegate>

@property (nonatomic) MazeHelper *mazeHelper;
@property (nonatomic, weak) IBOutlet UIManagedDocument *document;
- (void) setupWith:(Maze*)maze andContext:(NSManagedObjectContext *)context;

@end
