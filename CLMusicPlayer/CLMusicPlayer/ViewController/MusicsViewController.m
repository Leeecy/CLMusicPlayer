//
//  MusicsViewController.m
//  CLMusicPlayer
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 sunsmart. All rights reserved.
//

#import "MusicsViewController.h"
#import "MusicModel.h"
#import "AudioPlayerController.h"
@interface MusicsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *songTableView;
@property (nonatomic, strong) NSMutableArray *songArray;

@end
static NSString *songIdentifier = @"songCellIdentifier";
@implementation MusicsViewController
- (NSMutableArray *)songArray
{
    if (!_songArray) {
        _songArray = [NSMutableArray array];
    }
    return _songArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"音乐列表";
    [self creatTableView];
    [self dataJson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 初始化UI
- (void)creatTableView
{
    self.songTableView = [[UITableView alloc]initWithFrame:CGRectMake(Frame_x_0, Frame_y_0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    _songTableView.backgroundColor = [UIColor clearColor];
    _songTableView.delegate = self;
    _songTableView.dataSource = self;
    _songTableView.separatorColor = [UIColor redColor];
    _songTableView.tableFooterView = [UIView new];
    //    _songTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.songTableView];
}

#pragma mark -
#pragma mark 加载数据
-(void)dataJson{
    NSString *str = [[NSBundle mainBundle]pathForResource:@"musicPaper" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:str];
    NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@,  ---%ld",dataArray, dataArray.count);
    for (NSDictionary *dic in  dataArray) {
        MusicModel *model = [[MusicModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.songArray addObject:model];
    }
    [self.songTableView reloadData];
}
#pragma mark -
#pragma mark 事件

#pragma mark -
#pragma mark 数据请求

#pragma mark -
#pragma mark 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.songArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:songIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:songIdentifier];
    }
    MusicModel *model = [[MusicModel alloc] init];
    model = [self.songArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@_%@_%@", model.music_id, model.name, model.singer];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AudioPlayerController *audio = [AudioPlayerController audioPlayerController];
    [audio initWithArray:_songArray index:indexPath.row];
    [self presentViewController:audio animated:YES completion:nil];
    
}
#pragma mark 业务逻辑

#pragma mark -
#pragma mark 通知注册和销毁

@end
