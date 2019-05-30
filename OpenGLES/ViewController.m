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
///> 着色器
@property (nonatomic , strong) GLKBaseEffect* mEffect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpContext];
    
    [self uploadVerTexArray];
    
    [self uploadTexture];
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
     颜色缓存的格式
     GLKViewDrawableColorFormatRGBA8888,   4 * 8 = 32位 也就是一个像素占有8个字节
     GLKViewDrawableColorFormatRGB565,
     GLKViewDrawableColorFormatSRGBA8888,     
     */
}

- (void)uploadVerTexArray {
    ///> C语言数组 ，前三个是顶点坐标（x、y、z轴），后面两个是纹理坐标（x，y）
    GLfloat vertex[] =
    {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    
    
    GLuint buffer;
    ///> 申请一个标识符
    glGenBuffers(1, &buffer);
    ///> 把标识符绑定到 GL_ARRAY_BUFFER上
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    ///> 把顶点数据从cpu内存复制到gpu内存
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertex), vertex, GL_STATIC_DRAW);
    
    ///> 开启对应的顶点属性
    glEnableVertexAttribArray(GLKVertexAttribPosition); //>顶点数据缓存
    ///> 设置合适的格式x从buffer中读取数据
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT * 5), (GLfloat *)NULL + 0);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); ///> 纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2,GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT * 5), (GLfloat *)NULL + 3);
}

- (void)uploadTexture {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1),GLKTextureLoaderOriginBottomLeft, nil];
    
    ///> 创建图片 读取纹理
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:nil];
    
    ///> 把纹理赋值给着色器
    self.mEffect = GLKBaseEffect.new;
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = info.name;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3, 0.6, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    ///> 启动着色器
    [self.mEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

@end
