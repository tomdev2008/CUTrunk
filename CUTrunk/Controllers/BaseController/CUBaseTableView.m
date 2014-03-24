//
//  CUBaseTableView.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUBaseTableView.h"

@interface CUBaseTableView()
{
    UIDynamicAnimator *pAnimator;
    UIGravityBehavior *gBehavior;
}
@end

@implementation CUBaseTableView
@synthesize cellZoomXScaleFactor = _xZoomFactor;
@synthesize cellZoomYScaleFactor = _yZoomFactor;
@synthesize cellZoomAnimationDuration = _animationDuration;
@synthesize cellZoomInitialAlpha = _initialAlpha;


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    pAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    [pAnimator addBehavior:gBehavior];
}

- (void)addBehaviorsToCell:(UITableViewCell*)cell{
    for (UIDynamicBehavior *behavior in pAnimator.behaviors) {
        if ([behavior isKindOfClass:[UIAttachmentBehavior class]]) {
            if ([[(UIAttachmentBehavior*)behavior items] containsObject:cell]){
                [pAnimator removeBehavior:behavior];
            }
        }
    }
    
    CGPoint anchorPoint = CGPointMake(cell.bounds.size.width/2, cell.frame.origin.y + 160);

    UIAttachmentBehavior* attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:cell attachedToAnchor:anchorPoint];
    [attachmentBehavior setLength:0];
    [attachmentBehavior setFrequency:1];
    [attachmentBehavior setDamping:0.6];
    [pAnimator addBehavior:attachmentBehavior];
}

- (void)configurePoint{
    for (UIDynamicBehavior* b in pAnimator.behaviors) {
        if ([b isKindOfClass:[UIAttachmentBehavior class]]) {
            CGPoint p = [(UIAttachmentBehavior*)b anchorPoint];
            p.y += 10;
            [(UIAttachmentBehavior*)b setAnchorPoint:p];
        }
    }
}



- (void)resetViewedCells{
    currentMaxDisplayedSection = 0;
    currentMaxDisplayedCell = 0;
}

#pragma -mark Setters for four customisable variables
- (void)setCellZoomXScaleFactor:(NSNumber *)xZoomFactor{
    _xZoomFactor = xZoomFactor;
}

- (void)setCellZoomYScaleFactor:(NSNumber *)yZoomFactor{
    _yZoomFactor = yZoomFactor;
}

- (void)setCellZoomAnimationDuration:(NSNumber *)animationDuration{
    _animationDuration = animationDuration;
}

- (void)setCellZoomInitialAlpha:(NSNumber *)initialAlpha{
    _initialAlpha = initialAlpha;
}

#pragma -mark Getters for four customisable variable. Provide default if not set.
- (NSNumber *)cellZoomXScaleFactor{
    if (_xZoomFactor == nil){
        _xZoomFactor = [NSNumber numberWithFloat:1.25];
    }
    return _xZoomFactor;
}

- (NSNumber *)cellZoomXOffset{
    if (_cellZoomXOffset == nil){
        _cellZoomXOffset = [NSNumber numberWithFloat:0];
    }
    return _cellZoomXOffset;
}

- (NSNumber *)cellZoomYOffset{
    if (_cellZoomYOffset == nil){
        _cellZoomYOffset = [NSNumber numberWithFloat:0];
    }
    return _cellZoomYOffset;
}

- (NSNumber *)cellZoomYScaleFactor{
    if (_yZoomFactor == nil){
        _yZoomFactor = [NSNumber numberWithFloat:1.25];
    }
    return _yZoomFactor;
}

- (NSNumber *)cellZoomAnimationDuration{
    if (_animationDuration == nil){
        _animationDuration = [NSNumber numberWithFloat:0.3];
    }
    return _animationDuration;
}

- (NSNumber *)cellZoomInitialAlpha{
    if (_initialAlpha == nil){
        _initialAlpha = [NSNumber numberWithFloat:0.3];
    }
    return _initialAlpha;
}


- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ((indexPath.section == 0 && currentMaxDisplayedCell == 0) || indexPath.section > currentMaxDisplayedSection){ //first item in a new section, reset the max row count
        currentMaxDisplayedCell = -1; //-1 because the check for currentMaxDisplayedCell has to be > rather than >= (otherwise the last cell is ALWAYS animated), so we need to set this to -1 otherwise the first cell in a section is never animated.
    }
    
    if (indexPath.section >= currentMaxDisplayedSection && indexPath.row > currentMaxDisplayedCell){ //this check makes cells only animate the first time you view them (as you're scrolling down) and stops them re-animating as you scroll back up, or scroll past them for a second time.
        
        //now make the image view a bit bigger, so we can do a zoomout effect when it becomes visible
        cell.contentView.alpha = self.cellZoomInitialAlpha.floatValue;
        
        CGAffineTransform transformScale = CGAffineTransformMakeScale(self.cellZoomXScaleFactor.floatValue, self.cellZoomYScaleFactor.floatValue);
        CGAffineTransform transformTranslate = CGAffineTransformMakeTranslation(self.cellZoomXOffset.floatValue, self.cellZoomYOffset.floatValue);
        
        cell.contentView.transform = CGAffineTransformConcat(transformScale, transformTranslate);
        
        [self bringSubviewToFront:cell.contentView];
        [UIView animateWithDuration:self.cellZoomAnimationDuration.floatValue animations:^{
            cell.contentView.alpha = 1;
            //clear the transform
            cell.contentView.transform = CGAffineTransformIdentity;
        } completion:nil];
        
        
        currentMaxDisplayedCell = indexPath.row;
        currentMaxDisplayedSection = indexPath.section;
    }
}

- (void)dealloc{
    [pAnimator removeAllBehaviors];
}

@end
