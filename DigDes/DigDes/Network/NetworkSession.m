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

-(void) fetchImageURL: (NSString*)inputTextOrTag :(NSString*)tagsOrText :(void(^)(NSMutableArray* arr_s, NSMutableArray* arr_l))completion{
    NSString *urlString = @"https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=eab35027935d7a4ac21f4e882a000446&";
    urlString = [urlString stringByAppendingString:tagsOrText];
    urlString = [urlString stringByAppendingString:@"="];
    urlString = [urlString stringByAppendingString:inputTextOrTag];
    urlString = [urlString stringByAppendingString:@"&extras=url_s%2C+url_l&per_page=10&page=1&format=json&nojsoncallback=1"];
    NSURL *url = [NSURL URLWithString: urlString];
    [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"%@", err);
            return;
        }
        NSMutableArray *array_s = NSMutableArray.new;
        NSMutableArray *array_l = NSMutableArray.new;
        NSDictionary *dict = dataJSON[@"photos"];
        NSArray *arr = dict[@"photo"];
        for (NSDictionary *temp in arr){
            NSString *url_s = temp[@"url_s"];
            NSString *url_l = temp[@"url_l"];
            if(url_s==nil){
                [array_s addObject:@"error"];
            }else{
                [array_s addObject:url_s];
                
            }
            if(url_l == nil){
                [array_l addObject:@"error"];
            }else{
                [array_l addObject:url_l];
            }
        }
        completion(array_s, array_l);
        }] resume];
    
}

@end

