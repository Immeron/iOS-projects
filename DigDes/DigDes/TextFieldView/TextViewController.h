//
//  TextViewController.h
//  DigDes
//
//  Created by Илья Виноградов on 23.04.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TextView;
- (IBAction)actionSerch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *serchButton;

@end

NS_ASSUME_NONNULL_END
