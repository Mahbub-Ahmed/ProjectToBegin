//
//  MATextField.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MATextField.h"
#import "MAConstants.h"

@interface MATextField (){
    //Insets
    CGPoint placeHolderInset,lineInset;
}
    //For storing defautl place holder value
    @property (strong ,nonatomic) NSString *placeholderText;
@end

@implementation MATextField

//Textfield size
CGFloat textFieldWidth,textFieldhHeight;

//initilizing setter and getter for inputText
@synthesize inputText;

Helper *helper;

- (void)drawRect:(CGRect)rect {

    //setting Textfield alpha
    self.alpha=.5;
    
    //Add PlaceHolder as subView
    [self addPlaceHolder];
    
    //Draw Line
    [self drawLine];
    
    //add Error Label
    [self addErrorLabel];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.delegate = self;
    if (self) {
        //textfield size
        textFieldWidth=self.frame.size.width;
        textFieldhHeight=self.frame.size.height;
        
        //Setting Inset
        placeHolderInset = CGPointMake(textFieldIconSize+20,(textFieldhHeight/2)-16);
        lineInset=CGPointMake(0,textFieldhHeight-20);
        
        //setting placeholder property
        self.placeHolder = [[UILabel alloc] init];
        self.placeHolder.textColor = [UIColor blackColor];
        self.placeHolder.backgroundColor=[UIColor clearColor];
        self.placeHolder.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        self.placeHolder.textAlignment = NSTextAlignmentLeft;

        //setting Error message   property
        self.errorLabel = [[UILabel alloc] init];
        self.errorLabel.textColor = [UIColor colorWithRed:1 green:0.4 blue:0 alpha:1];
        self.errorLabel.backgroundColor=[UIColor clearColor];
        self.errorLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
        self.errorLabel.textAlignment = NSTextAlignmentRight;
        
        self.backgroundColor=[UIColor clearColor];
        
    }
    
    return self;
}



//Chagne text edit position same as placeholder left position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect textInset = CGRectMake(placeHolderInset.x, bounds.origin.y, bounds.size.width - placeHolderInset.x, bounds.size.height);
    return textInset;
}
// keep the text position same after edit end
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textInset = CGRectMake(placeHolderInset.x, bounds.origin.y, bounds.size.width - placeHolderInset.x, bounds.size.height);
    return textInset;
}


//Drawing a line
-(void)drawLine{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = .7;
    border.borderColor = [UIColor darkGrayColor].CGColor;
    border.frame = CGRectMake(lineInset.x, lineInset.y,self.frame.size.width, .7);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}

//Seting TextField LeftView Icon
-(void)setTextFieldIcon:(NSString*) imageName{
    
    [self setLeftViewMode:UITextFieldViewModeAlways];
    UIImage *image=[UIImage imageNamed:imageName];
    
    image=[Helper resizeImageByWidth:image width:textFieldIconSize];
    self.leftView=[[UIImageView alloc] initWithImage:image];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

//Setting error message
-(void)setErrorMessage:(NSString *)message{
    _errorLabel.text=message;
}

//Setting placeHolder
-(void)setPlaceHolderLabel:(NSString*) labelText{
    self.placeHolder.text = labelText;
    _placeholderText=labelText;
}

//adding Place Holder
- (void)addPlaceHolder{
    self.placeHolder.frame=CGRectMake(placeHolderInset.x, placeHolderInset.y, 150, 30);
    [self addSubview:self.placeHolder];
}

//Adding error label as a subview of text field
- (void)addErrorLabel
{
    //Setting error label position
    self.errorLabel.frame=CGRectMake(placeHolderInset.x, lineInset.y+1, textFieldWidth-placeHolderInset.x, 20);
    [self.errorLabel setText:@""];
    [self.errorLabel setTextColor:[UIColor redColor]];
    
    [self addSubview:self.errorLabel];
    
}

#pragma mark -textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.placeHolder.text=@"";
    _errorLabel.text=@"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    //Resetting place holder and error label
    if([textField.text isEqual:@""]){
        self.placeHolder.text=_placeholderText;
        self.errorLabel.text=@"";
        return;
    }
    [textField resignFirstResponder];
    self.inputText=textField.text;
}

@end
