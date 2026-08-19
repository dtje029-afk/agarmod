// Agar.io @dtje029 Menu Tweak
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

static NSString *const kPHLogoBase64 =
    @"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";

static UIWindow* getKeyWindow(void) {
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                    }
                }
                if (windowScene.windows.count > 0) {
                    return windowScene.windows.firstObject;
                }
            }
        }
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow && [UIApplication sharedApplication].windows.count > 0) {
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    return keyWindow;
}

@interface MenuManager : NSObject
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIView *menuContainer;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSString *currentCategory;
@property (nonatomic, assign) BOOL isMenuOpen;
+ (instancetype)sharedInstance;
- (void)createFloatingButton;
- (void)openMenu;
- (void)closeMenu;
- (void)toggleMenu;
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

- (UIImage *)phLogoImage {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:kPHLogoBase64 options:0];
    if (data) {
        UIImage *img = [UIImage imageWithData:data];
        if (img) return img;
    }
    
    // Programmatic fallback: Crisp orange icon with "PH"
    CGSize size = CGSizeMake(100, 100);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [[UIColor colorWithRed:1.0 green:0.6 blue:0.0 alpha:1.0] setFill];
    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    
    NSDictionary *attrs = @{
        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:52] ?: [UIFont boldSystemFontOfSize:52],
        NSForegroundColorAttributeName: [UIColor blackColor]
    };
    NSString *text = @"PH";
    CGSize textSize = [text sizeWithAttributes:attrs];
    [text drawAtPoint:CGPointMake((100 - textSize.width) / 2.0, (100 - textSize.height) / 2.0) withAttributes:attrs];
    
    UIImage *rendered = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rendered;
}

- (void)createFloatingButton {
    if (self.menuButton) return;

    UIWindow *window = getKeyWindow();
    if (!window) return;

    CGFloat btnSize = 48.0;
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuButton.frame = CGRectMake(window.frame.size.width - btnSize - 16, 120, btnSize, btnSize);
    self.menuButton.layer.cornerRadius = 12.0;
    self.menuButton.clipsToBounds = YES;
    self.menuButton.layer.borderWidth = 1.0;
    self.menuButton.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.3].CGColor;
    
    // Shadow
    self.menuButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.menuButton.layer.shadowOffset = CGSizeMake(0, 3);
    self.menuButton.layer.shadowOpacity = 0.45;
    self.menuButton.layer.shadowRadius = 5;
    self.menuButton.layer.masksToBounds = NO;

    UIImageView *iconView = [[UIImageView alloc] initWithFrame:self.menuButton.bounds];
    iconView.image = [self phLogoImage];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.cornerRadius = 12.0;
    iconView.clipsToBounds = YES;
    iconView.userInteractionEnabled = NO;
    [self.menuButton addSubview:iconView];

    [self.menuButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleButtonPan:)];
    [self.menuButton addGestureRecognizer:pan];

    [window addSubview:self.menuButton];
    self.menuButton.layer.zPosition = 9999;
}

- (void)handleButtonPan:(UIPanGestureRecognizer *)gesture {
    UIView *btn = gesture.view;
    CGPoint translation = [gesture translationInView:btn.superview];
    btn.center = CGPointMake(btn.center.x + translation.x, btn.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:btn.superview];
}

- (void)handleMenuPan:(UIPanGestureRecognizer *)gesture {
    UIView *menu = self.menuContainer;
    CGPoint translation = [gesture translationInView:menu.superview];
    menu.center = CGPointMake(menu.center.x + translation.x, menu.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:menu.superview];
}

- (void)toggleMenu {
    if (self.isMenuOpen) {
        [self closeMenu];
    } else {
        [self openMenu];
    }
}

- (void)openMenu {
    if (self.isMenuOpen && self.menuContainer) return;

    UIWindow *window = getKeyWindow();
    if (!window) return;

    self.isMenuOpen = YES;

    // Hide floating button while menu is open
    [UIView animateWithDuration:0.15 animations:^{
        self.menuButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.menuButton.hidden = YES;
    }];

    CGFloat width = 230.0;
    CGFloat height = 312.0;
    CGFloat posX = MAX(16, window.frame.size.width - width - 20);
    CGFloat posY = 70.0;

    self.menuContainer = [[UIView alloc] initWithFrame:CGRectMake(posX, posY, width, height)];
    self.menuContainer.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.15 alpha:0.96];
    self.menuContainer.layer.cornerRadius = 14.0;
    self.menuContainer.layer.borderWidth = 1.0;
    self.menuContainer.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.2].CGColor;
    self.menuContainer.clipsToBounds = YES;

    // Header View
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    headerView.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:0.98];

    UIPanGestureRecognizer *menuPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMenuPan:)];
    [headerView addGestureRecognizer:menuPan];

    // Back Button (‹)
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(6, 4, 36, 36);
    [self.backButton setTitle:@"‹" forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont boldSystemFontOfSize:26];
    [self.backButton setTitleColor:[UIColor colorWithRed:1.0 green:0.6 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(onBackTapped) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.hidden = YES;
    [headerView addSubview:self.backButton];

    // Title: @dtje029
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, width - 80, 44)];
    self.titleLabel.text = @"@dtje029";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16] ?: [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.titleLabel];

    // Close Button (✕)
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(width - 40, 4, 36, 36);
    [closeBtn setTitle:@"✕" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [closeBtn setTitleColor:[UIColor colorWithWhite:0.85 alpha:1.0] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:closeBtn];

    // Header divider line
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, width, 0.5)];
    divider.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.15];
    [headerView addSubview:divider];

    [self.menuContainer addSubview:headerView];

    // Content container view
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, width, height - 44)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.menuContainer addSubview:self.contentView];

    [self renderCategoryList];

    [window addSubview:self.menuContainer];
    self.menuContainer.layer.zPosition = 9998;

    // Pop-in animation
    self.menuContainer.transform = CGAffineTransformMakeScale(0.9, 0.9);
    self.menuContainer.alpha = 0.0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.menuContainer.transform = CGAffineTransformIdentity;
        self.menuContainer.alpha = 1.0;
    } completion:nil];
}

- (void)closeMenu {
    if (!self.menuContainer) return;
    
    // Show floating button again
    self.menuButton.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.menuButton.alpha = 1.0;
        self.menuContainer.alpha = 0.0;
        self.menuContainer.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [self.menuContainer removeFromSuperview];
        self.menuContainer = nil;
        self.isMenuOpen = NO;
    }];
}

#pragma mark - Main Category List (Shark Menu Style)

- (void)renderCategoryList {
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    self.titleLabel.text = @"@dtje029";
    self.backButton.hidden = YES;
    self.currentCategory = nil;

    NSArray *categories = @[
        @"Gameplay",
        @"Zoom",
        @"Macro",
        @"Indicators",
        @"Party",
        @"Visuals"
    ];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = NO;

    CGFloat rowHeight = 44.0;
    CGFloat y = 0.0;

    for (int i = 0; i < categories.count; i++) {
        NSString *cat = categories[i];

        UIButton *rowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rowBtn.frame = CGRectMake(0, y, self.contentView.frame.size.width, rowHeight);
        rowBtn.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.17 alpha:0.9];
        rowBtn.tag = i;
        [rowBtn addTarget:self action:@selector(onCategorySelected:) forControlEvents:UIControlEventTouchUpInside];

        // Category Label
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 160, rowHeight)];
        nameLabel.text = cat;
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15] ?: [UIFont systemFontOfSize:15];
        [rowBtn addSubview:nameLabel];

        // Chevron ›
        UILabel *chevron = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 28, 0, 20, rowHeight)];
        chevron.text = @"›";
        chevron.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        chevron.font = [UIFont boldSystemFontOfSize:20];
        chevron.textAlignment = NSTextAlignmentCenter;
        [rowBtn addSubview:chevron];

        // Row Separator Line
        UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, rowHeight - 0.5, self.contentView.frame.size.width, 0.5)];
        sep.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
        [rowBtn addSubview:sep];

        [scrollView addSubview:rowBtn];
        y += rowHeight;
    }

    scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, y);
    [self.contentView addSubview:scrollView];
}

- (void)onCategorySelected:(UIButton *)sender {
    NSArray *categories = @[@"Gameplay", @"Zoom", @"Macro", @"Indicators", @"Party", @"Visuals"];
    if (sender.tag < categories.count) {
        NSString *selected = categories[sender.tag];
        [self openSubCategory:selected];
    }
}

- (void)onBackTapped {
    [UIView transitionWithView:self.contentView duration:0.18 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self renderCategoryList];
    } completion:nil];
}

#pragma mark - Subtab Pages

- (void)openSubCategory:(NSString *)cat {
    self.currentCategory = cat;
    self.titleLabel.text = cat;
    self.backButton.hidden = NO;

    [UIView transitionWithView:self.contentView duration:0.18 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        for (UIView *v in self.contentView.subviews) {
            [v removeFromSuperview];
        }

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.alwaysBounceVertical = YES;
        CGFloat y = 8.0;

        if ([cat isEqualToString:@"Gameplay"]) {
            y = [self addToggle:@"Speed Hack" key:@"dt_speed" toView:scrollView atY:y];
            y = [self addSlider:@"Speed Multiplier" key:@"dt_speed_val" min:1.0 max:5.0 def:2.0 toView:scrollView atY:y];
            y = [self addToggle:@"Auto Respawn" key:@"dt_respawn" toView:scrollView atY:y];
            y = [self addToggle:@"Anti-Lag Mode" key:@"dt_antilag" toView:scrollView atY:y];
            y = [self addToggle:@"Split 16x Helper" key:@"dt_split16" toView:scrollView atY:y];
        } else if ([cat isEqualToString:@"Zoom"]) {
            y = [self addToggle:@"Zoom Hack" key:@"dt_zoom" toView:scrollView atY:y];
            y = [self addSlider:@"FOV Distance" key:@"dt_zoom_val" min:1.0 max:4.0 def:2.0 toView:scrollView atY:y];
            y = [self addToggle:@"Infinite View" key:@"dt_infzoom" toView:scrollView atY:y];
            y = [self addToggle:@"Smooth Zooming" key:@"dt_smoothzoom" toView:scrollView atY:y];
        } else if ([cat isEqualToString:@"Macro"]) {
            y = [self addToggle:@"Fast Macro Feed (W)" key:@"dt_macro_feed" toView:scrollView atY:y];
            y = [self addSlider:@"Feed Delay (ms)" key:@"dt_feed_delay" min:10 max:100 def:25 toView:scrollView atY:y];
            y = [self addToggle:@"Double Split Macro" key:@"dt_double_split" toView:scrollView atY:y];
            y = [self addToggle:@"Tricksplit Macro" key:@"dt_tricksplit" toView:scrollView atY:y];
            y = [self addToggle:@"Pop-Split Assist" key:@"dt_popsplit" toView:scrollView atY:y];
        } else if ([cat isEqualToString:@"Indicators"]) {
            y = [self addToggle:@"Show Virus Safe Range" key:@"dt_ind_virus" toView:scrollView atY:y];
            y = [self addToggle:@"Show Mass Overlay" key:@"dt_ind_mass" toView:scrollView atY:y];
            y = [self addToggle:@"Danger Radar" key:@"dt_ind_radar" toView:scrollView atY:y];
            y = [self addToggle:@"Enemy Split Prediction" key:@"dt_ind_predict" toView:scrollView atY:y];
        } else if ([cat isEqualToString:@"Party"]) {
            y = [self addToggle:@"Auto Rejoin Room" key:@"dt_party_rejoin" toView:scrollView atY:y];
            y = [self addToggle:@"Anti-Kick Protection" key:@"dt_party_antikick" toView:scrollView atY:y];
            y = [self addActionButton:@"Copy Party Token" action:@selector(copyPartyCode) toView:scrollView atY:y];
        } else if ([cat isEqualToString:@"Visuals"]) {
            y = [self addToggle:@"No Ads (AdBlock)" key:@"dt_noads" toView:scrollView atY:y];
            y = [self addToggle:@"Dark Theme Arena" key:@"dt_darktheme" toView:scrollView atY:y];
            y = [self addToggle:@"Rainbow Mass Color" key:@"dt_rainbow" toView:scrollView atY:y];
            y = [self addToggle:@"Hide Player Names" key:@"dt_hidenames" toView:scrollView atY:y];
            y = [self addActionButton:@"Reset Settings" action:@selector(resetAllSettings) toView:scrollView atY:y];
        }

        scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, y + 10.0);
        [self.contentView addSubview:scrollView];
    } completion:nil];
}

#pragma mark - UI Row Helpers

- (CGFloat)addToggle:(NSString *)title key:(NSString *)key toView:(UIView *)parent atY:(CGFloat)y {
    CGFloat w = self.contentView.frame.size.width;
    UIView *row = [[UIView alloc] initWithFrame:CGRectMake(8, y, w - 16, 42)];
    row.backgroundColor = [UIColor colorWithWhite:0.16 alpha:0.65];
    row.layer.cornerRadius = 8.0;

    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, w - 80, 42)];
    lbl.text = title;
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:13.5 weight:UIFontWeightMedium];
    [row addSubview:lbl];

    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(w - 74, 6, 48, 28)];
    sw.transform = CGAffineTransformMakeScale(0.78, 0.78);
    sw.onTintColor = [UIColor colorWithRed:1.0 green:0.58 blue:0.0 alpha:1.0]; // Orange accent
    sw.on = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    sw.accessibilityIdentifier = key;
    [sw addTarget:self action:@selector(onSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [row addSubview:sw];

    [parent addSubview:row];
    return y + 46.0;
}

- (CGFloat)addSlider:(NSString *)title key:(NSString *)key min:(float)min max:(float)max def:(float)def toView:(UIView *)parent atY:(CGFloat)y {
    CGFloat w = self.contentView.frame.size.width;
    UIView *row = [[UIView alloc] initWithFrame:CGRectMake(8, y, w - 16, 56)];
    row.backgroundColor = [UIColor colorWithWhite:0.16 alpha:0.65];
    row.layer.cornerRadius = 8.0;

    float val = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[NSUserDefaults standardUserDefaults] floatForKey:key] : def;

    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, w - 90, 20)];
    lbl.text = title;
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    [row addSubview:lbl];

    UILabel *valLbl = [[UILabel alloc] initWithFrame:CGRectMake(w - 75, 4, 55, 20)];
    valLbl.text = [NSString stringWithFormat:@"%.1fx", val];
    valLbl.textColor = [UIColor colorWithRed:1.0 green:0.58 blue:0.0 alpha:1.0];
    valLbl.font = [UIFont boldSystemFontOfSize:13];
    valLbl.textAlignment = NSTextAlignmentRight;
    valLbl.tag = 999;
    [row addSubview:valLbl];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 26, w - 36, 24)];
    slider.minimumValue = min;
    slider.maximumValue = max;
    slider.value = val;
    slider.minimumTrackTintColor = [UIColor colorWithRed:1.0 green:0.58 blue:0.0 alpha:1.0];
    slider.accessibilityIdentifier = key;
    [slider addTarget:self action:@selector(onSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [row addSubview:slider];

    [parent addSubview:row];
    return y + 60.0;
}

- (CGFloat)addActionButton:(NSString *)title action:(SEL)action toView:(UIView *)parent atY:(CGFloat)y {
    CGFloat w = self.contentView.frame.size.width;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(8, y, w - 16, 36);
    btn.backgroundColor = [UIColor colorWithRed:1.0 green:0.58 blue:0.0 alpha:0.95];
    btn.layer.cornerRadius = 8.0;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13.5];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [parent addSubview:btn];
    return y + 42.0;
}

- (void)onSwitchChanged:(UISwitch *)sw {
    NSString *key = sw.accessibilityIdentifier;
    if (key) {
        [[NSUserDefaults standardUserDefaults] setBool:sw.isOn forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"[dtje029] %@ = %d", key, sw.isOn);
    }
}

- (void)onSliderChanged:(UISlider *)sl {
    NSString *key = sl.accessibilityIdentifier;
    if (key) {
        [[NSUserDefaults standardUserDefaults] setFloat:sl.value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIView *parent = sl.superview;
        UILabel *valLbl = [parent viewWithTag:999];
        if (valLbl) {
            valLbl.text = [NSString stringWithFormat:@"%.1fx", sl.value];
        }
    }
}

- (void)copyPartyCode {
    [UIPasteboard generalPasteboard].string = @"agar.io/#party";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"@dtje029"
                                                                   message:@"Party link copied to clipboard!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [getKeyWindow().rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)resetAllSettings {
    NSArray *keys = @[@"dt_speed", @"dt_speed_val", @"dt_respawn", @"dt_antilag", @"dt_split16",
                      @"dt_zoom", @"dt_zoom_val", @"dt_infzoom", @"dt_smoothzoom",
                      @"dt_macro_feed", @"dt_feed_delay", @"dt_double_split", @"dt_tricksplit", @"dt_popsplit",
                      @"dt_ind_virus", @"dt_ind_mass", @"dt_ind_radar", @"dt_ind_predict",
                      @"dt_party_rejoin", @"dt_party_antikick",
                      @"dt_noads", @"dt_darktheme", @"dt_rainbow", @"dt_hidenames"];
    for (NSString *k in keys) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:k];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self openSubCategory:self.currentCategory ?: @"Gameplay"];
}

@end

static void scheduleMenu(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[MenuManager sharedInstance] createFloatingButton];
        });
    });
}

__attribute__((constructor))
static void dtje029mod_init(void) {
    NSLog(@"[dtje029] Menu initialized");
    
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

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        scheduleMenu();
    });
}


