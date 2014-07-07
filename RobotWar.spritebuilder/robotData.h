//
//  robotData.h
//  RobotWar
//
//  Created by Akiva Lipshitz on 7/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, sequences) {
    AD,
    AA,
    DA,
    DD,
};
@interface robotData : NSObject {

}
@property BOOL outCome;
@property float timeStamp;
@property BOOL enemyFound;
@property CGPoint enemyLocation;
@property BOOL attack;
@property sequences sequence;
@end
