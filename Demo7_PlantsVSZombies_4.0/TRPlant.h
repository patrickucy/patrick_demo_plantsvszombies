//
//  TRPlant.h
//  Demo3_PlantsVSZombies
//
//  Created by Patrick Yu on 8/10/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRViewController.h"

@interface TRPlant : UIImageView
@property (nonatomic) int fps;
@property (nonatomic) int HP;
@property (nonatomic) int runCount;
@property (strong,nonatomic) UIImage *plantImage;
@property (nonatomic,weak) TRViewController *delegate;

-(void)fire;
-(void)changeImageAction:(NSTimer *)timer; //如果你想子类重写这个方法,一定要放在.h 文件,要不然子类会点不出来
@end
