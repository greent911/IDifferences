//
//  ChallengeViewController.h
//  SpotDiferences
//
//  Created by Bean on 13/6/5.
//
//

#import <UIKit/UIKit.h>
#import "Maze.h"

@interface ChallengeViewController : UIViewController

@property (nonatomic,weak) Maze *maze;
@property (nonatomic, weak)IBOutlet UIManagedDocument *document;
@property (nonatomic,weak) NSString *resumeName;

@end
