//
//  GameMain.h
//  Chippy Leap
//
//  Created by Christopher Livingston on 8/17/14.
//  Copyright (c) 2014 Chinchilla Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


int ChipGlide;
int randomLeftBranchPos;
int randomRightBranchPos;
int randomLeftTree;
int randomRightTree;
int branchDiff;
int branchGap;
float brSpeed;
int scoreNumber;
NSInteger controlType;
NSInteger highscore;

CGFloat screenWidth;
CGFloat screenHeight;


double currentMaxAccelX;
double currentMaxAccelY;
double currentMaxAccelZ;
double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;






@interface GameMain : UIViewController
{

    IBOutlet UIImageView *Chip;
    IBOutlet UIButton *StartGame;
    IBOutlet UIImageView *instructions;
    IBOutlet UIImageView *tilt;
    IBOutlet UIImageView *branchLeft;
    IBOutlet UIImageView *branchRight;
    IBOutlet UIImageView *lb1;
    IBOutlet UIImageView *rb1;
    IBOutlet UIImageView *lb2;
    IBOutlet UIImageView *rb2;
    IBOutlet UIImageView *lb3;
    IBOutlet UIImageView *rb3;
    IBOutlet UIImageView *lb4;
    IBOutlet UIImageView *rb4;
    IBOutlet UIImageView *trunkLeft;
    IBOutlet UIImageView *trunkRight;
    IBOutlet UIImageView *trunkLeft2;
    IBOutlet UIImageView *trunkRight2;
    IBOutlet UIImageView *startTreeLeft;
    IBOutlet UIImageView *startTreeRight;
    IBOutlet UIImageView *treeLeft;
    IBOutlet UIImageView *treeRight;
    IBOutlet UIButton *pauseplay;
    IBOutlet UIButton *menu;
    IBOutlet UIButton *reset;
    IBOutlet UILabel *score;
    IBOutlet UIImageView *scoreboard;
    IBOutlet UIImageView *gameOver;
    IBOutlet UISegmentedControl *scTouchTilt;
    IBOutlet UIImageView *bg;
    IBOutlet UIImageView *gameBack;
    
    //NSInteger controlType; testing import of this from game main
    
    NSTimer *ChipMovement;
    NSTimer *BranchMovement;
    NSTimer *gameover;
    NSTimer *rotc;
    UIAlertController * alt;
    
}


@property (strong, nonatomic) CMMotionManager *motionManager;

@property (strong, nonatomic) IBOutlet UILabel *accX;
@property (strong, nonatomic) IBOutlet UILabel *accY;
@property (strong, nonatomic) IBOutlet UILabel *accZ;

@property (strong, nonatomic) IBOutlet UILabel *maxAccX;
@property (strong, nonatomic) IBOutlet UILabel *maxAccY;
@property (strong, nonatomic) IBOutlet UILabel *maxAccZ;

@property (strong, nonatomic) IBOutlet UILabel *rotX;
@property (strong, nonatomic) IBOutlet UILabel *rotY;
@property (strong, nonatomic) IBOutlet UILabel *rotZ;

@property (strong, nonatomic) IBOutlet UILabel *maxRotX;
@property (strong, nonatomic) IBOutlet UILabel *maxRotY;
@property (strong, nonatomic) IBOutlet UILabel *maxRotZ;


- (IBAction)resetMaxValues:(id)sender;

- (IBAction)StartGame:(id)sender;
- (void)ChipMoving;
- (void)BranchesMoving;
- (void)PlaceBranch;
- (void)Score;
- (void)GameOver;
- (void)ChipDies;
- (void)playScoreSound;
- (void)rescale;
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;



@end
