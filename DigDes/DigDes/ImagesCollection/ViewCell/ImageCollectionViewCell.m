//
//  ImageCollectionViewCell.m
//  DigDes
//
//  Created by Илья Виноградов on 06.04.2021.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)prepareForReuse{
    [super prepareForReuse];
    self.imageCell.image = nil;
}

@end
