//
//  ViewController.m
//  QCReactiveThink
//
//  Created by EricZhang on 2018/6/2.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "ViewController.h"
#import "BlocksKit/BlocksKit.h"
#import "BlocksKit/BlocksKit+UIKit.h"
#import "UIView+SDAutoLayout.h"
#import "QCKVO.h"

@interface ViewController ()

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UIButton *changeNumBtn;

@property(nonatomic,strong) QCKVO *qcKvo;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    //初始化数据
    self.qcKvo = [QCKVO new];
    
    //注册监听
    [self.qcKvo addObserver:self forKeyPath:@"theNum" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    //初始化界面
    [self initUI];
    

    
}


//初始化界面
-(void)initUI{
    
    
    //label
    self.label = [UILabel new];
    [self.view addSubview:self.label];
    self.label.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 100)
    .widthIs(self.view.frame.size.width)
    .heightIs(40);
    self.label.backgroundColor = [UIColor greenColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"点击按钮更新数据";

    
    
    //btn
    self.changeNumBtn = [UIButton new];
    [self.view addSubview:self.changeNumBtn];
    self.changeNumBtn.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.label, 20)
    .widthIs(self.view.frame.size.width)
    .heightIs(40);
    self.changeNumBtn.backgroundColor = [UIColor greenColor];
    [self.changeNumBtn setTitle:@"num + 1" forState:0];
    [self.changeNumBtn setTitleColor:[UIColor blackColor] forState:0];
    self.changeNumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.changeNumBtn bk_addEventHandler:^(id sender) {
        
        self.qcKvo.theNum += 1;

    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


//MARK : KVO Delegete 只要数据变化,就做出响应更新UI
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"theNum"] && object == self.qcKvo) {
        
        self.label.text = [NSString stringWithFormat:@"当前的num值为:%@",[change valueForKey:@"new"]];
        //展示一下新旧数据
        NSLog(@"oldnum:%@ newnum:%@",[change valueForKey:@"old"],
              [change valueForKey:@"new"]);
                              
    }

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
