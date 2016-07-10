//
//  TRViewController.h
//  Demo3_PlantsVSZombies
//
//  Created by Patrick Yu on 8/10/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *boxes;
@property (weak, nonatomic) IBOutlet UILabel *sunCountLabel;
//豌豆射手和寒冰射手都装有这个数组中
@property (strong,nonatomic) NSMutableArray *peas;
//weak strong的区别,
@property (strong,nonatomic) NSMutableArray *allPlants;
@end
