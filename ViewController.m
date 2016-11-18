//
//  ViewController.m
//  QQ分组
//
//  Created by liuchao on 15/12/1.
//  Copyright (c) 2015年 ssyx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSArray *_sectionArray;
    NSArray *_rowArray;
    UITableView *_tableView;
    NSMutableDictionary *_showDic;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _sectionArray = [NSArray arrayWithObjects:@"好友",@"家人",@"朋友",@"同学",@"陌生人",@"黑名单", nil];
    _rowArray = [NSArray arrayWithObjects:@"张三",@"李四",@"王五",@"胖六",@"猪七", nil];
    _showDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [self createTableView];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 1024) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行:%@",indexPath.row,_rowArray[indexPath.row]];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
        return 44;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    header.backgroundColor = [UIColor blackColor];
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 20)];
    myLabel.text = [NSString stringWithFormat:@"分组--第 %ld 组 名称:%@",section,_sectionArray[section]];
    myLabel.textColor = [UIColor whiteColor];
    [header addSubview:myLabel];
    
    header.tag = section;
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [singleRecognizer setNumberOfTouchesRequired:1];
    [header addGestureRecognizer:singleRecognizer];
    
    return header;
}

-(void)SingleTap:(UITapGestureRecognizer *)recognizer
{
    NSInteger didSection = recognizer.view.tag;
    if (!_showDic) {
        _showDic = [[NSMutableDictionary alloc]init];
    }
    NSString *key = [NSString stringWithFormat:@"%ld",didSection];
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@"1" forKey:key];
    }else
    {
        [_showDic removeObjectForKey:key];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
