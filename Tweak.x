// Agar.io dtje029 Menu Tweak
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// Menu variables
static UIButton *menuButton = nil;
static UIView *menuView = nil;
static BOOL menuVisible = NO;

// Create floating menu button
%hook UIWindow

- (void)didAddSubview:(UIView *)subview {
    %orig;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self createMenuButton];
        });
    });
}

%new
- (void)createMenuButton {
    if (menuButton) return;

    // Create floating button
    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(self.frame.size.width - 70, 100, 60, 60);
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

    [self addSubview:menuButton];
    menuButton.layer.zPosition = 999;

    NSLog(@"[dtje029] Menu button created");
}

%new
- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self];
    menuButton.center = CGPointMake(menuButton.center.x + translation.x, menuButton.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:self];
}

%new
- (void)toggleMenu {
    if (menuVisible) {
        [self hideMenu];
    } else {
        [self showMenu];
    }
}

%new
- (void)showMenu {
    if (menuView) return;

    menuVisible = YES;

    // Create menu view
    menuView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, self.frame.size.width - 40, 400)];
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

    [self addSubview:menuView];
    menuView.layer.zPosition = 998;

    NSLog(@"[dtje029] Menu opened");
}

%new
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

%new
- (void)hideMenu {
    if (menuView) {
        [menuView removeFromSuperview];
        menuView = nil;
        menuVisible = NO;
        NSLog(@"[dtje029] Menu closed");
    }
}

%end

%ctor {
    NSLog(@"[dtje029] Tweak initialized for agar.io");
    NSLog(@"[dtje029] Menu will appear in 2 seconds");
}
