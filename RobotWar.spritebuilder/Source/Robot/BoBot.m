//
//  TheShadyKeevbot.m
//  RobotWar
//
//  Created by Shady Gabal on 7/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "BoBot.h"

typedef NS_ENUM(NSInteger, RobotState){
    RobotStateDefault,
    RobotStateFiring,
    RobotStateSearching,
    RobotStateTurnaround,
    RobotStateHit,
    RobotStateSniper
};


@implementation BoBot{
    RobotState _currentRobotState;
    
    CGPoint _lastKnownPosition;
    CGFloat _timeSinceLastKnownPosition;
    
}

-(void) run{
    while(true){
        if(_currentRobotState == RobotStateDefault){
            CGSize dimensions = [self arenaDimensions];
            int x = dimensions.width/3;
            int y = dimensions.height/3;
          //  CCLOG(@"%f, %f", dimensions.width, dimensions.height);
            [self goTo: ccp(600, 100)];
            [self faceMiddle];
            _currentRobotState = RobotStateFiring;
            
        }
    }
}


-(void) goTo:(CGPoint) point{
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
        float buffer = 0;
        if (dist > (position.y)){
            
            if (position.y > [self arenaDimensions].height/2){
                buffer = .7;}
            else{ buffer = .8;}
            
            CCLOG(@"%f", buffer);
            
            dist = position.y * buffer;
        }
        
        [self moveAhead:dist];
        

                                                                
    }
}

-(void) faceMiddle{
    int angle = abs([self angleBetweenHeadingDirectionAndWorldPosition: ccp([self arenaDimensions].width / 2,[self arenaDimensions].height/ 2)]);
    [self turnRobotLeft:angle];
    
}
/*
-(NSArray *) goTo:(CGPoint) point{
    CGPoint position = [self position];
    while (!(position.x == point.x) && !(position.y == point.y)) {
        position = [self position];
        float angle = [self angleBetweenHeadingDirectionAndWorldPosition: ccp(point.x,point.y)];
    }
    if(!(position.x == (point.x )) && !(position.y == (point.y) )){
        position = ccp(x,y);
        float angle = [self angleBetweenHeadingDirectionAndWorldPosition: ccp(point.x,point.y)];
        [self turnRobotRight: angle];
        
        double dx = (point.x-position.x);
        double dy = (point.y-position.y);
        double dist = sqrt(dx*dx + dy*dy);
        
        [self moveAhead:dist];
    }
       }
}*/
-(CGPoint)position {
    CGRect box = [self robotBoundingBox];
    int x = CGRectGetMidX(box);
    int y = CGRectGetMidY(box);
    CGPoint position = ccp(x,y);
    return position;
}
-(void) bulletHitEnemy:(Bullet *)bullet{
    
    
}
- (void)scannedRobot:(Robot *)robot atPosition:(CGPoint)position {
    if (_currentRobotState != RobotStateFiring) {
        [self cancelActiveAction];
    }
    
    _lastKnownPosition = position;
    _timeSinceLastKnownPosition = self.currentTimestamp;
    _currentRobotState = RobotStateFiring;
}

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
