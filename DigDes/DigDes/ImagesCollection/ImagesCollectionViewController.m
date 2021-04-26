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
@property (strong, nonatomic) NSMutableArray *urll;
@property (strong, nonatomic) NSMutableDictionary<NSString* ,UIImage*> *cache;

@end

@implementation ImagesCollectionViewController

static NSString * const reuseIdentifier = @"imageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _cache = [[NSMutableDictionary alloc] initWithCapacity:50.0];
    NetworkSession *net = NetworkSession.new;
    self.urls = NSMutableArray.new;
    self.urll = NSMutableArray.new;
    if (self.tag!=nil){
        self.title = self.tag;
        [net fetchImageURL:self.tag :@"tags" :^(NSMutableArray * _Nonnull arr_s, NSMutableArray * _Nonnull arr_l) {
            self.urls = arr_s;
            self.urll = arr_l;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
    if (self.textTF!=nil){
        self.title = self.textTF;
        NSString *textInUrl = [self.textTF stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [net fetchImageURL:textInUrl :@"text" :^(NSMutableArray * _Nonnull arr_s, NSMutableArray * _Nonnull arr_l) {
            self.urls = arr_s;
            self.urll = arr_l;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
    
    
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
}


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
    UIImage *image = [self.cache objectForKey:stringURL];
    [cell.loadingIndicator startAnimating];
    cell.loadingIndicator.hidesWhenStopped = true;
    if (image){
        [cell.loadingIndicator stopAnimating];
        cell.imageCell.image = image;
        
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [[NSData alloc]initWithContentsOfURL: [NSURL URLWithString: stringURL]];
            if (data == nil){
                NSLog(@"error! Data = nil");
                return;
            }
            
            [self.cache setObject:[UIImage imageWithData:data] forKey:stringURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.loadingIndicator stopAnimating];
                cell.imageCell.image = [UIImage imageWithData:data];
            });
        });
    }
    
    
    return cell;
}

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
            NSString *stringURL = self.urll[index.row];
            
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
