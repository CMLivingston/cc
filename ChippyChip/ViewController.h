//
//  ViewController.h
//  Chippy Leap
//
//  Created by Christopher Livingston on 8/17/14.
//  Copyright (c) 2014 Chinchilla Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTilt 0
#define kTouch 1

NSInteger HighScoreNumber;
NSInteger tapOrTouch;


@interface ViewController : UIViewController
{

    IBOutlet UIButton *HighScore;
    IBOutlet UIButton *settings;
    IBOutlet UIButton *start;
    IBOutlet UIImageView *title;
    IBOutlet UISegmentedControl *scTouchTilt;
    IBOutlet UIButton *backToHome;
    IBOutlet UIImageView *bg;
    UIAlertController * alert;
    //NSInteger controlType;
    //int controlType;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl * scTouchTilt;

- (IBAction)Scorez:(id)sender;
- (IBAction)Settings:(id)sender;
- (IBAction)Home:(id)sender;

@end
