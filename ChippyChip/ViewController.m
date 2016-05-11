
//
//  ViewController.m
//  Chippy Leap
//
//  Created by Christopher Livingston on 8/17/14.
//  Copyright (c) 2014 Chinchilla Studios. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()


@end

@implementation ViewController

    @synthesize scTouchTilt;



- (void)viewDidLoad
{
    
    // supposedly scaled background
    //bg.clipsToBounds = YES;
    //[bg setContentMode: UIViewContentModeScaleAspectFit];
    [self.view sendSubviewToBack:bg];
    /*
    //tapOrTouch = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:tapOrTouch forKey:@"tapOrTouch"];
    tapOrTouch = [[NSUserDefaults standardUserDefaults] integerForKey:@"tapOrTouch"];
    if (tapOrTouch == 0) {
        scTouchTilt.selectedSegmentIndex = 0;
    }
    else if (tapOrTouch == 1){
        scTouchTilt.selectedSegmentIndex = 1;
    }
    
    */
    
    
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    title.hidden = NO;
    start.hidden = NO;
    HighScore.hidden = NO;
    settings.hidden = YES;
    scTouchTilt.hidden = YES;
    backToHome.hidden = YES;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)decodeButton:(id)sender {
    
    if (scTouchTilt.selectedSegmentIndex == 0) {
        printf("tilt");
        tapOrTouch = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:tapOrTouch forKey:@"tapOrTouch"];
    } else if(scTouchTilt.selectedSegmentIndex == 1) {
        printf("touch");
        tapOrTouch = 1;
        [[NSUserDefaults standardUserDefaults] setInteger:tapOrTouch forKey:@"tapOrTouch"];
    }
}


- (IBAction)Scorez:(id)sender {
	
    NSString *nssHighscore = [NSString stringWithFormat:@"%li", (long)HighScoreNumber];

    
    alert=   [UIAlertController
            alertControllerWithTitle:@"High Score"
            message:nssHighscore
            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* bbutton = [UIAlertAction
                              actionWithTitle:@"I can beat it!"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //Handel your yes please button action here
                              }];
    [alert addAction:bbutton];
    [self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)Home:(id)sender{
    
    
    
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    //tapOrTouch = [[NSUserDefaults standardUserDefaults] integerForKey:@"tapOrTouch"];
    HighScore.hidden = NO;
    settings.hidden = NO;
    start.hidden = NO;
    title.hidden = NO;
    scTouchTilt.hidden = YES;
    backToHome.hidden = YES;
    
    tapOrTouch = [[NSUserDefaults standardUserDefaults] integerForKey:@"tapOrTouch"];
    if (tapOrTouch == 0) {
        scTouchTilt.selectedSegmentIndex = 0;
    }
    else if (tapOrTouch == 1){
        scTouchTilt.selectedSegmentIndex = 1;
    }
    
    
}

- (IBAction)Settings:(id)sender {
    
    HighScore.hidden = YES;
    settings.hidden = YES;
    start.hidden = YES;
    title.hidden = NO;
    backToHome.hidden = NO;
    scTouchTilt.hidden = NO;
    
    
    
    //NSString *sc = [scTouchTilt titleForSegmentAtIndex:scTouchTilt.selectedSegmentIndex];
    
    
    
    //NSString *nssHighscore = [NSString stringWithFormat:@"%li", (long)HighScoreNumber];
    
    /*
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Control Type"
                          message:sc
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    [alert show];
    */
}



@end
