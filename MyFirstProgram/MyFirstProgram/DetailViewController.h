//
//  DetailViewController.h
//  MyFirstProgram
//
//  Created by Soeb on 11/22/16.
//  Copyright © 2016 Soeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

