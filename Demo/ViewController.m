//
//  ViewController.m
//  Demo
//
//  Created by pjw on 2020/7/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)NSMutableArray * tempArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tempArr addObjectsFromArray:@[@"1",@"1",@"1"]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableV];
    
    UIView * footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    footV.backgroundColor = [UIColor whiteColor];
    self.tableV.tableFooterView = footV;
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 10, 100, 80)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:btn];
    
    
}

-(void)btnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        btn.backgroundColor = [UIColor purpleColor];
        [btn setTitle:@"2" forState:UIControlStateNormal];
    }else{
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"1" forState:UIControlStateNormal];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.tempArr[section] isEqualToString:@"0"]) {
        return 0;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"pjw";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld~~~~~~~~%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    if (section == 0) {
        v.backgroundColor = [UIColor yellowColor];
    }else if (section == 1){
        v.backgroundColor = [UIColor purpleColor];
    }else{
        v.backgroundColor = [UIColor blueColor];
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [v addGestureRecognizer:tap];
    v.tag = section;
    
    return v;
}

-(void)sectionClick:(UITapGestureRecognizer *)tap{
    
    NSInteger index = tap.view.tag;
    if ([self.tempArr[index] isEqualToString:@"1"]) {
        self.tempArr[index] = @"0";
    }else{
        self.tempArr[index] = @"1";
    }
    
    [UIView performWithoutAnimation:^{
        [self.tableV reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
    }
    return _tableV;
}

- (NSMutableArray *)tempArr{
    if (!_tempArr) {
        _tempArr = [NSMutableArray array];
    }
    return _tempArr;;
}

@end
