//
//  TextViewController.m
//  DigDes
//
//  Created by Илья Виноградов on 23.04.2021.
//

#import "TextViewController.h"
#import "ImagesCollectionViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"serchSegue"]){
        
        ImagesCollectionViewController *vc = (ImagesCollectionViewController*) segue.destinationViewController;
        NSString *text1 = sender;
        vc.textTF = text1;
        
        
    }
}


- (IBAction)actionSerch:(id)sender {
    [self performSegueWithIdentifier:@"serchSegue" sender:self.TextView.text];
}
@end
