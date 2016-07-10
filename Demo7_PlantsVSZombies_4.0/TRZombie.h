//
//  TRZombie.h
//  Demo2_Zombie
//
//  Created by Patrick Yu on 8/9/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRPlant.h"

@interface TRZombie : UIImageView
@property (nonatomic) int runCount;
@property (nonatomic) int HP;
@property (nonatomic) float speed;
@property (nonatomic) float oldSpeed;
@property (nonatomic,strong) UIImage *zombieImage;
@property (nonatomic) BOOL isEating;

-(void)attack:(TRPlant *)plant;
@end
