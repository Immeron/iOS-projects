//
//  NetworkSession.h
//  DigDes
//
//  Created by Илья Виноградов on 06.04.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkSession : NSObject
-(void) fetchData: (void(^)(NSMutableArray* arr))completion;
-(void) fetchImageURL:(NSString*)inputTextOrTag :(NSString*)tagsOrText :(void(^)(NSMutableArray* arr_s, NSMutableArray* arr_l))completion;
@end

NS_ASSUME_NONNULL_END
