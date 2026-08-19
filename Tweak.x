// Agar.io dtje029 Menu Tweak
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// Menu variables
static UIButton *menuButton = nil;
static UIView *menuView = nil;
static BOOL menuVisible = NO;

// Helper function to get the key window
static UIWindow* getKeyWindow() {
    UIWindow *keyWindow = nil;

    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *scenes = [[UIApplication sharedApplication] connectedScenes];
        for (UIScene *scene in scenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
            }
            if (keyWindow) break;
        }
    }

    if (!keyWindow) {
        keyWindow = [[UIApplication sharedApplication] keyWindow];
    }

    if (!keyWindow) {
        keyWindow = [[[UIApplication sharedApplication] windows] firstObject];
    }

    return keyWindow;
}

@interface MenuManager : NSObject
+ (instancetype)sharedInstance;
- (void)createMenuButton;
- (void)toggleMenu;
- (void)showMenu;
- (void)hideMenu;
- (void)handlePan:(UIPanGestureRecognizer *)gesture;
- (UIView *)createFeatureRow:(NSString *)name atY:(CGFloat)y;
@end

@implementation MenuManager

+ (instancetype)sharedInstance {
    static MenuManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)createMenuButton {
    if (menuButton) return;

    UIWindow *window = getKeyWindow();
    if (!window) {
        NSLog(@"[dtje029] Failed to get key window");
        return;
    }

    // Create floating button
    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(window.frame.size.width - 70, 100, 60, 60);
    menuButton.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:0.9];
    menuButton.layer.cornerRadius = 30;
    menuButton.layer.borderWidth = 2;
    menuButton.layer.borderColor = [UIColor whiteColor].CGColor;

    // Add "D" text for dtje029
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    label.text = @"D";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    [menuButton addSubview:label];

    [menuButton addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];

    // Make draggable
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [menuButton addGestureRecognizer:panGesture];

    [window addSubview:menuButton];
    menuButton.layer.zPosition = 999;

    NSLog(@"[dtje029] Menu button created");
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    CGPoint translation = [gesture translationInView:view.superview];
    view.center = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:view.superview];
}

- (void)toggleMenu {
    if (menuVisible) {
        [self hideMenu];
    } else {
        [self showMenu];
    }
}

- (void)showMenu {
    if (menuView) return;

    menuVisible = YES;

    UIWindow *window = getKeyWindow();
    if (!window) return;

    // Create menu view
    menuView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, window.frame.size.width - 40, 400)];
    menuView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.95];
    menuView.layer.cornerRadius = 15;
    menuView.layer.borderWidth = 2;
    menuView.layer.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:1.0].CGColor;

    // Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, menuView.frame.size.width, 40)];
    titleLabel.text = @"dtje029 Menu";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [menuView addSubview:titleLabel];

    // Close button
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn.frame = CGRectMake(menuView.frame.size.width - 40, 10, 30, 30);
    [closeBtn setTitle:@"✕" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:closeBtn];

    // Example features
    NSArray *features = @[@"Speed Hack", @"Zoom Hack", @"No Ads", @"God Mode"];
    CGFloat yPos = 60;

    for (NSString *feature in features) {
        UIView *featureRow = [self createFeatureRow:feature atY:yPos];
        [menuView addSubview:featureRow];
        yPos += 60;
    }

    // Info label
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, menuView.frame.size.height - 40, menuView.frame.size.width - 40, 30)];
    infoLabel.text = @"dtje029 Mod v1.0";
    infoLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [menuView addSubview:infoLabel];

    [window addSubview:menuView];
    menuView.layer.zPosition = 998;

    NSLog(@"[dtje029] Menu opened");
}

- (UIView *)createFeatureRow:(NSString *)name atY:(CGFloat)y {
    UIView *row = [[UIView alloc] initWithFrame:CGRectMake(20, y, menuView.frame.size.width - 40, 50)];
    row.backgroundColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    row.layer.cornerRadius = 10;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 50)];
    label.text = name;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    [row addSubview:label];

    UISwitch *toggle = [[UISwitch alloc] initWithFrame:CGRectMake(row.frame.size.width - 60, 10, 50, 30)];
    toggle.onTintColor = [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:1.0];
    [row addSubview:toggle];

    return row;
}

- (void)hideMenu {
    if (menuView) {
        [menuView removeFromSuperview];
        menuView = nil;
        menuVisible = NO;
        NSLog(@"[dtje029] Menu closed");
    }
}

@end

static void scheduleMenu(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[MenuManager sharedInstance] createMenuButton];
        });
    });
}

__attribute__((constructor))
static void dtje029mod_init(void) {
    NSLog(@"[dtje029] Tweak initialized for agar.io (no substrate dependency)");
    
    // Listen for app launch / active state to display menu button
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(__unused NSNotification *note) {
        scheduleMenu();
    }];

    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(__unused NSNotification *note) {
        scheduleMenu();
    }];

    // Also trigger after delay in case notifications already fired
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        scheduleMenu();
    });
}

