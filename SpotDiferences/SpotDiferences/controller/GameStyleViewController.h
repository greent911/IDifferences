//
//  GameStyleViewController.h
//  SpotDiferences
//
//  Created by Mobile Team (G4M) on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Maze.h"

@interface GameStyleViewController : UIViewController

@property (nonatomic,weak) Maze *maze;
@property (nonatomic, weak)IBOutlet UIManagedDocument *document;


@end
