@import UIKit;

@interface FoodItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) UIColor *color;

- (id)initWithName:(NSString *)name color:(UIColor *)color;

@end


@interface SectionItem : NSObject

@property (nonatomic, copy) NSString *sectionName;
@property (nonatomic, copy) NSString *sectionFooter;
@property (nonatomic, strong) NSMutableArray *sectionContents;

@end