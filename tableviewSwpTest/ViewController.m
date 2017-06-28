//
//  ViewController.m
//  tableviewSwpTest
//
//  Created by webapps on 17/2/15.
//  Copyright © 2017年 webapps. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "TaViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *selectorPatnArray;//存放选中数据
@property (nonatomic, strong) UITableView  * wTableView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
 [self createWtableViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ) WithStyle:UITableViewStylePlain];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  创建TableView
 */
#pragma mark -- 创建TableView
- (void)createWtableViewWithFrame:(CGRect)frame WithStyle:(UITableViewStyle)style{

    _selectorPatnArray = [NSMutableArray new];
    for (int i = 0; i < 5; i ++) {
        
        [_selectorPatnArray addObject:[NSString stringWithFormat:@"隔壁老王%d号",i]];
    }
    
    
    self.wTableView = [[UITableView alloc] initWithFrame:frame style:style];
    
   
    self.wTableView.delegate = self;
    self.wTableView.dataSource = self;
    
    self.wTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.wTableView];

    
}



//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectorPatnArray.count;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];;
        
    }
    cell.selectedBackgroundView = [[UIView alloc] init];
    
    cell.nameL.text = self.selectorPatnArray[indexPath.row];
    cell.detailL.text = @"good";
    
    
    return cell;
}

- (IBAction)edoitBtnClik:(UIBarButtonItem *)sender {
    
    TaViewController *vc = [TaViewController new];
    vc.lastDataSouce = self.selectorPatnArray;
    vc.backArr = ^(NSMutableArray *aa){
        [self.selectorPatnArray removeAllObjects];
        [self.selectorPatnArray addObjectsFromArray:aa];
        [self.wTableView reloadData];
        NSLog(@"重新刷新啦");
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}


@end
