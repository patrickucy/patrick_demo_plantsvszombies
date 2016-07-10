//
//  TRPlant.m
//  Demo3_PlantsVSZombies
//
//  Created by Patrick Yu on 8/10/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import "TRPlant.h"

@implementation TRPlant

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		//这个类跟僵尸是一模一样的除了不会移动
		
		[NSTimer scheduledTimerWithTimeInterval:1.0/30
										 target:self
									   selector:@selector(changeImageAction:)
									   userInfo:nil
										repeats:YES];
		self.HP = 3;
    }
    return self;
}

-(void)changeImageAction:(NSTimer *)timer
{
	//通过一个 int 的递增,让 int 对3取余这样能保证每3次才能执行一次换图片的代码
	self.fps ++;
	if (self.fps%3 !=0) {
		return;
	}//这一小串代码就是把这个方法的调用频率放慢了3倍
	
	CGImageRef subImage = CGImageCreateWithImageInRect(self.plantImage.CGImage, CGRectMake(self.runCount++ % 8 * self.plantImage.size.width/8 * 2, 0, self.plantImage.size.width/8 *2, self.plantImage.size.height*2));
	self.image = [UIImage imageWithCGImage:subImage];
	CGImageRelease(subImage);
	
	
}


-(void)fire
{
	//这列虽然这么写了,是为了保持兼容性,具体的实现方法在子类里面
}

#pragma mark - Draw Rect

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
