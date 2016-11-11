#import "NYPLMyBooksViewController.h"

#import "NYPLMyBooksNavigationController.h"
#import "NYPLSettings.h"
#import "NYPLAccount.h"
#import "NYPLBookRegistry.h"
#import "NYPLCatalogFeedViewController.h"
#import "NYPLConfiguration.h"
#import "NYPLRootTabBarController.h"
#import "NYPLCatalogNavigationController.h"
#import "SimplyE-Swift.h"


@implementation NYPLMyBooksNavigationController

#pragma mark NSObject

- (instancetype)init
{
  NYPLMyBooksViewController *viewController =
  [[NYPLMyBooksViewController alloc] init];
  
  self = [super initWithRootViewController:viewController];
  if(!self) return nil;
  
  self.tabBarItem.image = [UIImage imageNamed:@"MyBooks"];
  
  
  viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithImage:[UIImage imageNamed:@"lib-icon"] style:(UIBarButtonItemStylePlain)
                                                     
                                                     target:self
                                                     action:@selector(switchLibrary)];
  viewController.navigationItem.leftBarButtonItem.enabled = YES;


  
  return self;
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  NYPLUserAccountType library = [[NYPLSettings sharedSettings] currentAccount];
  
  NSString *libraryName = @"New York Public Library";
  if (library == NYPLUserAccountTypeNYPL)
  {
    libraryName = @"New York Public Library";
  }
  else if (library == NYPLUserAccountTypeBrooklyn)
  {
    libraryName = @"Brooklyn Public Library";
  }
  else if (library == NYPLUserAccountTypeMagic)
  {
    libraryName = @"Instant Classics";
  }
  
  NYPLMyBooksViewController *viewController = (NYPLMyBooksViewController *)self.visibleViewController;
  
  viewController.navigationItem.title = libraryName;
  
//  [[NYPLBookRegistry sharedRegistry] reset];

}

- (void) switchLibrary
{
  NYPLMyBooksViewController *viewController = (NYPLMyBooksViewController *)self.visibleViewController;
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Pick Your Library" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
  alert.popoverPresentationController.barButtonItem = viewController.navigationItem.leftBarButtonItem;
  alert.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
  
  [alert addAction:[UIAlertAction actionWithTitle:@"New York Public Library" style:(UIAlertActionStyleDefault) handler:^(__unused UIAlertAction *_Nonnull action) {
    
    
    [[NYPLSettings sharedSettings] setCurrentAccount:NYPLUserAccountTypeNYPL];
    
    [NYPLAccount sharedAccount];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:NYPLAccountDidChangeNotification
     object:nil];
    [[NYPLSettings sharedSettings] setAccountMainFeedURL:nil];
    
    
    [[NYPLBookRegistry sharedRegistry] justLoad];
    
    
    [self reloadSelected];

    
  }]];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"Brooklyn Public Library" style:(UIAlertActionStyleDefault) handler:^(__unused UIAlertAction *_Nonnull  action) {
    
    
    [[NYPLSettings sharedSettings] setCurrentAccount:NYPLUserAccountTypeBrooklyn];
    
    [NYPLAccount sharedAccount];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:NYPLAccountDidChangeNotification
     object:nil];
    [[NYPLSettings sharedSettings] setAccountMainFeedURL:nil];
    
    [[NYPLBookRegistry sharedRegistry] justLoad];
    
    [self reloadSelected];

  }]];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"Instant Classics" style:(UIAlertActionStyleDefault) handler:^(__unused UIAlertAction *_Nonnull  action) {
    
    
    [[NYPLSettings sharedSettings] setCurrentAccount:NYPLUserAccountTypeMagic];
    [NYPLAccount sharedAccount];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:NYPLAccountDidChangeNotification
     object:nil];
    
    [[NYPLSettings sharedSettings] setAccountMainFeedURL:[NSURL URLWithString:@"http://oacontent.librarysimplified.org/"]];
    
    [[NYPLBookRegistry sharedRegistry] justLoad];
    
    [self reloadSelected];
    
  }]];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil]];
  
  [[NYPLRootTabBarController sharedController] safelyPresentViewController:alert animated:YES completion:nil];
  
}
- (void) reloadSelected {

  
  NYPLCatalogNavigationController * catalog = (NYPLCatalogNavigationController*)[NYPLRootTabBarController sharedController].viewControllers[0];
  
  [catalog reloadSelected];
  
    NYPLUserAccountType library = [[NYPLSettings sharedSettings] currentAccount];
    
    NSString *libraryName = @"New York Public Library";
  if (library == NYPLUserAccountTypeNYPL)
  {
    libraryName = @"New York Public Library";
  }
  else if (library == NYPLUserAccountTypeBrooklyn)
  {
    libraryName = @"Brooklyn Public Library";
  }
  else if (library == NYPLUserAccountTypeMagic)
  {
    libraryName = @"Instant Classics";
  }
  
    NYPLMyBooksViewController *viewController = (NYPLMyBooksViewController *)self.visibleViewController;

    viewController.navigationItem.title = libraryName;
    
    
    
  
}

@end
