//
//  ImegesCollectionViewController.h
//  DigDes
//
//  Created by Илья Виноградов on 06.04.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagesCollectionViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout>
@property (assign, nonatomic) NSString *tag;
@end

NS_ASSUME_NONNULL_END
