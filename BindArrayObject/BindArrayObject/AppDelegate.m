//
//  AppDelegate.m
//  BindArrayObject
//
//  Created by Chen Xiaohan on 2021/10/19.
//

#import "AppDelegate.h"
#import "Employee.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSArrayController *arrayController;
@property (nonatomic,strong) NSMutableArray *anArray;
@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    Employee *em = [[Employee alloc]init];
    em.ID = 0;
    em.name = @"";
    em.address = @"";
    em.age = 0;
    self.anArray = [NSMutableArray array];
    [self.anArray addObject:em];
//    self.employee  = em;
    
    NSDictionary *options = @{ NSAllowsEditingMultipleValuesSelectionBindingOption:@YES };
    //arrayController和anArray的绑定
    [self.arrayController bind:@"contentArray"
                          toObject:self
                       withKeyPath:@"anArray"
                           options:options];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
