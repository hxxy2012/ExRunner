//
//  RORAccountViewController.h
//  RevolUtioN
//
//  Created by Beyond on 13-6-26.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RORAccountViewController : UIViewController{

    NSMutableArray *shareTypeArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tblAutoView;

- (IBAction)backAction:(id)sender;
- (IBAction)logoutAction:(id)sender ;

@end
