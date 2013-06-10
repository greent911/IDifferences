//
//  ChallengeViewController.m
//  SpotDiferences
//
//  Created by Bean on 13/6/5.
//
//

#import "ChallengeViewController.h"
#import "SoundManager.h"
#import "GameViewController.h"
#import "UikitFramework.h"
#import "SoundManager.h"
#import "InicialViewController.h"
#import "Maze+Manage.h"
#import "MyDocumentHandler.h"
#import "ImageDetailViewController.h"



@interface ChallengeViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@property (strong, nonatomic) IBOutlet UIButton *CH1;
@property (strong, nonatomic) IBOutlet UIButton *CH2;
@property (strong, nonatomic) IBOutlet UIButton *CH3;


@end

@implementation ChallengeViewController
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
    self.imageview.image = [UIImage imageNamed:@"sky"];
}

-(void)playInterfaceSound
{
    [[SoundManager sharedSoundManager] playInterface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    //[self setViewimage:nil];
    [self setImageview:nil];
    [self setCH1:nil];
    [self setCH2:nil];
    [self setCH3:nil];
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.CH1.tag = 1;
    
    [self.CH1 addTarget:self action:@selector(CH1ButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bbutton = [UikitFramework createButtonWithBackgroudImage:@"backButton" title:@"" positionX:10 positionY:10];
    bbutton.frame = CGRectMake(0, 205, 60, 40);
    [bbutton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bbutton];
    
    int level = [prefs integerForKey:@"level"];
    
    switch (level) {
        case 3:
            [self.CH3 setBackgroundImage:[UIImage imageNamed:@"level_pink.png"] forState:UIControlStateNormal];
            [self.CH3 setTitle:@"3" forState:UIControlStateNormal];
            self.CH2.tag = 3;
            [self.CH3 addTarget:self action:@selector(CH1ButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        case 2:
            [self.CH2 setBackgroundImage:[UIImage imageNamed:@"level_pink.png"] forState:UIControlStateNormal];
            [self.CH2 setTitle:@"2" forState:UIControlStateNormal];
            self.CH2.tag = 2;
            [self.CH2 addTarget:self action:@selector(CH1ButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    
    
    //[self.view addSubview:ChallengeButton];

}

-(void)backButtonTapped:(UIButton*)sender
{
    [self playInterfaceSound];
    [[self navigationController]popViewControllerAnimated:YES];
}

-(void) CH1ButtonTapped:(UIButton*)sender
{
    NSLog(@"CH1ButtonTapped");
//    [self playInterfaceSound];
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    [prefs setObject:@"challenge" forKey:@"gameMode"];
//    [prefs synchronize];
//    //NSLog(@"%@",[prefs stringForKey:@"gameMode"]);
//    [self performSegueWithIdentifier:@"ChallengeStart" sender:self];
    
    [self playInterfaceSound];
    [self setGameState:@"challenge"];
    UIButton* btn = sender;
    int number;
    switch(btn.tag)
    {
        case 1:
            number = 1;
            break;
        case 2:
            number = 2;
            break;
        case 3:
            number = 3;
            break;
    }
    //[self setGameState:@"normal"];
    /*
     [self performSegueWithIdentifier:@"go to dificulty" sender:self];
     */
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:@"beginner" forKey:@"difficulty"];
    [prefs setInteger:number forKey:@"number"];
    [prefs setObject:@"surprise" forKey:@"gameFlow"];
    
    [prefs synchronize];
    //NSArray *allMAzes = [Maze getMazeByState:@"normal" inManagedObjectContext:self.document.managedObjectContext];
    
    NSArray *allMAzes = [Maze getMazeByState:@"challenge" inManagedObjectContext:self.document.managedObjectContext];
    
//    Maze *maze=[Maze getMazeByName:@"birds" inManagedObjectContext:self.document.managedObjectContext];
//    NSLog(maze.name);
    if ([allMAzes count] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"No Game!!!"
                                  message:nil
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        NSLog(@"YA");
        [alertView show];
    }else {
        [self performSegueWithIdentifier:@"ChallengeStart" sender:self];
    }

}


-(void)setGameState:(NSString*)state
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:state forKey:@"gameState"];
    [prefs synchronize];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ChallengeStart"]) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        //NSString *gameFlow = [prefs objectForKey:@"gameFlow"];
        NSString *gameState = [prefs stringForKey:@"gameState"];
        NSString *number = [prefs stringForKey:@"number"];
        NSString *PhotoName = [NSString stringWithFormat:@"C0%@", number];
        //NSArray *allMAzes = [Maze getMazeByState:gameState inManagedObjectContext:self.document.managedObjectContext];
        //int number = (arc4random()%[allMAzes count]);
        Maze *maze=[Maze getMazeByName:PhotoName inManagedObjectContext:self.document.managedObjectContext];
        //Maze *maze = [allMAzes objectAtIndex:number];
        GameViewController  *gvc = (GameViewController *)segue.destinationViewController;
        [gvc setupWith:maze andContext: [_document managedObjectContext]];
    }
    
}
@end
