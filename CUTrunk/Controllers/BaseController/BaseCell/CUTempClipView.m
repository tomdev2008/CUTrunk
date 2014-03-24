//
//  CUTempClipView.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//


#import "CUTempClipView.h"
#import "CUPostDto.h"

@implementation CUTempClipView
@synthesize imageView       = _imageView;
@synthesize textLabel       = _textLabel;
@synthesize detailsLabel    = _detailsLabel;
@synthesize nameLabel       = _nameLabel;
@synthesize timeLabel       = _timeLabel;
@synthesize commentButton   = _commentButton;
@synthesize likeButton      = _likeButton;
@synthesize imageViewBackground = _imageViewBackground;
@synthesize postDto = _postDto;

#define PLAYVIEW_WIDTH 300.
#define PLAYVIEW_HEIGHT 300.
#define PLAYVIEW_HEAD 50.
#define PLAYVIEW_TAIL 42.

#pragma mark -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createSubview];
    }
    return self;
}

+ (CGFloat)rowHeightForObject:(id)item
{
    float height = .0;
    
    if(item && [item isKindOfClass:[NSDictionary class]])
    {
        
       
    }
    return PLAYVIEW_HEIGHT + PLAYVIEW_HEAD + PLAYVIEW_TAIL + height + 12;
}

- (void)setObject:(id)item
{
    if(item && [item isKindOfClass:[NSDictionary class]])
    {
        if (!self.postDto) {
            self.postDto = [[CUPostDto alloc] init];
        }
        
        if([_postDto parse2:item])
        {
            
        }
    }
}

- (void)createSubview
{
    //[self setBackgroundColor:[UIColor redColor]];
   
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    UIImage *image = [UIImage imageNamed:@"clip_view_background.png"];
    image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
    
//    self.imageViewBackground =[[UIImageView alloc] initWithImage:image];
//    [_imageViewBackground setFrame:CGRectMake(7, 0, 306, 100)];
//    [_imageViewBackground setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
//    
//    [self addSubview:_imageViewBackground];
    
    self.textLabel = [UILabel new];
    [_textLabel setFrame:CGRectMake(10, 15, self.width - 20, 18)];
    [_textLabel setTextAlignment:NSTextAlignmentLeft];
    [_textLabel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [_textLabel setBackgroundColor:[UIColor redColor]];
    [_textLabel setText:@"dasfsafafasf"];
    [_textLabel setTextColor:[UIColor colorWithRed:101./255. green:101./255. blue:101./255. alpha:1.0]];
    [_textLabel setFont:[UIFont systemFontOfSize:14]];
    [_textLabel setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:_textLabel];
    
    self.nameLabel = [UILabel new];
    [_nameLabel setFrame:CGRectMake(_textLabel.left, _textLabel.bottom + 10, 50, 14)];
    [_nameLabel setTextAlignment:NSTextAlignmentLeft];
    [_nameLabel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [_nameLabel setBackgroundColor:[UIColor blackColor]];
    [_nameLabel setText:@"fadsfasf"];
    [_nameLabel setTextColor:[UIColor colorWithRed:101./255. green:101./255. blue:101./255. alpha:1.0]];
    [_nameLabel setFont:[UIFont systemFontOfSize:12]];
    [_nameLabel setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:_nameLabel];
    
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setFrame:CGRectMake(_nameLabel.left, _nameLabel.top, 20, 30)];
    [self addSubview:_commentButton];
 
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setFrame:CGRectMake(_commentButton.right + 10, _commentButton.top, 20, 30)];
    [self addSubview:_likeButton];
    
    self.timeLabel = [UILabel new];
    [_timeLabel setFrame:CGRectMake(self.width - 80 - 10, _likeButton.top, 80, 16)];
    [_timeLabel setTextAlignment:NSTextAlignmentLeft];
    [_timeLabel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [_timeLabel setBackgroundColor:[UIColor yellowColor]];
    [_timeLabel setText:@"fdafasfasdfasfads"];
    [_timeLabel setTextColor:[UIColor colorWithRed:101./255. green:101./255. blue:101./255. alpha:1.0]];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    [_timeLabel setAdjustsFontSizeToFitWidth:YES];
    
    
    self.imageView = [UIImageView new];
    [_imageView setFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + 10, self.width - 20, self.height - _nameLabel.bottom - 10)];
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [_imageView setBackgroundColor:[UIColor grapeColor]];
    [self addSubview:_imageView];
    
    self.detailsLabel = [UILabel new];
    [_detailsLabel setFrame:CGRectMake(_imageView.right + 10, _imageView.top, self.width - _imageView.right - 20, self.height-30)];
    [_detailsLabel setTextAlignment:NSTextAlignmentLeft];
    [_detailsLabel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [_detailsLabel setBackgroundColor:[UIColor blueColor]];
    [_detailsLabel setText:@"fdahshjfbajksfbewiaufajkslvjkdxbvhjabsfkjasfaksdjfdajksfbjdabfdahjfbahjfdbajhdfbahjdfbajhfbahjdf"];
    [_detailsLabel setTextColor:[UIColor colorWithRed:101./255. green:101./255. blue:101./255. alpha:1.0]];
    [_detailsLabel setFont:[UIFont systemFontOfSize:14]];
    //自动折行设置
    _detailsLabel.lineBreakMode = UILineBreakModeWordWrap;
    _detailsLabel.numberOfLines = 5;
    [self addSubview:_detailsLabel];
   
}

- (void)layoutSubviews
{
    if(!self.postDto.image_url)
    {
        [_detailsLabel setLeft:_textLabel.left];
        [_detailsLabel setWidth:_textLabel.width];
    }
}

@end