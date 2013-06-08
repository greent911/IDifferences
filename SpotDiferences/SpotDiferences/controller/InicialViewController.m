//
//  InicialViewController.m
//  SpotDiferences
//
//  Created by Mobile Team (G4M) on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "InicialViewController.h"
#import "MyDocumentHandler.h"
#import "Theme+Create.h"
#import "ThemeViewController.h"
#import "Seed.h"
#import "Maze+Manage.h"
#import "DifficultyViewController.h"
#import "SoundManager.h"
#import "GameCenterManager.h"
#import "AccountSettingsViewController.h"
#define fontSize 15
#define fontName @"junegull"

@interface InicialViewController ()
@property (nonatomic,weak) UIButton *NewGameButton;
@end

@implementation InicialViewController

@synthesize  document = _document;
@synthesize imageview = _imageview;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)playInterfaceSound
{
    [[SoundManager sharedSoundManager] playInterface];
}

-(void)playSound
{
    [[SoundManager sharedSoundManager] playIntro];
}

-(void)submeteUnsubmetedScores
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate testReachability]) {
        NSArray* mazes = [Maze getUnSubmetedMazes:self.document.managedObjectContext];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *loggedinUser = [prefs stringForKey:@"loggedinUser"];
        if ([loggedinUser isEqualToString:@"YES"] && [mazes count] > 0) {
            for (int c = 0; c < [mazes count]; c++) {
                Maze * maze = [mazes objectAtIndex:c];
                AccountSettingsViewController *scoreSender = [[AccountSettingsViewController alloc]init];
                scoreSender.document = self.document;
                [scoreSender submitScore:[maze.firstScore intValue]  scoreboard:maze.uniqueID];
                [scoreSender submitScore:[maze.firstTime intValue] scoreboard:[NSString stringWithFormat:@"%@.TIME",maze.uniqueID]];
            }
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self playSound];
    int offset = 40;
    int halfViewSize = [self view].frame.size.width / 2;

    UIImage *image = [UIImage imageNamed:@"beginning"];

    if (!self.NewGameButton) {
        //self.NewGameButton = [UikitFramework createButtonWithBackgroudImage:@"btn_wine" title:@"PLAY" positionX:halfViewSize - image.size.width -offset positionY:150];
        self.NewGameButton = [UikitFramework createButtonWithBackgroudImage:@"beginning" title:@"" positionX:halfViewSize - 4*offset positionY:20];
        self.NewGameButton.frame = CGRectMake(halfViewSize - 4*offset, 20, 300, 120);

        [self.NewGameButton addTarget:self action:@selector(playGameButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.NewGameButton];
        
        UIButton *BeginningIcon = [UikitFramework createButtonWithBackgroudImage:@"ChengYuan" title:@"" positionX:halfViewSize - 5*offset positionY:30];
        [BeginningIcon addTarget:self action:@selector(playGameButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        BeginningIcon.frame = CGRectMake(halfViewSize - 5*offset, 30, 45, 100);
        //BeginningButton.titleLabel.font = [UIFont fontWithName:fontName size: fontSize];
        [self.view addSubview:BeginningIcon];

        UIButton *ExcitingButton = [UikitFramework createButtonWithBackgroudImage:@"exciting" title:@"" positionX:halfViewSize - 3*offset positionY:90];
        ExcitingButton.frame = CGRectMake(halfViewSize - 3*offset, 90, 270, 120);

        [ExcitingButton addTarget:self action:@selector(excitingButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
       // ExcitingButton.titleLabel.font = [UIFont fontWithName:fontName size: fontSize];
        [self.view addSubview:ExcitingButton];
        
        UIButton *ExcitingIcon = [UikitFramework createButtonWithBackgroudImage:@"Rice" title:@"" positionX:halfViewSize + 3.8*offset positionY:90];
        [ExcitingIcon addTarget:self action:@selector(excitingButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        ExcitingIcon.frame = CGRectMake(halfViewSize + 3.8*offset, 90, 45, 100);
        [self.view addSubview:ExcitingIcon];
        
        UIButton *ChallengeButton = [UikitFramework createButtonWithBackgroudImage:@"challenging" title:@"" positionX:halfViewSize - 4*offset positionY:180];
        ChallengeButton.frame = CGRectMake(halfViewSize - 4*offset, 180, 360, 110);

        [ChallengeButton addTarget:self action:@selector(challengeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        //ChallengeButton.titleLabel.font = [UIFont fontWithName:fontName size: fontSize];
        [self.view addSubview:ChallengeButton];
        
        UIButton *ChallengingIcon = [UikitFramework createButtonWithBackgroudImage:@"Bean" title:@"" positionX:halfViewSize - 5*offset positionY:190];
        [ChallengingIcon addTarget:self action:@selector(challengeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        ChallengingIcon.frame = CGRectMake(halfViewSize - 5*offset, 190, 45, 100);
        [self.view addSubview:ChallengingIcon];
        

    
        /*
        UIButton * visitUsButton = [UikitFramework createButtonWithBackgroudImage:@"icon_weblink" title:@"" positionX:self.view.frame.size.width - 70 positionY:30];
        [visitUsButton addTarget:self action:@selector(visitUsButtonButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        visitUsButton.titleLabel.font = [UIFont fontWithName:fontName size: fontSize];
        [self.view addSubview:visitUsButton];

        UILabel *label = [UikitFramework createLableWithText:@"VISIT US" positionX:visitUsButton.frame.origin.x - 45 positionY:visitUsButton.frame.origin.y + 15 width:100 height:100];
        
        [self.view addSubview:label];
         */
        /*
        UIButton * gamecenterButton = [UikitFramework createButtonWithBackgroudImage:@"Game_Center_logo" title:@"" positionX:20 positionY:30];
        [gamecenterButton addTarget:self action:@selector(gamecenterButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        gamecenterButton.titleLabel.font = [UIFont fontWithName:fontName size: fontSize];
        [self.view addSubview:gamecenterButton];
         */
    }
    
    [self submeteUnsubmetedScores];
}
-(void) challengeButtonTapped:(UIButton*)sender
{
    NSLog(@"challengeButtonTapped");
    [self playInterfaceSound];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"challenge" forKey:@"gameMode"];
    [prefs synchronize];
    //NSLog(@"%@",[prefs stringForKey:@"gameMode"]);
    [self performSegueWithIdentifier:@"challenge" sender:self];
}

-(void) excitingButtonTapped:(UIButton*)sender
{
    NSLog(@"excitingButtonTapped");
    [self playInterfaceSound];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"exciting" forKey:@"gameMode"];
    [prefs synchronize];
    //NSLog(@"%@",[prefs stringForKey:@"gameMode"]);
    [self performSegueWithIdentifier:@"playStyle" sender:self];
}

-(void)gamecenterButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [[GameCenterManager sharedGameCenterManager] gameCenterAuthentication];
    
    NSString *gamecenterenable = [GameCenterManager sharedGameCenterManager].enableGameCenter;
    
    if ([gamecenterenable isEqualToString:@"YES"]) {
        NSString * leaderboardCategory = @"iDifferences.Global";
        [[GameCenterManager sharedGameCenterManager] showLeaderboard:leaderboardCategory viewController:self];
    }
    

    /*
    int64_t score = 2001;
    GKScore * submitScore = [[GKScore alloc] initWithCategory:leaderboardCategory];
    [submitScore setValue:score];
    [submitScore setShouldSetDefaultLeaderboard:YES];
    
    //[[GameCenterManager sharedGameCenterManager] submitScore:submitScore];
     */

}

-(void)visitUsButtonButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];

     NSURL *url = [NSURL URLWithString:@"http://www.idifferences.com"];
     
     if (![[UIApplication sharedApplication] openURL:url])
     NSLog(@"%@%@",@"Failed to open url:",[url description]);

}

-(void)playGameButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"Soft" forKey:@"gameMode"];
    [prefs synchronize];
    
    [self performSegueWithIdentifier:@"playStyle" sender:self];
}



-(void)setGameState:(NSString*)state
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:state forKey:@"gameState"];
    [prefs synchronize];

}

-(void)buyButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [self performSegueWithIdentifier:@"buy" sender:self];
}

-(void)highscoresButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [self performSegueWithIdentifier:@"highscores" sender:self];
}

-(void)settingsButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [self performSegueWithIdentifier:@"settings" sender:self];
}

-(void)newGameButtonTapped:(UIButton *)sender
{
    [self playInterfaceSound];
    [self setGameState:@"normal"];
    [self performSegueWithIdentifier:@"go to dificulty" sender:self];
}

-(void)finishedGameButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [self setGameState:@"finished"];
    [self performSegueWithIdentifier:@"go to dificulty" sender:self];

}

-(void)resumeGameButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [self setGameState:@"paused"];
    [self performSegueWithIdentifier:@"resumeGame" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageview.image = [UIImage imageNamed:@"blackboard"]; 
    /*
    UIImageView *imageview = [UikitFramework createImageViewWithImage:@"logo_idifferences" positionX:0 positionY:0];
    NSLog(@"imageview %fx%f",imageview.frame.size.width,imageview.frame.size.height);
    [self.view addSubview:imageview];
     */
    
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.frame = CGRectMake(0, 0, 480, 128.5);
//    titleLabel.font = [UIFont fontWithName:fontName size:50];
//    titleLabel.adjustsFontSizeToFitWidth = YES;
//    titleLabel.text = @"我們愛找碴！";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [titleLabel setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:titleLabel];
    
    
    
    
    
    [[MyDocumentHandler sharedDocumentHandler] performWithDocument:^(UIManagedDocument *document){
        _document = document;
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"go to dificulty"]){
        //DifficultyViewController *DVC = (DifficultyViewController*)segue.destinationViewController;
        //[DVC setDocument:self.document];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
