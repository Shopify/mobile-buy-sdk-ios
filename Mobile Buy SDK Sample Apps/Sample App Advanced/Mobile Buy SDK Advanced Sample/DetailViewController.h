//
//  DetailViewController.h
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-25.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

