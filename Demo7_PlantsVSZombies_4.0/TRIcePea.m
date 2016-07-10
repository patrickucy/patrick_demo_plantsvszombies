//
//  TRIcePea.m
//  Demo3_PlantsVSZombies
//
//  Created by Patrick Yu on 8/10/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import "TRIcePea.h"

@implementation TRIcePea

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.plantImage = [UIImage imageNamed:@"plant_2"];
		self.bullets = [NSMutableArray array];

    }
    return self;
}





-(void)fire
{
	[NSTimer scheduledTimerWithTimeInterval:3
									 target:self
								   selector:@selector(addBullet)
								   userInfo:nil
									repeats:YES];
}

-(void)addBullet
{
	
	UIImageView *bullet = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	bullet.center = CGPointMake(self.superview.center.x + 20, self.superview.center.y -10);
	
	bullet.image = [UIImage imageNamed:@"bullet_1"];
	[self.delegate.view addSubview:bullet];//这个方法也是对的,但是前提是在初始化 TRPea 的时候 TRViewController 把自己赋值给了这个 delegate 属性!!!个人觉得这个方法更好,因为绝对就加在了 bigView 里面,不会像下面这个,万一后续升级改动多加了几层,这种调用方式就很不合理了
	//[self.superview.superview addSubview:bullet]; //self(TRPea).superview(box).superview(bigView) 这样就得到了 viewController.view
	
	//理论上你要子弹移动,接下来的代码可以使用 NSTimer 来使子弹移动,但是 NSTimer 开太多是会影响效率的.这时候你发现父类本身就有一个 changeImageAction:方法是用 timer 在不断调用的,你可以直接把子弹加到这个方法里面
	
	
	//添加到数组中,是为了让每一个子弹都能移动
	[self.bullets addObject:bullet];
	
}

-(void)changeImageAction:(NSTimer *)timer
{
	//这样子是完全就重写了,但是你并不想牺牲父类的实现,所以你要调用一次父类的实现,然后再添加子类的扩展功能
	[super changeImageAction:timer];
	//在重写父类的方法,让父类里面的方法先执行
	
	//移动子弹的代码
	for (UIImageView *bullet in self.bullets) {
		bullet.center = CGPointMake(bullet.center.x + 1, bullet.center.y);
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
