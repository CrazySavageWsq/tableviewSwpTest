//
//  ViewController.m
//  tableviewSwpTest
//
//  Created by webapps on 17/2/14.
//  Copyright © 2017年 webapps. All rights reserved.
//

#import "TaViewController.h"
#import "TableViewCell.h"

@interface TaViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  * wTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray *selectorPatnArray;//存放选中数据

@property (nonatomic, assign) int num;

@end

@implementation TaViewController

- (NSMutableArray *)selectorPatnArray{
    if (!_selectorPatnArray) {
        _selectorPatnArray = [NSMutableArray array];
    }
    return _selectorPatnArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _num = 1;
    self.view.backgroundColor  = [UIColor whiteColor];
    self.title =@"各种功能的测试";
    [self createEdoitBtn];
    [self creatRefchtBtn];
    [self creatAllsectBtn];
    [self createFinishtBtn];
  
    
    
    [self createWtableViewWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100) WithStyle:UITableViewStylePlain];
    
    
    
    
   
}


/**
 创建wangcheng按钮
 */
- (void)createFinishtBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width- 60, 64, 80, 30)];
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(finishBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}
- (void)finishBtnClik:(UIButton *)btn{
    if (self.backArr) {
        self.backArr(self.selectorPatnArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 创建编辑按钮
 */
- (void)createEdoitBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 80, 30)];
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(edoitbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

}


/**
 编辑事件

 @param btn 编辑按钮
 */
- (void)edoitbtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (btn.selected ) {
        //移除之前选中的内容
        if (self.selectorPatnArray.count > 0) {
            [self.selectorPatnArray removeAllObjects];
        }
        //进入编辑状态
        if (self.wTableView.editing) {
            
        }else{
            [self.wTableView setEditing:YES animated:YES];
        }
        
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        //进入编辑状态
        [self.wTableView setEditing:YES animated:YES];
        //允许编辑状态点击cell
        [self.wTableView setAllowsSelectionDuringEditing:YES];
    }else{
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.wTableView setEditing:NO animated:YES];
    }
}




/**
 创建刷新按钮
 */
- (void)creatRefchtBtn{
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -85 , 64, 80, 30)];
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(Refch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

/**
 刷新

 @param btn 刷新按钮
 */
- (void)Refch:(UIButton *)btn{
    _num ++;
    if (_num > 10) {
        _num = 1;
    }
    
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
        for (int i = 21 * (_num -1); i < 21 * _num; i ++) {
            
            [self.dataSource addObject:[NSString stringWithFormat:@"隔壁老王%d号",i]];
        }
        
        [self.wTableView reloadData];
    }
    
}




/**
 创建全选按钮
 */
- (void)creatAllsectBtn{
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-165 , 64, 80, 30)];
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"全选" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(seleclAll:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

/**
 全选
 
 @param btn 全选按钮
 */
- (void)seleclAll:(UIButton *)btn{
  
    btn.selected = !btn.selected;
    
   
    
    if (btn.selected ) {
        //移除之前选中的内容
        if (self.selectorPatnArray.count > 0) {
            [self.selectorPatnArray removeAllObjects];
        }
        self.selectorPatnArray = self.dataSource.mutableCopy;
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        //进入编辑状态
        if (self.wTableView.editing) {
            
        }else{
             [self.wTableView setEditing:YES animated:YES];
        }
       
        [self.wTableView setAllowsSelectionDuringEditing:NO];

        for (int i = 0; i < self.dataSource.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.wTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            /*如果用系统的 tableViewcell 就调用以下三个方法*/
            //    [self changRowBackGroud:indexPath];
            //    [self changSeleImageColor:indexPath];
            //    [self changSeleImage:indexPath];
        }
    }else{
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        [self.wTableView setEditing:NO animated:YES];
//        for (int i = 0; i < self.dataArray.count; i++) {
//            
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//        }

    }


    
}





/**
 *  创建TableView
 */
#pragma mark -- 创建TableView
- (void)createWtableViewWithFrame:(CGRect)frame WithStyle:(UITableViewStyle)style{
    self.dataSource = [NSMutableArray new];
    
    for (int i = 0; i < 21; i ++) {
        
         [self.dataSource addObject:[NSString stringWithFormat:@"隔壁老王%d号",i]];
    }
   
    
    
    self.wTableView = [[UITableView alloc] initWithFrame:frame style:style];
    //进入编辑状态 为了调试从上个页面过来
    [self.wTableView setEditing:YES animated:YES];
    [self.selectorPatnArray addObjectsFromArray:self.lastDataSouce];
    self.wTableView.allowsSelection =NO;//不是编辑状态下不可选中cell
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
    return self.dataSource.count;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//组头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//组尾高
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];;
        
        /****** 以下这段代码是让编辑状态下选中cell没有背景色 *******/
//        cell.contentView.backgroundColor = [UIColor clearColor];
//        UIView *backGroundView = [[UIView alloc]init];
//        backGroundView.backgroundColor = [UIColor clearColor];
//        cell.selectedBackgroundView = backGroundView;
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    这样设置,蓝色的选中图标也不会出现.
    //    这种仅限于不编辑的时候,让TableViewCell没有灰色高亮.
     cell.selectedBackgroundView = [[UIView alloc] init];
   
    cell.nameL.text = self.dataSource[indexPath.row];
    
  
     for (int i = 0; i < self.selectorPatnArray.count; i++) {
         if ([self.dataSource[indexPath.row] isEqualToString:self.selectorPatnArray[i]]) {
              [self.wTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
             NSLog(@"相同");
         }else{
             continue;
         }
        

     }
    cell.detailL.text = @"good";
    
   
    return cell;
}

//行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   /*如果用系统的 tableViewcell 就调用以下三个方法*/
//    [self changRowBackGroud:indexPath];
//    [self changSeleImageColor:indexPath];
//    [self changSeleImage:indexPath];
    
    //选中数据
    [self.selectorPatnArray addObject:self.dataSource[indexPath.row]];
    
     NSLog(@"加入--self.selectorPatnArray:%@",self.selectorPatnArray);
}

//点击已选中的行调这个方法
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
    if (self.selectorPatnArray.count > 0) {
        
        [self.selectorPatnArray removeObject:self.dataSource[indexPath.row]];
    }
    NSLog(@"删除---self.selectorPatnArray:%@",self.selectorPatnArray);

}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// 修改编辑状态下选中时的圆圈颜色
- (void)changSeleImageColor:(NSIndexPath *)indexPath{
    
    NSArray *subviews = [[self.wTableView cellForRowAtIndexPath:indexPath] subviews];
    
    for (UIControl *control in subviews) {
        if (![control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            continue;
        }
        
        for (UIView *subView in control.subviews) {
            if (![subView isKindOfClass: [UIImageView class]]) {
                continue;
            }
            
            UIImageView *imageView = (UIImageView *)subView;
                // KVC修改
                [imageView setValue:[UIColor orangeColor] forKey:@"tintColor"];   // 选中时的颜色
            
        }
    }

}



// 修改编辑状态下选中时的图片
- (void)changSeleImage:(NSIndexPath *)indexPath{
    
    NSArray *subviews = [[self.wTableView cellForRowAtIndexPath:indexPath] subviews];
    for (UIControl *control in subviews) {
        if (![control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            continue;
        }
        
        for (UIView *subView in control.subviews) {
            if (![subView isKindOfClass: [UIImageView class]]) {
                continue;
            }
            
            UIImageView *imageView = (UIImageView *)subView;
         
                imageView.image = [UIImage imageNamed:@"1.jpg"]; // 选中时的图片
         
            
        }
    }

    
}

 /*这里是为了在编辑状态下选中row而背景色不变*/
- (void)changRowBackGroud:(NSIndexPath *)indexPath{
    
    [[self.wTableView cellForRowAtIndexPath:indexPath].textLabel setBackgroundColor:[UIColor clearColor]];
    [[self.wTableView cellForRowAtIndexPath:indexPath].detailTextLabel setBackgroundColor:[UIColor clearColor]];
    [[self.wTableView cellForRowAtIndexPath:indexPath].contentView setBackgroundColor:[UIColor clearColor]];
}

//移动
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //    需要的移动行
    NSInteger fromRow = [sourceIndexPath row];
    //    获取移动某处的位置
    NSInteger toRow = [destinationIndexPath row];
    //    从数组中读取需要移动行的数据
    id object = [self.dataSource objectAtIndex:fromRow];
    //    在数组中移动需要移动的行的数据
    [self.dataSource removeObjectAtIndex:fromRow];
    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
    [self.dataSource insertObject:object atIndex:toRow];
    
}

//显示的状态。删除。增减。没有
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.wTableView.editing) {// 当进入编辑页面时就显示批量选择
        return UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;//其他时候就左滑显示各种按钮
    }
}



/** 注释掉的这两个代理是：当row上显示一个按钮时写的（简明）当row上显示多个按钮时就用下面的返回数组的方式 **/
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //        获取选中删除行索引值
//    NSInteger row = [indexPath row];
//    if (editingStyle==UITableViewCellEditingStyleDelete) {//删除
//
//      
//        //        通过获取的索引值删除数组中的值
//        [self.dataSource removeObjectAtIndex:row];
//        //        删除单元格的某一行时，在用动画效果实现删除过程
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }else{
//        //我们实现的是在所选行的位置插入一行，因此直接使用了参数indexPath
//        NSArray *insertIndexPaths = [NSArray arrayWithObjects:indexPath,nil];
//        //同样，将数据加到list中，用的row
//        [self.dataSource insertObject:@"新添加的行" atIndex:row];
//        [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
//    
//    }
//}

///**
// *  修改Delete按钮文字为“删除”
// */
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

/**
 *  左滑cell时展示多个不同的按钮
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
        
    }];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
    }];
    
    
    
    return @[action1, action0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
