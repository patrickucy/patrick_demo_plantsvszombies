//
//  TRViewController.m
//  Demo3_PlantsVSZombies
//
//  Created by Patrick Yu on 8/10/14.
//  Copyright (c) 2014 MobileApp. All rights reserved.
//

#import "TRViewController.h"
#import "TRPlant.h"
#import "TRSunFlower.h"
#import "TRPea.h"
#import "TRIcePea.h"
#import "TRNut.h"
#import "TRZombie.h"
#import "TRZombieA.h"
#import "TRZombieB.h"
#import "TRZombieC.h"

@interface TRViewController ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *plants;
//连的顺序取决于数组顺序
@property (strong,nonatomic) TRPlant *dragPlant;
@property (strong,nonatomic) NSMutableArray *zombies;

@end

@implementation TRViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.zombies = [NSMutableArray array];
	self.peas = [NSMutableArray array];
	self.allPlants = [NSMutableArray array];
	//如果peas为 weak, 就是 不+1 也就是[[[NSMutableArray alloc] init] autorelease];也就是出了自动回收池了之后会自动释放,
	//自动回收池 在程序当中有很多看不见的
	//这些看不见的自动回收池,什么时候执行?当用户跟界面进行交互的时候
	
	[self initUserInterface];
	
	//测试
	/*
	TRSunFlower *sunFlower = [[TRSunFlower alloc] initWithFrame:CGRectMake(50, 100, 40, 70)];
	[self.view addSubview:sunFlower];
	TRPea *pea = [[TRPea alloc] initWithFrame:CGRectMake(100, 100, 40, 70)];
	[self.view addSubview:pea];
	TRIcePea *icePea = [[TRIcePea alloc] initWithFrame:CGRectMake(150, 100, 40, 70)];
	[self.view addSubview:icePea];
	TRNut *nut = [[TRNut alloc] initWithFrame:CGRectMake(200, 100, 40, 70)];
	[self.view addSubview:nut];
	 */
	
	
	
	//添加僵尸
	[NSTimer scheduledTimerWithTimeInterval:2
									 target:self
								   selector:@selector(addZombie)
								   userInfo:nil repeats:YES];
	 
	//[self addZombie];
	
	//碰撞检测(不停的检测)
	[NSTimer scheduledTimerWithTimeInterval:.1
									 target:self
								   selector:@selector(collisionAction)
								   userInfo:nil
									repeats:YES];
	
}


-(void)collisionAction
{
	//子弹和僵尸之间的碰撞
	for (TRPea *pea in self.peas) {
		for (UIImageView *bullet in pea.bullets) {
			for (TRZombie *zombie in self.zombies) {
				//判断子弹和僵尸的矩形范围是否有交叉
				if ( CGRectIntersectsRect(zombie.frame, bullet.frame)) {
					if ([pea isMemberOfClass:[TRIcePea class]]) {
						zombie.speed = zombie.oldSpeed *.3;
						zombie.alpha = .7;
						[NSTimer scheduledTimerWithTimeInterval:1
														 target:self
													   selector:@selector(resetStatus:)
													   userInfo:zombie
														repeats:NO];
					}
					zombie.HP --;
					[bullet removeFromSuperview];
					[pea.bullets removeObject:bullet];
					
					if (zombie.HP == 0) {
						[zombie removeFromSuperview];
						[self.zombies removeObject:zombie];
					}
					
					return;//结束本次遍历,就没有必要继续遍历
					
				}
			}
		}
	}
	
	//植物和僵尸之间的碰撞
	for (TRPlant *plant in self.allPlants) {//plant 只能
		for (TRZombie *zombie in self.zombies) {
			if ( CGRectContainsPoint(plant.superview.frame, zombie.center)) {
				//因为植物和僵尸没有在同一个坐标系,所以要用植物的坑和僵尸碰撞比较
				if (!zombie.isEating) {
					[zombie attack:plant];
				}
				
			}
		}
	}
	
	
	
}

-(void)resetStatus:(NSTimer *)timer
{
	TRZombie *zomebie = timer.userInfo;
	zomebie.alpha = 1;
	zomebie.speed = zomebie.oldSpeed;
}

#pragma mark - zombie
-(void)addZombie
{
	int ramdom = arc4random() % 5;
	
	
	TRZombie *zombie = nil;
	
	switch (arc4random() % 3) {
		case 0:
		{
			zombie = [[TRZombieA alloc] initWithFrame:CGRectMake(568, 40 + ramdom * 50, 40, 70)];

		}
			break;
		case 1:
		{
			zombie = [[TRZombieB alloc] initWithFrame:CGRectMake(568, 40 + ramdom * 50, 40, 70)];

		}
			break;
		case 2:
		{
			zombie = [[TRZombieC alloc] initWithFrame:CGRectMake(568, 40 + ramdom * 50, 40, 70)];

		}
			break;
	}
	
	[self.view addSubview:zombie];
	[self.zombies addObject:zombie];
}


#pragma mark - touch event

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.view];
	
	int sunCount = [self.sunCountLabel.text intValue];
	for (UIImageView *plantImageView in self.plants) {
		if (CGRectContainsPoint(plantImageView.frame, currentPoint)) {
			
			switch (plantImageView.tag) {
				case 0: //sunFlower
				{
					if (sunCount < 50) {
						return;//直接结束了
					}
					self.dragPlant = [[TRSunFlower alloc] initWithFrame:CGRectMake(currentPoint.x - 40/2, currentPoint.y - 50/2, 40, 50)];
					
				}
					break;
				case 1: //pea
				{
					if (sunCount < 200) {
						return;//直接结束了
					}
					self.dragPlant = [[TRPea alloc] initWithFrame:CGRectMake(currentPoint.x - 40/2, currentPoint.y - 50/2, 40, 50)];
					 
				}
					break;
				case 2://icePea
				{
					if (sunCount < 175) {
						return;//直接结束了
					}
					self.dragPlant = [[TRIcePea alloc] initWithFrame:CGRectMake(currentPoint.x - 40/2, currentPoint.y - 50/2, 40, 50)];
					
				}
					break;
				case 3://nut
				{
					if (sunCount < 125) {
						return;//直接结束了
					}
					self.dragPlant = [[TRNut alloc] initWithFrame:CGRectMake(currentPoint.x - 40/2, currentPoint.y - 50/2, 40, 50)];
					
				}
					break;
				default:
					break;
			}
			
			self.dragPlant.tag = plantImageView.tag;
			self.dragPlant.delegate = self;
			[self.view addSubview:self.dragPlant];
		}
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.view];
	
	self.dragPlant.center = currentPoint;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.view];
	//遍历每一个 box 判断在哪个 box 上面松手的
	for (UIView *box in self.boxes) {
		if (CGRectContainsPoint(box.frame, currentPoint)) {
			//判断如果 box 里面没有植物才添加
			if ([box.subviews count] == 0) {
				//扔坑里面的时候
				[self.dragPlant fire];//子类有具体实现就调用,没有就调用父类,父类什么都没有,所以也会什么都不做,不影响
				if ([self.dragPlant isMemberOfClass:[TRPea class]] || [self.dragPlant isMemberOfClass:[TRIcePea class]]) {
					[self.peas addObject:self.dragPlant];
				}
				
				int costSunCount = 0;
				switch (self.dragPlant.tag) {
					case 0:
					{
						if ([self.dragPlant isMemberOfClass:[TRSunFlower class]]) {
							costSunCount = 50;
						}//因为view 的 tag 的默认值都是0,所以你会发现你点击一下都会扣阳光,所以这里要判断一下
					}
						break;
					case 1:
						costSunCount = 200;
						break;
					case 2:
						costSunCount = 175;
						break;
					case 3:
						costSunCount = 125;
						break;
						
					
				}
				
				self.sunCountLabel.text = [NSString stringWithFormat:@"%d",[self.sunCountLabel.text intValue] - costSunCount];
				self.dragPlant.center = CGPointMake(box.frame.size.width/2, box.frame.size.height/2);
				[box addSubview:self.dragPlant];
				//把所有的植物都记录
				if (self.dragPlant) {
					[self.allPlants addObject:self.dragPlant];
				}
				
				
				self.dragPlant = nil; //扔完之后,就不要指向对象了,因为 touchesMoved 的方法里面还是会改变对象的中心点
			}
		}
	}
	//判断如果植物没有扔到任何一个 box 里面的话,删掉此植物,一定要等它全部遍历完了再删掉
	//考虑发生改变的因素, 如果扔进去了它属于 box 的孩子,如果没扔属于 self.view 的孩子
	if ([self.dragPlant.superview isEqual:self.view]) { //isKindOf 是类型,不是相等判断,这个是判断对象是否相等
		[self.dragPlant removeFromSuperview];
	}
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//通知中心,打电话等等的突然出现都会调用这个方法
	[self.dragPlant removeFromSuperview];
}

#pragma mark - init

-(void)initUserInterface
{
	UIImage *plantImages = [UIImage imageNamed:@"seedpackets"];
	for (int i = 0; i < 4; i++) {
		UIImageView *plantView = self.plants[i];
		float x = 0;
		switch (i) {
			case 1:
				x = 2*plantImages.size.width/18 *2;
				break;
				
			case 2:
				x = 3*plantImages.size.width/18 *2;

				break;
				
			case 3:
				x = 5*plantImages.size.width/18 *2;

				break;
				
			default:
				break;
		}
		CGImageRef subImage = CGImageCreateWithImageInRect(plantImages.CGImage, CGRectMake(x, 0, plantImages.size.width / 18 * 2, plantImages.size.height *2));
		plantView.image = [UIImage imageWithCGImage:subImage];
	}
}



@end
