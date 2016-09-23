

//
//  LuckPickViiew.m
//  RongWinLottery
//
//  Created by rykj-ios1 on 15/6/11.
//  Copyright (c) 2015年 rykj-ios1. All rights reserved.
//

#import "Lwt_PickView.h"

#define PickH 162
#define DatePicKH 216
#define ToolH 35



@interface Lwt_PickView ()
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) UIDatePicker *datePickView;
@property (nonatomic,strong) UIButton *sureBtn;
@end

@implementation Lwt_PickView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.userInteractionEnabled = NO;
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH,PickH+ToolH)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65,5,50,ToolH-10)];
        _sureBtn.layer.borderWidth = 1;
        _sureBtn.layer.cornerRadius = 3;
        [_sureBtn setTitle:@"确  定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_sureBtn];
        
        
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _pickView.frame = CGRectMake(0,ToolH, SCREEN_WIDTH, PickH);
        _pickView.dataSource = self;
        _pickView.delegate = self;
        _pickView.showsSelectionIndicator = YES;
        [_contentView addSubview:_pickView];
        
        
        _font = [UIFont systemFontOfSize:18];
        _textColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPickView)];
        [self addGestureRecognizer:tap];
        
        
    }
    
    return self;
}

- (void)setSureTintColor:(UIColor *)sureTintColor
{
    [_sureBtn setTitleColor:sureTintColor forState:UIControlStateNormal];
    _sureBtn.layer.borderColor = [sureTintColor CGColor];
}

- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    _pickView.backgroundColor = _backColor;
}

- (void)setSureFont:(UIFont *)sureFont
{
    _sureFont = sureFont;
    _sureBtn.titleLabel.font = _sureFont;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)showPickView
{
    self.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _contentView.frame = CGRectMake(0,SCREEN_HEIGHT-(_pickType != PickOther ? DatePicKH+ToolH:PickH+ToolH), SCREEN_WIDTH,_pickType != PickOther ? DatePicKH+ToolH:PickH+ToolH);
    } completion:^(BOOL isFinished){
        
    }];
}

-(void)hiddenPickView
{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        self.backgroundColor = [UIColor clearColor];
        _contentView.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH,_pickType != PickOther ? DatePicKH+ToolH:PickH+ToolH);
    } completion:^(BOOL isFinished){
        self.userInteractionEnabled = NO;
    }];
}


- (void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    [_pickView reloadAllComponents];
    
    for (int i = 0; i < dataArr.count; i ++)
    {
        [_pickView selectRow:0 inComponent:i animated:NO];
    }
}

- (void)setPickType:(PickType)pickType
{
    
    _pickType = pickType;
    _pickView.hidden = NO;
    _contentView.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH,PickH+ToolH);
    if (_pickType == PickOther)
    {
        if (_datePickView)
        {
            _datePickView.hidden =YES;
        }
        
        [_pickView reloadAllComponents];
        if (_dataArr.count > 0)
        {
            [_pickView selectRow:0 inComponent:0 animated:NO];
        }

    }else
    {
        _pickView.hidden = YES;
        _contentView.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH,DatePicKH+ToolH);
        if (_datePickView)
        {
            _datePickView.hidden = NO;
            
        }else
        {
            _datePickView = [[UIDatePicker alloc] initWithFrame: CGRectMake(0,ToolH, SCREEN_WIDTH, DatePicKH)];
            _datePickView.datePickerMode = _pickType-1;
            _datePickView.backgroundColor = RGBColor(246, 246, 246, 0.3);
            _datePickView.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
//            [_datePickView addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
            [_contentView addSubview:_datePickView];
            
            [self setCurrentDate];
        }

    }
    
    
}


//
- (void)didSelectData
{
    if (_pickType != PickOther)
    {
        
        [self chooseDate:_datePickView];
        
        
    }else
    {
        NSMutableArray *rowsArr = [[NSMutableArray alloc] init];
        NSMutableArray *titlesArr = [[NSMutableArray alloc] init];
        for (int i = 0; i <_dataArr.count;i ++)
        {
            [rowsArr addObject:[NSString stringWithFormat:@"%zd",[_pickView selectedRowInComponent:i]]];
            [titlesArr addObject:[[_dataArr objectAtIndex:i] objectAtIndex:[_pickView selectedRowInComponent:i]]];
        }
     
        if ([self.delegate respondsToSelector:@selector(pickViewdidSelectWithRows:titles:contentType:)])
        {
            [self.delegate pickViewdidSelectWithRows:rowsArr titles:titlesArr contentType:_contentType];
        }

    }

}


//选择时间
- (void)chooseDate:(UIDatePicker *)datePickView
{
    NSDate *setectDate = [datePickView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    switch (_pickType)
    {
        case PickDateTime_Date:[dateFormatter setDateFormat:@"yyyy-MM-dd"];break;
        case PickDateTime_Time:[dateFormatter setDateFormat:@"HH:mm:ss"];break;
        case PickDateTime_DateAndTime: [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];break;
        default:
            break;
    }
    NSString *dateStr = [dateFormatter stringFromDate:setectDate];
    
    
    if ([self.delegate respondsToSelector:@selector(pickViewdidSelectWithRows:titles:contentType:)])
    {
        [self.delegate pickViewdidSelectWithRows:@[@"0"] titles:@[dateStr] contentType:_contentType];
        
    }
    
    
   
}

- (void)setDatePickViewDate:(NSString *)str
{
    if (str.length < 10 || _pickView == nil)
    {
        return;
        
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:str];
    [_datePickView setDate:date animated:NO];
}



- (void)setCurrentDate
{
    if ( _pickView == nil)
    {
        return;
    }
    NSDate *  date=[NSDate date];
    [_datePickView setDate:date animated:NO];
}

- (void)sureBtnClick
{
    [self didSelectData];
    [self hiddenPickView];
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return _dataArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  [[_dataArr objectAtIndex:component] count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH/_dataArr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return PickH/5;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    [self didSelectData];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [[_dataArr objectAtIndex:component] objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = _font;
        pickerLabel.textColor = _textColor;
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



@end
