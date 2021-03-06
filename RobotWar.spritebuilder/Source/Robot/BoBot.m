//
//  TheShadyKeevbot.m
//  RobotWar
//
//  Created by Shady Gabal on 7/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "BoBot.h"
#import "robotData.h"
#import "Location.h"

typedef NS_ENUM(NSInteger, RobotState){
    RobotStateDefault,
    RobotStateFiring,
    RobotStateSearching,
    RobotStateFollow,
    RobotStateTurnaround,
    RobotStateSniper, //Useful for detecting opponent location if opponent move around
    
};

/*
 
* cancelActiveAction
* currentTimestamp
* Gunheading direction
* hitwallHitAngle - This method can be implemented interestingly. You can bascially
 determine based on the angle at which the bullet hit where the opponent isn't, and using his movement tendencies understand where to fire. Though at the beginning of this algorithm, I will leave this function alone.
    **Robot on a hunch
 
 
 */
@implementation BoBot{
    RobotState _currentRobotState;
//    NSMutableArray *roboModeData; //Fires every time
//    CGPoint _lastKnownPosition;
//    CGFloat _timeSinceLastKnownPosition;
    NSMutableArray *opponentMovementTendencies;
    NSMutableArray *opponentExitTendencies;
    NSMutableArray *opponentFiringTendencies;
    NSMutableArray *damageTendencies;
    CGPoint opponentRadiusBegin;
    BOOL enemyFound;
    NSMutableArray *actionSequence;
    NSMutableArray * _scannedLocations;
    int speed;
    CGRect enemyRadius;
    sequences currentSequence;
}

-(void) run{
    actionSequence = [NSMutableArray array];
    
    _scannedLocations = [NSMutableArray array];
    
    while(true){
        
//        if ([roboModeData count] <= 2) {
//            _currentRobotState = RobotStateSearching;
//            
//        }
//        if (!enemyFound) {
//            NSArray
//        }
//        [self pushData];
//        [self analyzeData];
//
//        if (enemyFound) {
//            
//        }
//        else{
//            
//        }
                if(_currentRobotState == RobotStateDefault){
            CGSize dimensions = [self arenaDimensions];
            int x = dimensions.width/3;
            int qefqefy = dimensions.height/3;
          //  CCLOG(@"%f, %f", dimensions.width, dimensions.height);
            [self goTo: ccp(600, 100)];
            [self faceMiddle];
            _currentRobotState = RobotStateFiring;
            //    CGSize dimensions = [self arenaDimensions];
            [self moveAhead: 30];
        }
        
    }
}

-(void)pushData {
//    NSString *keyForState = [NSString stringWithFormat:@"%@",]
    
    
    
}

-(NSArray *)probabilityOfEvent:(NSArray *)dataPoints {
    
}

-(void)detectEnemyExit {
    
}

//De
-(CGRect)enemyRadiusLocation{
    
}

-(void)addData {
    
}

-(void)dodgeBullets {
    
}
//-(CGPoint)predictEnemyLocation:(CGPoint)lastKnowLocation{
//    NSMutableArray *possibleLocations = [[NSMutableArray alloc]init];
//    NSMutableSet *relevantData = [[NSSet alloc]init];
//    NSInteger percentageRight;
//    NSInteger percentageLeft;
//    for (robotData *data in _scannedLocations) {
//        if (data.sequence == currentSequence){
//            [relevantData addObject:data];
//            NSLog(@"%@",data);
//            xData = (xData > data.enemyLocation.x) ?abs(data.enemyLocation -
//    } if (enemyFound) {
//        return
//    }
//                                                    
//                                                        
//}



-(void)goTo:(CGPoint) point{
    CGPoint position = [self position];
       // float angle = [self angleBetweenHeadingDirectionAndWorldPosition: ccp(point.x+10,point.y+10)];
    int width = CGRectGetWidth([self robotBoundingBox]);
    if(!(position.x == point.x) && !(position.y == point.y)){
        //position = ccp(x,y);
        float angle = [self angleBetweenHeadingDirectionAndWorldPosition: ccp(point.x + width/2,point.y)];
        [self turnRobotRight: abs(angle)];
        
        double dx = ((point.x+(width/2))-position.x);
        double dy = ((point.y)-position.y);
        double dist = sqrt(dx*dx + dy*dy);
      //  float buffer = 0;
        if (dist > (position.y)){
            /*if (position.y  > [self arenaDimensions].height/2){
                buffer = .7;}
            else{ buffer = .8;}
            
            */
            dist = position.y;
        }
        if(dist > position.x)
            dist = position.x;
            
        CCLOG(@"%f, %f", point.x, point.y);

        [self moveAhead:dist];
        
        CCLOG(@"There.");
        
//cos angle * dist > width
//sin angle * dist > height
                                                                
    }
}

-(void) faceMiddle{
    int angle = abs([self angleBetweenHeadingDirectionAndWorldPosition: ccp([self arenaDimensions].width / 2,[self arenaDimensions].height/ 2)]);
    [self turnRobotLeft:angle];
    
}

-(void) facePoint: (CGPoint) point{
    int angle = abs([self angleBetweenHeadingDirectionAndWorldPosition: point]);
    [self turnRobotLeft:angle];
}


-(CGPoint)position {
    CGRect box = [self robotBoundingBox];
    int x = CGRectGetMidX(box);
    int y = CGRectGetMidY(box);
    CGPoint position = ccp(x,y);
    return position;
}
-(void) bulletHitEnemy:(Bullet *)bullet{

}
//-(void)scannedRobot:(Robot *)robot atPosition:(CGPoint)position {
//    CGPoint predictedLocation = [self predictEnemyLocation];
//    [
//    if (_currentRobotState != RobotStateFiring) {
//        [self cancelActiveAction];
//    }
//    
//    Location * lastLocation = [[Location alloc] initWithPosition: position andTime:self.currentTimestamp];
//
//    [_scannedLocations addObject: lastLocation];
//    
//    CCLOG(@"Scanned robot at %f, %f", lastLocation.position.x, lastLocation.position.y);
//    
//    if ((abs(lastLocation.position.x - [self position].x) + abs(lastLocation.position.y - [self position].y)) > 50){
//        CCLOG(@"Going there now.");
//        [self goTo: lastLocation.position];
//    }
//    
//    _currentRobotState = RobotStateFiring;
//}

- (void)hitWall:(RobotWallHitDirection)hitDirection hitAngle:(CGFloat)angle {
    if (_currentRobotState != RobotStateTurnaround) {
        [self cancelActiveAction];
        
        RobotState previousState = _currentRobotState;
        _currentRobotState = RobotStateTurnaround;
        
        // always turn to head straight away from the wall
        if (angle >= 0) {
            [self turnRobotLeft:abs(angle)];
        } else {
            [self turnRobotRight:abs(angle)];
            
        }
        
        [self moveAhead:20];
        
        _currentRobotState = previousState;
    }
}


@end
