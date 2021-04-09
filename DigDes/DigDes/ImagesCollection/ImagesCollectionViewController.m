//
//  ImegesCollectionViewController.m
//  DigDes
//
//  Created by Илья Виноградов on 06.04.2021.
//

#import "ImagesCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "ImageDetailViewController.h"
#import "NetworkSession.h"
@interface ImagesCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *urls;
@property (strong, nonatomic) NSMutableDictionary<NSString* ,UIImage*> *cach;

@end

@implementation ImagesCollectionViewController

static NSString * const reuseIdentifier = @"imageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.tag;
    _cach = [[NSMutableDictionary alloc] initWithCapacity:50.0];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    NetworkSession *net = NetworkSession.new;
    self.urls = NSMutableArray.new;
    [net fetchImageURL:self.tag :^(NSMutableArray * _Nonnull arr){
        self.urls = arr;
     //   NSLog(@"%@", self.urls);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.urls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"imageCell";
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *stringURL = self.urls[indexPath.row];
    UIImage *image = [self.cach objectForKey:stringURL];
    if (image){
        cell.imageCell.image = image;
        
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            
            NSData *data = [[NSData alloc]initWithContentsOfURL: [NSURL URLWithString: stringURL]];
            if (data == nil){
                NSLog(@"error! Data = nil");
                return;
            }
            
            [self.cach setObject:[UIImage imageWithData:data] forKey:stringURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageCell.image = [UIImage imageWithData:data];
            });
        });
    }
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int width = 20*3;
    float available = collectionView.frame.size.width - width;
    float widthItem = available / 2;
    return CGSizeMake(widthItem, widthItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ToImageDetail" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ToImageDetail"]){
        
        ImageDetailViewController *vc = (ImageDetailViewController*) segue.destinationViewController;
        NSIndexPath *index = sender;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *stringURL = self.urls[index.row];
            
            NSData *data = [[NSData alloc]initWithContentsOfURL: [NSURL URLWithString: stringURL]];
            if (data == nil){
                NSLog(@"Error! Data = nil");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                vc.ImageViewDetail.image = [UIImage imageWithData:data];
            });
        });
        
        
    }
}
@end
