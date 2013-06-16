//
//  GameStyleViewController.m
//  SpotDiferences
//
//  Created by Mobile Team (G4M) on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameStyleViewController.h"
#import "UikitFramework.h"
#import "SoundManager.h"
#import "InicialViewController.h"
#import "GameViewController.h"
#import "Maze+Manage.h"
#import "MyDocumentHandler.h"
#import "ImageDetailViewController.h"



@interface GameStyleViewController ()
@property (nonatomic,weak) IBOutlet UIImageView *imageview;
@end

@implementation GameStyleViewController
@synthesize imageview = _imageview;
@synthesize document = _document;
@synthesize resumeName= _resumeName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[MyDocumentHandler sharedDocumentHandler] performWithDocument:^(UIManagedDocument *document){
        _document = document;
    }];

	// Do any additional setup after loading the view.
    self.imageview.image = [UIImage imageNamed:@"selectGameStatus"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self playSound];
    int offset = 25;
    int halfViewSize = [self view].frame.size.width / 2;
    UIImage *image = [UIImage imageNamed:@"btn_wine"];
    
    UIImage *bimage = [UIImage imageNamed:@"btn_back"];
    
    UIButton *bbutton = [UikitFramework createButtonWithBackgroudImage:@"backButton" title:@"" positionX:5 positionY:220];
    bbutton.frame = CGRectMake(20, 250, 60, 40);
    [bbutton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bbutton];
    
//    UIButton *homeButton = [UikitFramework createButtonWithBackgroudImage:@"btn_home" title:@"" positionX:self.view.frame.size.width - 10 - bimage.size.width positionY:10]; 
//    [homeButton addTarget:self action:@selector(homeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:homeButton];

//    UIButton *resumeGameButton = [UikitFramework createButtonWithBackgroudImage:@"btn_darkpink" title:@"RESUME" positionX:halfViewSize - image.size.width / 2 positionY:150];
    UIButton *resumeGameButton = [UikitFramework createButtonWithBackgroudImage:@"ResumeButton" title:@"" positionX:halfViewSize +image.size.width * 0.5+ offset positionY:150];
    resumeGameButton.frame = CGRectMake(halfViewSize - 5*offset, 140, 283, 65);
    [resumeGameButton addTarget:self action:@selector(resumeGameButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeGameButton];
    
    UIButton *newGameButton = [UikitFramework createButtonWithBackgroudImage:@"NewGameButton" title:@"" positionX:halfViewSize - image.size.width * 1.5 - offset  positionY:150];
    newGameButton.frame = CGRectMake(halfViewSize - 5*offset, 200, 283, 65);
    [newGameButton addTarget:self action:@selector(newGameButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newGameButton];
    /*
    UIButton *finishedGameButton = [UikitFramework createButtonWithBackgroudImage:@"btn_pink" title:@"FINISHED" positionX:halfViewSize +image.size.width * 0.5+ offset  positionY:150];
    [finishedGameButton addTarget:self action:@selector(finishedGameButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishedGameButton];
    */
//    UILabel *label = [UikitFramework createLableWithText:@"SELECT GAME STATUS" positionX:0 positionY:0 width:self.view.frame.size.width height:100];
//    label.textAlignment = UITextAlignmentCenter;
//    label.font = [UIFont fontWithName:[UikitFramework getFontName] size: 25];
//    [self.view addSubview:label];
}

-(void)newGameButtonTapped:(UIButton *)sender
{
    [self playInterfaceSound];
    [self setGameState:@"normal"];
    /*
    [self performSegueWithIdentifier:@"go to dificulty" sender:self];
     */
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:@"beginner" forKey:@"difficulty"];
    [prefs setObject:@"surprise" forKey:@"gameFlow"];
    [prefs synchronize];
    NSString *gameMode=[prefs stringForKey:@"gameMode"];
    NSString *mazesState=@"normal";
    if ([gameMode isEqualToString:@"normal"]) {
        mazesState=@"normal";
    }else if ([gameMode isEqualToString:@"exciting"]){
        mazesState=@"exciting";
    }
    NSArray *allMAzes = [Maze getMazeByState:mazesState inManagedObjectContext:self.document.managedObjectContext];
    if ([allMAzes count] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"No Game!!!"
                                  message:nil
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }else {
        [self performSegueWithIdentifier:@"SoftExciting" sender:self];
    }
    
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
    //[self performSegueWithIdentifier:@"resumeGame" sender:self];
   // NSArray *resumeMazes = [Maze getMazeByResumedGames:self.document.managedObjectContext];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *gameMode=[prefs stringForKey:@"gameMode"];
    NSString *pausedState=[NSString stringWithFormat:@"paused%@",gameMode];
    NSArray *resumeMazes=[Maze getMazeByState:pausedState inManagedObjectContext:self.document.managedObjectContext];
    if (resumeMazes) {
        Maze *resumeMaze=[resumeMazes objectAtIndex:0];
        _resumeName = resumeMaze.name;
        NSLog(@"_resumeName:%@",_resumeName);
//        [self performSegueWithIdentifier:@"resume" sender:self];
        [self performSegueWithIdentifier:@"SoftExciting" sender:self];


    } else {
        NSLog(@"No Resume Game!!!");
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"No Resume Game!!!"
                                  message:nil
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)setGameState:(NSString*)state
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:state forKey:@"gameState"];
    [prefs synchronize];
    tapState=state;
    
}

-(void)playSound
{
    [[SoundManager sharedSoundManager] playIntro];
}

-(void)playInterfaceSound
{
    [[SoundManager sharedSoundManager] playInterface];
}

-(void)backButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [[self navigationController]popViewControllerAnimated:YES];
}

- (IBAction) backToHome {
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for (int c=0; c < [viewControllers count]; c++) {
        id obj = [viewControllers objectAtIndex:c];
        if([obj isKindOfClass:[InicialViewController class]])
            [self.navigationController popToViewController:obj animated:YES];    
    }
}

-(void)homeButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [self backToHome];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SoftExciting"]) {
    if ([tapState isEqualToString:@"normal"]) {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //NSString *gameFlow = [prefs objectForKey:@"gameFlow"];
    NSString *gameMode = [prefs stringForKey:@"gameMode"];
        NSString *mazesState=@"normal";
        if ([gameMode isEqualToString:@"normal"]) {
            mazesState=@"normal";
        }else if ([gameMode isEqualToString:@"exciting"]){
            mazesState=@"exciting";
        }
    NSArray *allMAzes = [Maze getMazeByState:mazesState inManagedObjectContext:self.document.managedObjectContext];
    int number = (arc4random()%[allMAzes count]);
    Maze *maze = [allMAzes objectAtIndex:number];
    GameViewController *gvc = (GameViewController*)segue.destinationViewController;
    [gvc setupWith:maze andContext: [_document managedObjectContext]];
//    }else if([segue.identifier isEqualToString:@"resume"]){
    }else if([tapState isEqualToString:@"paused"]){
//        ImageDetailViewController* idc = segue.destinationViewController;
//        /*
//        NSArray *resumeMazes = [Maze getMazeByResumedGames:self.document.managedObjectContext];
//        Maze *resumeMaze=[resumeMazes objectAtIndex:0];
//                NSString *name=resumeMaze.name;
//        idc.foto = name;
//        NSLog(@"name:%@",name);
//         */
//        idc.foto=_resumeName;
//        [idc setDocument:self.document];
        Maze *resumeMaze=[Maze getMazeByName:_resumeName inManagedObjectContext:self.document.managedObjectContext];
        GameViewController *gvc = (GameViewController*)segue.destinationViewController;
        [gvc setupWith:resumeMaze andContext: [_document managedObjectContext]];
        
    }
    }
}
@end
