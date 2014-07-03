//
//  Location.m
//  RobotWar
//
//  Created by Shady Gabal on 7/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Location.h"

@implementation Location

-(id) initWithPosition: (CGPoint) point andTime: (CGFloat) time{
    self = [super init];
    if(self){
        _position = point;
        _timeSincePosition = time;
    }
    return self;
}

@end
