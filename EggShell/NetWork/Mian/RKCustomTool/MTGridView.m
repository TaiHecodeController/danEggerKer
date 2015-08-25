//
//  MTGridView.m
//  TmallClient-iPhone
//
//  Created by hjy_x on 3/14/13.
//  Copyright (c) 2013 Tmall.com. All rights reserved.
//

#import "MTGridView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSIndexPath+RK_row_col.h"

@interface MTGridViewItem()
@property (nonatomic, assign) MTGridViewItemStyle style;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGSize frameSize;
@end

@implementation MTGridViewItem

- (id)initWithStyle:(MTGridViewItemStyle)style identifier:(NSString *)identifier
{
    self = [super init];
    
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    return self;
}

@end


@interface TMGridCell : UITableViewCell
@property (nonatomic, assign) int rowIndex;
@property (nonatomic, assign) int columnCount;
@property (nonatomic, strong) NSMutableArray *columnItems;
@property (nonatomic, assign) float colSpace;
@property (nonatomic, assign) UIEdgeInsets paddingInsets;
@property (nonatomic, assign) MTGridViewSeparateStyle separateStyle;
@property (nonatomic, assign) int firstOrLast; //1:first, 2:last
@end

@implementation TMGridCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.columnItems = [NSMutableArray arrayWithCapacity:1];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float xOffset = self.paddingInsets.left;
    
    for(MTGridViewItem *item in self.columnItems)
    {
        if(self.firstOrLast == 1)
            item.frame = CGRectMake(xOffset, self.paddingInsets.top, item.frameSize.width, item.frameSize.height);
        else
            item.frame = CGRectMake(xOffset, 0, item.frameSize.width, item.frameSize.height);
        xOffset += item.frame.size.width + self.colSpace;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    float xOffset = self.paddingInsets.left;
    for(MTGridViewItem *item in self.columnItems)
    {
        if(item != [self.columnItems lastObject])
        {
            xOffset += item.frame.size.width + self.colSpace / 2.0f;
            if(self.separateStyle == MTGridViewSeparateGrayLine)
            {
                CGContextMoveToPoint(ctx, xOffset, 0);
                CGContextAddLineToPoint(ctx, xOffset, item.frame.size.height);
            }
            else if(self.separateStyle == MTGridViewSeparateHalfLine)
            {
                CGContextMoveToPoint(ctx, xOffset, MIN(self.frame.size.height / 4.0f, 5.0f));
                CGContextAddLineToPoint(ctx, xOffset, MAX(self.frame.size.height / 2.0f, item.frame.size.height - 8.0f));
            }
            xOffset += self.colSpace / 2.0f;
        }
    }
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetLineWidth(ctx, MIN(0.5f, self.colSpace));
    CGContextSetShouldAntialias(ctx, NO);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithHexValue:0xc7c7c7].CGColor);
    CGContextStrokePath(ctx);
}

@end

@interface MTGridView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *columns;
@property (nonatomic, strong) NSMutableDictionary *frames;
@end

@implementation MTGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
        
        self.columns = [NSMutableArray arrayWithCapacity:1];
        self.frames = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return self;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    self.tableView.scrollEnabled = scrollEnabled;
}

- (BOOL)scrollEnabled
{
    return self.tableView.scrollEnabled;
}

- (void)setHeaderView:(UIView *)headerView
{
    self.tableView.tableHeaderView = headerView;
}

- (UIView *)headerView
{
    return self.tableView.tableHeaderView;
}

- (void)setFooterView:(UIView *)footerView
{
    self.tableView.tableFooterView = footerView;
}

- (UIView *)footerView
{
    return self.tableView.tableFooterView;
}

- (UITableView *)gridTabelView
{
    return self.tableView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView = nil;
}

#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowAtGridView:)])
        count = [self.dataSource numberOfRowAtGridView:self];
    
    [self.columns removeAllObjects];
    
    for(int i = 0; i < count; i++)
    {
        int colCount = 0;
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:numberOfColumnInRow:)])
            colCount = [self.dataSource gridView:self numberOfColumnInRow:i];
        
        [self.columns addObject:[NSNumber numberWithInt:colCount]];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float width = 0.0f, height = 0.0f, maxHeight = 0.0f;
    
    if(self.columns && self.columns.count > 0 && indexPath.row < self.columns.count && indexPath.row >= 0)
    {
        int colCount = [[self.columns objectAtIndex:indexPath.row] intValue];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
        for(int i = 0; i < colCount; i++)
        {
            if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:heightOfItemAtIndexPath:)])
                height = [self.dataSource gridView:self heightOfItemAtIndexPath:[NSIndexPath indexPathForColumn:i inRow:indexPath.row]];
            
            if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:widthOfItemAtIndexPath:)])
                width = [self.dataSource gridView:self widthOfItemAtIndexPath:[NSIndexPath indexPathForColumn:i inRow:indexPath.row]];
            
            maxHeight = MAX(maxHeight, height);
            [array addObject:[NSValue valueWithCGSize:CGSizeMake(width, height)]];
        }
        [self.frames setObject:array forKey:[NSString stringWithFormat:@"%lu", (long)indexPath.row]];
    }
    
    maxHeight += self.rowSpace;
    
    if(indexPath.row == 0)
    {
        return maxHeight > 0 ? maxHeight + self.paddingEdge.top : 45.0f + self.paddingEdge.top;
    }
    else if(indexPath.row == self.columns.count - 1)
    {
        return maxHeight > 0 ? maxHeight + self.paddingEdge.bottom : 45.0f + self.paddingEdge.bottom;
    }
    else
    {
        return maxHeight > 0 ? maxHeight : 45.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    TMGridCell *cell = (TMGridCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
        cell = [[TMGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.colSpace = self.columnSpace;
    cell.separateStyle = self.separateStyle;
    
    if(indexPath.row >= 0 && self.columns && self.columns.count > 0 && indexPath.row < self.columns.count)
    {
        cell.columnCount = [[self.columns objectAtIndex:indexPath.row] intValue];
        
        for(UIView *view in cell.columnItems)
        {
            if([cell.contentView.subviews containsObject:view])
                [view removeFromSuperview];
        }
        
        [cell.columnItems removeAllObjects];
        
        NSArray *array = [self.frames objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        
        for(int i = 0; i < cell.columnCount; i++)
        {
            MTGridViewItem *item = nil;
            if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:itemForColumnAtIndexPath:)])
                item = [self.dataSource gridView:self itemForColumnAtIndexPath:[NSIndexPath indexPathForColumn:i inRow:indexPath.row]];
            
            if(item)
            {
                item.indexPath = [NSIndexPath indexPathForColumn:i inRow:indexPath.row];
                if(array && array.count > 0 && i < array.count)
                {
                    item.frameSize = [[array objectAtIndex:i] CGSizeValue];
                }
                cell.paddingInsets = self.paddingEdge;
                [cell.contentView addSubview:item];
                [cell.columnItems addObject:item];
                
                [item addTarget:self action:@selector(gridViewDidSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        if(indexPath.row == 0)
        {
            cell.firstOrLast = 1;
        }
        else if(indexPath.row == self.columns.count - 1)
        {
            cell.firstOrLast = 2;
        }
        else
        {
            cell.firstOrLast = 0;
        }
        
        [cell setNeedsLayout];
    }
    
    return cell;
}

- (MTGridViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier atColIndex:(int)index
{
    TMGridCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell.columnItems && cell.columnItems.count > 0 && index >= 0 && index < cell.columnItems.count)
    {
        return [cell.columnItems objectAtIndex:index];
    }
    return nil;
}

- (void)reloadData
{
    [self.columns removeAllObjects];
    [self.frames removeAllObjects];
    [self.tableView reloadData];
}

- (void)gridViewDidSelectedItem:(MTGridViewItem *)item
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(gridView:didSelectedItemAtIndexPath:)])
        [self.delegate gridView:self didSelectedItemAtIndexPath:item.indexPath];
}

- (MTGridViewItem *)gridViewItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMGridCell *gridCell = (TMGridCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[indexPath rowIndex] inSection:0]];
    
    if(gridCell && gridCell.columnItems && gridCell.columnItems.count > 0 && indexPath.columnIndex < gridCell.columnItems.count)
    {
        return [gridCell.columnItems objectAtIndex:indexPath.columnIndex];
    }
    
    return nil;
}

@end
