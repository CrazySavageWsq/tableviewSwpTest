//
//  ViewController.h
//  tableviewSwpTest
//
//  Created by webapps on 17/2/14.
//  Copyright © 2017年 webapps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backData)(NSMutableArray *ss);

@interface TaViewController : UIViewController

@property (nonatomic, strong) NSArray *lastDataSouce;

@property (nonatomic, copy) backData backArr;

@end

