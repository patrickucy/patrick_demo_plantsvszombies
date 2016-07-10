//
//  TRSunFlower.m
//  Demo3_PlantsVSZombies
//
//  Created by Patrick Yu on 8/10/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import "TRSunFlower.h"

@implementation TRSunFlower

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.plantImage = [UIImage imageNamed:@"plant_0"];
		self.userInteractionEnabled = YES;  // 你下面的 button 会点不到,是因为 button 的 superview 的这个交互选项没有打开
    }
    return self;
}


-(void)fire
{
	[NSTimer scheduledTimerWithTimeInterval:5
									 target:self
								   selector:@selector(addSun)
								   userInfo:nil
									repeats:YES];
}

-(void)addSun
{
	UIButton *sunButton = [[UIButton alloc] init];
	[sunButton setImage:[UIImage imageNamed:@"sun"] forState:UIControlStateNormal];
	sunButton.frame = CGRectMake(0, 20, 40, 40);
	//给阳光添加点击事件
	//一般这种有 Action 叫你写 selector 并传参数的话,都是传本消息的对象,比如说下面这个方法就是传 sunButton, 像之前的 NSTimer 方法传参也是传 timer.以后编多了也就明白了
	[sunButton addTarget:self action:@selector(tapSun:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:sunButton];
	//三秒钟之后,阳光自动删除
	[NSTimer scheduledTimerWithTimeInterval:3
									 target:self
								   selector:@selector(removeSun:)
								   userInfo:sunButton
									repeats:NO];
	
}

//点击到阳光
-(void)tapSun:(UIButton *)sunButton
{
	int sunCount = [self.delegate.sunCountLabel.text intValue] + 50;
	self.delegate.sunCountLabel.text = [NSString stringWithFormat:@"%d",sunCount];
	[sunButton removeFromSuperview];
}

-(void)removeSun:(NSTimer *)timer
{
	UIButton *sunButton = timer.userInfo;
	[sunButton removeFromSuperview];
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
