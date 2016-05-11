

//
//  GameMain.m
//  Chippy Leap
//
//  Created by Christopher Livingston on 8/17/14.
//  Copyright (c) 2014 Chinchilla Studios. All rights reserved.
//

#import "GameMain.h"


@interface GameMain ()

@end

#define kTilt 0
#define kTouch 1

@implementation GameMain


- (void)playScoreSound{
    
   
}



- (IBAction)StartGame:(id)sender {
    
    
    [gameover invalidate];
    
    [self.view bringSubviewToFront:scoreboard];
    [self.view bringSubviewToFront:score];
    
    Chip.image = [UIImage imageNamed:@"branchez.svg-g5828-04-88.png"];

    Chip.center = CGPointMake(160, 84);
    
    ChipGlide = 0;
    
    
    branchLeft.hidden = NO;
    branchRight.hidden = NO;
    lb1.hidden = NO;
    lb2.hidden = NO;
    lb3.hidden = NO;
    lb4.hidden = NO;
    rb1.hidden = NO;
    rb2.hidden = NO;
    rb3.hidden = NO;
    rb4.hidden = NO;
    gameBack.hidden = YES;
    
    trunkLeft.hidden = NO;
    trunkRight.hidden = NO;
    trunkLeft2.hidden = NO;
    trunkRight2.hidden = NO;
    // 852 is just off the screen for ip5
    trunkLeft.center = CGPointMake(trunkLeft.center.x, 852);
    trunkRight.center = CGPointMake(trunkRight.center.x, 852);
    trunkLeft2.center = CGPointMake(trunkLeft.center.x, 1420);
    trunkRight2.center = CGPointMake(trunkRight.center.x, 1420);
    
    startTreeLeft.hidden = NO;
    startTreeRight.hidden = NO;
    startTreeLeft.center = CGPointMake(startTreeLeft.center.x, 477);
    startTreeRight.center = CGPointMake(startTreeRight.center.x, 477);
    
    
    treeLeft.center = CGPointMake(treeLeft.center.x, 630);
    treeRight.center = CGPointMake(treeRight.center.x, 750);
    treeLeft.hidden = NO;
    treeRight.hidden = NO;
    
    pauseplay.hidden = YES;
    scoreboard.hidden = NO;
    score.hidden = NO;
    
    gameOver.hidden = YES;
    menu.hidden = YES;
    reset.hidden = YES;
    
    
    // fresh score
    scoreNumber = 0;
    score.text = [NSString stringWithFormat:@"%i", scoreNumber];
    

    
    // timed loop for chip's movement
    ChipMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(ChipMoving) userInfo:nil repeats:YES];

    // call initial branch placement
    [self PlaceBranch];

    // timed loop for branch movement to simulate flying down a tree
   BranchMovement = [NSTimer scheduledTimerWithTimeInterval:0.012 target:self selector:@selector(BranchesMoving) userInfo:nil repeats:YES];
    
}


// method to increment score label
- (void)Score{
    
    scoreNumber = scoreNumber + 1;
    score.text = [NSString stringWithFormat:@"%i", scoreNumber];
    
}





/*
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if (controlType == kTilt) {
        ChipGlide = acceleration.x * 10;
    }
}

*/


// method called when Chip's frame intersects with a brach frame (i.e. GAMEOVER!)
- (void)GameOver{
    
    [self.view bringSubviewToFront:gameBack];
    gameBack.hidden = NO;
    gameOver.hidden = NO;
    menu.hidden = NO;
    reset.hidden = NO;
    
    
    // invalidate chips movement and the branch's movement
    [ChipMovement invalidate];
    [BranchMovement invalidate];
    
    
    gameover = [NSTimer scheduledTimerWithTimeInterval:0.009 target:self selector:@selector(ChipDies) userInfo:nil repeats:YES];
    
    
    // if we have a high score, send a message to update scoreboard
    if (scoreNumber > highscore) {
        [[NSUserDefaults standardUserDefaults] setInteger:scoreNumber forKey:@"HighScoreSaved"];
        
        NSString *nssHighscore = [NSString stringWithFormat:@"%li", (long)scoreNumber];
        alt=   [UIAlertController
                alertControllerWithTitle:@"New High Score!"
                message:nssHighscore
                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* bbutton = [UIAlertAction
                                  actionWithTitle:@"Back"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      //Handel your yes please button action here
                                      [self flash];
                                  }];
        [alt addAction:bbutton];
        [self presentViewController:alt animated:YES completion:nil];
        
    }
    /* Score vs best */
    else {
       
        NSString *nssHighscore = [NSString stringWithFormat:@"Score: %li\n Best: %li", (long)scoreNumber, (long)highscore];
        
        alt=   [UIAlertController
                                      alertControllerWithTitle:@"Game Over!"
                                    message:nssHighscore
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* bbutton = [UIAlertAction
                                  actionWithTitle:@"Back"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [self flash];
                                  }];
        [alt addAction:bbutton];
        [self presentViewController:alt animated:YES completion:nil];

    }
    
    
}

- (void)flash{
    [self.view bringSubviewToFront:gameOver];
    [self.view bringSubviewToFront:menu];
    [self.view bringSubviewToFront:reset];
    gameBack.hidden = NO;
    menu.hidden = YES;
    reset.hidden = YES;
    
    gameOver.hidden = NO;
    [NSThread sleepForTimeInterval:.02];
    
    menu.hidden = NO;
    reset.hidden = NO;
}


- (void)ChipDies{
    int loopCount;
    loopCount++;
    
    if (loopCount == 15) {
      [gameover invalidate];
       gameover = nil;
    }else{
      //  while (Chip.center.y < 650) {
    Chip.center = CGPointMake(Chip.center.x, Chip.center.y + 14); // Just this line performs the animation as intended
     
     //   }

    }
   
}




- (void)PlaceBranch{
    
    // the initial spacing horizontally
    // branchGap = 407;
    if (scoreNumber > 25 && scoreNumber <= 50) {
        
        branchGap = 409;
    }
    else if (scoreNumber > 50 && scoreNumber <= 75){
        
        branchGap = 408;
    }
    else if (scoreNumber > 75 && scoreNumber <= 100){
        
        branchGap = 407;
    }
    else{
        branchGap = 410; // foo
       
    }
    // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
    randomLeftBranchPos = arc4random() %198;
    randomLeftBranchPos = randomLeftBranchPos - 126;
    
    
    
    // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
    randomRightBranchPos = randomLeftBranchPos + branchGap;
    
    
    // y point affects initial spawn at bottom of screen
    
    branchLeft.center = CGPointMake(randomLeftBranchPos, 540);
    branchRight.center = CGPointMake(randomRightBranchPos, 540);
    
    
    
    // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
    randomLeftBranchPos = arc4random() %198;
    randomLeftBranchPos = randomLeftBranchPos - 126;
    
    // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
    randomRightBranchPos = randomLeftBranchPos + branchGap;
    
    lb1.center = CGPointMake(randomLeftBranchPos, 670);
    rb1.center = CGPointMake(randomRightBranchPos, 670);
    
    
    
    // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
    randomLeftBranchPos = arc4random() %198;
    randomLeftBranchPos = randomLeftBranchPos - 126;
    
    // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
    randomRightBranchPos = randomLeftBranchPos + branchGap;
    
    lb2.center = CGPointMake(randomLeftBranchPos, 800);
    rb2.center = CGPointMake(randomRightBranchPos, 800);
    
    
    
    // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
    randomLeftBranchPos = arc4random() %198;
    randomLeftBranchPos = randomLeftBranchPos - 126;
    
    // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
    randomRightBranchPos = randomLeftBranchPos + branchGap;
    
    lb3.center = CGPointMake(randomLeftBranchPos, 930);
    rb3.center = CGPointMake(randomRightBranchPos, 930);
    
    
    
    // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
    randomLeftBranchPos = arc4random() %198;
    randomLeftBranchPos = randomLeftBranchPos - 126;
    
    // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
    randomRightBranchPos = randomLeftBranchPos + branchGap;
    
    lb4.center = CGPointMake(randomLeftBranchPos, 1060);
    rb4.center = CGPointMake(randomRightBranchPos, 1060);
    
    
    /*
    // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
    randomLeftTree = arc4random() %400;
    
    // y point affects initial spawn at bottom of screen
    
    treeLeft.center = CGPointMake(treeLeft.center.x, 630-randomLeftTree);
    //treeRight.center = CGPointMake(randomRightBranchPos, 630);

    // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
    randomRightTree = arc4random() %300;
    // y point affects initial spawn at bottom of screen
    
    //treeLeft.center = CGPointMake(treeLeft.center.x, 630);
    treeRight.center = CGPointMake(treeRight.center.x, 630-randomRightTree);
    */
    
    
    
}




- (void)BranchesMoving{
    
    [self.view bringSubviewToFront:score];
    
    
    if (scoreNumber > 25 && scoreNumber <= 50) {
        brSpeed = 2.05;
        
    }
    else if (scoreNumber > 50 && scoreNumber <= 75){
        brSpeed = 2.1;
        
    }
    else if (scoreNumber > 75 && scoreNumber <= 100){
        brSpeed = 2.15;
        
    }
    else if (scoreNumber > 100){
        brSpeed = 2.2;
    }
    else if (scoreNumber >= 1000){
     
    }
    else{
       brSpeed = 2; // foo
        
    }
    
    
    
    
    
    
    
    branchLeft.center = CGPointMake(branchLeft.center.x, branchLeft.center.y - brSpeed);
    branchRight.center = CGPointMake(branchRight.center.x, branchRight.center.y - brSpeed);
    lb1.center = CGPointMake(lb1.center.x, lb1.center.y - brSpeed);
    rb1.center = CGPointMake(rb1.center.x, rb1.center.y - brSpeed);
    lb2.center = CGPointMake(lb2.center.x, lb2.center.y - brSpeed);
    rb2.center = CGPointMake(rb2.center.x, rb2.center.y - brSpeed);
    lb3.center = CGPointMake(lb3.center.x, lb3.center.y - brSpeed);
    rb3.center = CGPointMake(rb3.center.x, rb3.center.y - brSpeed);
    lb4.center = CGPointMake(lb4.center.x, lb4.center.y - brSpeed);
    rb4.center = CGPointMake(rb4.center.x, rb4.center.y - brSpeed);
    
    startTreeLeft.center = CGPointMake(startTreeLeft.center.x, startTreeLeft.center.y - brSpeed);
    startTreeRight.center = CGPointMake(startTreeRight.center.x, startTreeRight.center.y - brSpeed);
    
    trunkLeft.center = CGPointMake(trunkLeft.center.x, trunkLeft.center.y - brSpeed);
    trunkRight.center = CGPointMake(trunkRight.center.x, trunkRight.center.y - brSpeed);
    trunkLeft2.center = CGPointMake(trunkLeft2.center.x, trunkLeft2.center.y - brSpeed);
    trunkRight2.center = CGPointMake(trunkRight2.center.x, trunkRight2.center.y - brSpeed);
    
    
    
    
    
    treeLeft.center =  CGPointMake(treeLeft.center.x, treeLeft.center.y - brSpeed);
    treeRight.center =  CGPointMake(treeRight.center.x, treeRight.center.y - brSpeed);
    
    
    if (branchLeft.center.y < -16){
        
        // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
        randomLeftBranchPos = arc4random() %198;
        randomLeftBranchPos = randomLeftBranchPos - 126;
        
        // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
        randomRightBranchPos = randomLeftBranchPos + branchGap;
        
         NSLog(@"%i\n",randomLeftBranchPos);
        
        // y point affects initial spawn at bottom of screen
        
        branchLeft.center = CGPointMake(randomLeftBranchPos, 630);
        branchRight.center = CGPointMake(randomRightBranchPos, 630);
    
        
    }
    
    
    
    if (lb1.center.y < -16) {
        
        // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
        randomLeftBranchPos = arc4random() %198;
        randomLeftBranchPos = randomLeftBranchPos - 126;
        
        // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
        randomRightBranchPos = randomLeftBranchPos + branchGap;
        
        
        // y point affects initial spawn at bottom of screen
        
        lb1.center = CGPointMake(randomLeftBranchPos, 630);
        rb1.center = CGPointMake(randomRightBranchPos, 630);
        
        
    }
    
    if (lb2.center.y < -16){
        
        // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
        randomLeftBranchPos = arc4random() %198;
        randomLeftBranchPos = randomLeftBranchPos - 126;
        
        // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
        randomRightBranchPos = randomLeftBranchPos + branchGap;
        
        
        // y point affects initial spawn at bottom of screen
        
        lb2.center = CGPointMake(randomLeftBranchPos, 630);
        rb2.center = CGPointMake(randomRightBranchPos, 630);
        
        
    }
    
    if (lb3.center.y < -16){
        
        // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
        randomLeftBranchPos = arc4random() %198;
        randomLeftBranchPos = randomLeftBranchPos - 126;
        
        // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
        randomRightBranchPos = randomLeftBranchPos + branchGap;
        
        
        // y point affects initial spawn at bottom of screen
        
        lb3.center = CGPointMake(randomLeftBranchPos, 630);
        rb3.center = CGPointMake(randomRightBranchPos, 630);
        
        
    }
    
    if (lb4.center.y < -16){
        
        // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
        randomLeftBranchPos = arc4random() %198;
        randomLeftBranchPos = randomLeftBranchPos - 126;
        
        // int changes spacing between bracnhes...10 decrements? (420,415,410,405,400,495..etc)
        randomRightBranchPos = randomLeftBranchPos + branchGap;
        
        
        // y point affects initial spawn at bottom of screen
        lb4.center = CGPointMake(randomLeftBranchPos, 630);
        rb4.center = CGPointMake(randomRightBranchPos, 630);
        
        
    }
    
    

    
    if (treeLeft.center.y < -80) {
        
        // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
        randomLeftTree = arc4random() %350;
        
        
        // y point affects initial spawn at bottom of screen
        
        treeLeft.center = CGPointMake(treeLeft.center.x, 630+randomLeftTree);
        //treeRight.center = CGPointMake(randomRightBranchPos, 630);
        [self.view bringSubviewToFront:treeLeft];
    }
    
    if (treeRight.center.y < -80) {
        
        // spawn a random int between 0 and 197...then make left branch random int 126 less to fit on screen
        randomRightTree = arc4random() % 455;
        
        // y point affects initial spawn at bottom of screen
        
        //treeLeft.center = CGPointMake(treeLeft.center.x, 630);
        treeRight.center = CGPointMake(treeRight.center.x, 630+randomRightTree);
        [self.view bringSubviewToFront:treeRight];
        
    }
    
    
    
    if (
        
        (branchLeft.center.y > Chip.center.y-brSpeed && branchLeft.center.y < Chip.center.y+brSpeed) || (lb1.center.y > Chip.center.y-brSpeed && lb1.center.y < Chip.center.y+brSpeed) || (lb2.center.y > Chip.center.y-brSpeed && lb2.center.y < Chip.center.y+brSpeed) || (lb3.center.y > Chip.center.y-brSpeed && lb3.center.y < Chip.center.y+brSpeed) || (lb4.center.y > Chip.center.y-brSpeed && lb4.center.y < Chip.center.y+brSpeed)
        
        ){

        [self Score];
        
    }
    
    if (trunkLeft.center.y < -280){
        printf("REDRAW");
        trunkLeft.center = CGPointMake(trunkLeft.center.x, trunkLeft2.center.y + 568);
        trunkRight.center = CGPointMake(trunkRight.center.x, trunkRight2.center.y + 568);
    }
    if (trunkLeft2.center.y < -280){
        printf("REDRAW2");
        trunkLeft2.center = CGPointMake(trunkLeft.center.x, trunkLeft.center.y + 568);
        trunkRight2.center = CGPointMake(trunkRight.center.x, trunkRight.center.y + 568);
    }
   
    
    
    // collision detection
    
    if (
        (CGRectIntersectsRect(Chip.frame, branchLeft.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < branchLeft.center.y))
        || (CGRectIntersectsRect(Chip.frame, lb1.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < lb1.center.y))
        || (CGRectIntersectsRect(Chip.frame, lb2.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < lb2.center.y))
        || (CGRectIntersectsRect(Chip.frame, lb3.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < lb3.center.y))
        || (CGRectIntersectsRect(Chip.frame, lb4.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < lb4.center.y))
        ) {
                                                                                                               
        
        [self GameOver];
        
    }
    
    if (
        (CGRectIntersectsRect(Chip.frame, branchRight.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < branchRight.center.y))
        || (CGRectIntersectsRect(Chip.frame, rb1.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < rb1.center.y))
        || (CGRectIntersectsRect(Chip.frame, rb2.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < rb2.center.y))
        || (CGRectIntersectsRect(Chip.frame, rb3.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < rb3.center.y))
        || (CGRectIntersectsRect(Chip.frame, rb4.frame) && ((Chip.center.y + (Chip.frame.size.height/2)) < rb4.center.y))
        ) {
        
        
        [self GameOver];
        
    }
     

}














/* WORKS */ 
- (void)ChipMoving{
    
    
    StartGame.hidden = YES;
    tilt.hidden = YES;
    instructions.hidden = YES;
    
    
    Chip.center = CGPointMake(Chip.center.x + ChipGlide, Chip.center.y);
    
   
    // wall test
    if ((Chip.center.x <= 18) || (Chip.center.x >= 300)){
        printf("WALL");
        [self GameOver];
        /*
        if (Chip.center.x <= 18){
            Chip.center = CGPointMake(18, Chip.center.y);
        }
        else if (Chip.center.x >= 300){
            Chip.center = CGPointMake(300, Chip.center.y);
        }
        
        ChipGlide = 0;
         */
    }
    
    
    
    
    if (ChipGlide == 0 || (49 < Chip.center.x || Chip.center.x < 271)) {
        
        Chip.image = [UIImage imageNamed:@"branchez.svg-g5828-04-88.png"];
        
    }
    
    
    if (ChipGlide < 0) {
        
        Chip.image = [UIImage imageNamed:@"chippy_left.png"];
    }
    
    if (ChipGlide > 0) {
        
        Chip.image = [UIImage imageNamed:@"chippy_right.png"];
    }
    
    
}


/* works touches */
// when touches begin, Chip's horiz vel is neg if left touch and pos if right touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    if (controlType == kTouch) {
        //UITouch *touch = [[event allTouches] anyObject];
        //CGPoint location = [touch locationInView:touch.view];
        
        /*
        if (location.x < (self.view.bounds.size.width/2)) {
            ChipGlide = -10;
        }
        else {
            
            ChipGlide = 10;
        }
        */
        // orig 7 , trying 10 now
        int cg = 9.5;
        if (ChipGlide < 0){
            ChipGlide = cg;
        }
        else if (ChipGlide > 0){
            ChipGlide = -1*cg;
        }
        else{
            if ((Chip.center.x) > (self.view.bounds.size.width/2)) {
                ChipGlide = -1*cg;
            }
            else {
                ChipGlide = cg;
            }
            
        }
    }

}

/* Works */
// when touches end, Chip's horiz vel now = 0 and he is in default.png
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //if (controlType == kTouch) ChipGlide = 0;
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)rescale
{
    //bg.contentMode = UIViewContentModeScaleAspectFit;
    //change width of frame
    CGRect frame = bg.frame;
    frame.size.height = screenHeight+15;
    frame.size.width = screenWidth+15;
    bg.frame = frame;
    CGSize s = CGSizeMake(screenWidth+15,screenHeight+15);
    [self imageWithImage:bg.image convertToSize:s];
    
}


- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

// the initial view once segue from start game has finished
- (void)viewDidLoad
{
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    /*
    //[bg sizeToFit];
    //bg.contentMode = UIViewContentModeScaleAspectFit;
    //change width of frame
    CGRect frame = bg.frame;
    frame.size.height = screenHeight+10;
    frame.size.width = screenWidth+15;
    bg.frame = frame;
    */
    [self rescale];
    
    
    printf("here");
    NSLog(@"%.2f, %.2f", screenWidth, screenHeight);
    printf("after");
    // supposedly scaled background
    //bg.clipsToBounds = YES;
    //[bg setContentMode: UIViewContentModeScaleAspectFit];
    [self.view sendSubviewToBack:bg];
    /*
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        [self outputRotationData:gyroData.rotationRate];
                                    }];
    */
    


    
    scoreNumber = 0;
    StartGame.hidden = NO;
    tilt.hidden = NO;
    instructions.hidden = NO;
    pauseplay.hidden = YES;
    
    pauseplay.hidden = YES;
    scoreboard.hidden = NO;
    score.hidden = NO;
    gameOver.hidden = YES;
    menu.hidden = YES;
    reset.hidden = YES;
    
    branchLeft.hidden = YES;
    branchRight.hidden = YES;
    lb1.hidden = YES;
    lb2.hidden = YES;
    lb3.hidden = YES;
    lb4.hidden = YES;
    rb1.hidden = YES;
    rb2.hidden = YES;
    rb3.hidden = YES;
    rb4.hidden = YES;
    gameBack.hidden = YES;
    
    treeLeft.hidden = YES;
    treeRight.hidden = YES;

    
    trunkLeft.hidden = YES;
    trunkRight.hidden = YES;
    trunkLeft2.hidden = YES;
    trunkRight2.hidden = YES;
    
    //controlType = [[NSUserDefaults standardUserDefaults] integerForKey:@"tapOrTouch"];
    // Tap for now
    controlType = 1;
    
    
    
    printf("%li",(long)controlType);
    
    if ((controlType != 0) && (controlType != 1)){
        printf("failed control");
        controlType = 1;
    }
    
    highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    
    
    
    self.accX.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
    if(fabs(acceleration.x) > fabs(currentMaxAccelX))
    {
        currentMaxAccelX = acceleration.x;
    }
    self.accY.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    if(fabs(acceleration.y) > fabs(currentMaxAccelY))
    {
        currentMaxAccelY = acceleration.y;
    }
    self.accZ.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    if(fabs(acceleration.z) > fabs(currentMaxAccelZ))
    {
        currentMaxAccelZ = acceleration.z;
    }
    
    self.maxAccX.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelX];
    self.maxAccY.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelY];
    self.maxAccZ.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelZ];
    
    if (controlType == kTilt) {
        if (currentMaxRotX != 0) {
            ChipGlide = currentMaxAccelX * 10;
        }
    }
}



-(void)outputRotationData:(CMRotationRate)rotation
{
    
    self.rotX.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
    if(fabs(rotation.x) > fabs(currentMaxRotX))
    {
        currentMaxRotX = rotation.x;
    }
    self.rotY.text = [NSString stringWithFormat:@" %.2fr/s",rotation.y];
    if(fabs(rotation.y) > fabs(currentMaxRotY))
    {
        currentMaxRotY = rotation.y;
    }
    self.rotZ.text = [NSString stringWithFormat:@" %.2fr/s",rotation.z];
    if(fabs(rotation.z) > fabs(currentMaxRotZ))
    {
        currentMaxRotZ = rotation.z;
    }
    
    self.maxRotX.text = [NSString stringWithFormat:@" %.2f",currentMaxRotX];
    self.maxRotY.text = [NSString stringWithFormat:@" %.2f",currentMaxRotY];
    self.maxRotZ.text = [NSString stringWithFormat:@" %.2f",currentMaxRotZ];
    
    if (controlType == kTilt) {
        if (currentMaxRotX != 0) {
            ChipGlide = currentMaxAccelX * 10;
        }
    }
}

- (IBAction)resetMaxValues:(id)sender {
    
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
