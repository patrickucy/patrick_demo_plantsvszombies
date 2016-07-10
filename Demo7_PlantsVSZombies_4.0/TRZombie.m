//
//  TRZombie.m
//  Demo2_Zombie
//
//  Created by Patrick Yu on 8/9/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import "TRZombie.h"
#import "TRPea.h"
#import "TRIcePea.h"

@implementation TRZombie

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		//这个类就不是真正的僵尸了
		[NSTimer scheduledTimerWithTimeInterval:.1
										 target:self
									   selector:@selector(changeImageAction:)
									   userInfo:nil
										repeats:YES];
    }
    return self;
}

-(void)changeImageAction:(NSTimer *)timer
{
	CGImageRef subImage = CGImageCreateWithImageInRect(self.zombieImage.CGImage, CGRectMake(self.runCount++ % 8 * self.zombieImage.size.width/8 * 2, 0, self.zombieImage.size.width/8 *2, self.zombieImage.size.height*2));
	self.image = [UIImage imageWithCGImage:subImage];
	CGImageRelease(subImage);
	
	//移动僵尸
	self.center = CGPointMake(self.center.x - self.speed, self.center.y);
}

-(void)attack:(TRPlant *)plant
{
	self.isEating = YES;
	self.speed = 0;
	[NSTimer scheduledTimerWithTimeInterval:1
									 target:self
								   selector:@selector(attackAction:)
								   userInfo:plant repeats:YES];
}

-(void)attackAction:(NSTimer *)timer
{
	TRPlant *plant = timer.userInfo;
	plant.HP --;
	if (plant.HP <= 0) {
		[plant removeFromSuperview];
		[plant.delegate.allPlants removeObject:plant];
		if ([plant isMemberOfClass:[TRPea class]] || [plant isMemberOfClass:[TRIcePea class]]) {
			[plant.delegate.peas removeObject:plant];
			
		}
		self.isEating = NO;
		self.speed = self.oldSpeed;
		[timer invalidate];//把正在吃这个事停掉
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
