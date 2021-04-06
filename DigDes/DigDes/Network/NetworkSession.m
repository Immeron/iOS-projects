//
//  NetworkSession.m
//  DigDes
//
//  Created by Илья Виноградов on 06.04.2021.
//

#import "NetworkSession.h"

@implementation NetworkSession


-(void) fetchData: (void(^)(NSMutableArray* arr))completion{
    NSString *urlString = @"https://www.flickr.com/services/rest/?method=flickr.tags.getHotList&api_key=eab35027935d7a4ac21f4e882a000446&count=10&format=json&nojsoncallback=1";
    NSURL *url = [NSURL URLWithString: urlString];
    [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"%@", err);
            return;
        }
        NSMutableArray *array = NSMutableArray.new;
        NSDictionary *dict = dataJSON[@"hottags"];
        NSArray *arr = dict[@"tag"];
        for (NSDictionary *temp in arr){
            NSString *tag = temp[@"_content"];
            [array addObject:tag];
        }
        completion(array);
        
        
        }] resume];
}

-(void) fetchImageURL:(NSString*)tag :(void(^)(NSMutableArray* arr))completion{
   // NSString *urlString = @"https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=eab35027935d7a4ac21f4e882a000446&tags=france&extras=url_l&per_page=10&page=1&format=json&nojsoncallback=1";
    NSString *urlString = @"https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=eab35027935d7a4ac21f4e882a000446&tags=";
    urlString = [urlString stringByAppendingString:tag];
    urlString = [urlString stringByAppendingString:@"&extras=url_l&per_page=10&page=1&format=json&nojsoncallback=1"];
    NSURL *url = [NSURL URLWithString: urlString];
    [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"%@", err);
            return;
        }
        NSMutableArray *array = NSMutableArray.new;
        NSDictionary *dict = dataJSON[@"photos"];
        NSArray *arr = dict[@"photo"];
        for (NSDictionary *temp in arr){
            NSString *url = temp[@"url_l"];
            if(url==nil){
                [array addObject:@"error"];
            }else{
            [array addObject:url];
            }
        }
        completion(array);
        
        
        }] resume];
    
}
@end
