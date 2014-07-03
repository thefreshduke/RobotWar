//
//  Location.h
//  RobotWar
//
//  Created by Shady Gabal on 7/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic) CGPoint position;
@property (nonatomic) CGFloat timeSincePosition;

-(id) initWithPosition: (CGPoint) point andTime: (CGFloat) time;

@end
