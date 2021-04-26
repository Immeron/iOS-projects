//
//  TableViewController.m
//  DigDes
//
//  Created by Илья Виноградов on 05.04.2021.
//

#import "TableViewController.h"
#import "NetworkSession.h"
#import "ImagesCollectionViewController.h"
@interface TableViewController ()
@property (strong, nonatomic) NSMutableArray *datas;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NetworkSession *net = NetworkSession.new;
    self.datas = NSMutableArray.new;
    [net fetchData:^(NSMutableArray * _Nonnull arr) {
        self.datas = arr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    __auto_type defaultConf = cell.defaultContentConfiguration;
    defaultConf.text = self.datas[indexPath.row];
    cell.contentConfiguration = defaultConf;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"SegueToCells" sender:indexPath];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SegueToCells"]){
        
        ImagesCollectionViewController *vc = (ImagesCollectionViewController*) segue.destinationViewController;
        NSIndexPath *index = sender;
        vc.tag = self.datas[index.row];
        
    }
}
@end
