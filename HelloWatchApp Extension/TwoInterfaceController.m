//
//  TwoInterfaceController.m
//  HelloWatch
//
//  Created by keyan on 15/10/15.
//  Copyright © 2015年 keyan. All rights reserved.
//

#import "TwoInterfaceController.h"

@interface MainRowType : WKInterfaceTable

@end

@implementation MainRowType



@end

@interface MyDataObject : NSObject

@end

@implementation MyDataObject



@end
@interface TwoInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *mainTableView;

@end

@implementation TwoInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    
    
    // Configure interface objects here.
}
- (void)configureTableWithData:(NSArray*)dataObjects {
//    [self.mainTableView setNumberOfRows:[dataObjects count] withRowType:@"mainRowType"];
//    for (NSInteger i = 0; i < self.mainTableView.numberOfRows; i++) {
//        MainRowType* theRow = [self.mainTableView rowControllerAtIndex:i];
//        MyDataObject* dataObj = [dataObjects objectAtIndex:i];
//        
//        [theRow.rowDescription setText:dataObj.text];
//        [theRow.rowIcon setImage:dataObj.image];
//    }
}
- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



