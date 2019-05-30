//
//  ViewController.m
//  OpenGLES
//
//  Created by 王景伟 on 2019/5/29.
//  Copyright © 2019 王景伟. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface ViewController ()

@property (nonatomic, strong) EAGLContext *glContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpContext];
}

- (void)setUpContext {
    
    ///> 创建OpenGL上下文
    self.glContext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    ///> 设置上下文
    GLKView *glView = (GLKView *)self.view;
    glView.context = self.glContext;
    glView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.glContext];
    
    /*
     GLKViewDrawableColorFormatRGBA8888,
     GLKViewDrawableColorFormatRGB565,
     GLKViewDrawableColorFormatSRGBA8888,     
     */
}

@end
