#import "Models.h"

@implementation FoodItem

- (id)initWithName:(NSString *)name
             color:(UIColor *)color
{
    self = [super init];
    if (self)
    {
        _name = name;
        _color = color;
    }
    return self;
}

@end


@implementation SectionItem

- (id)init
{
    self = [super init];
    if (self)
    {
        _sectionContents = [NSMutableArray array];
    }
    return self;
}

@end