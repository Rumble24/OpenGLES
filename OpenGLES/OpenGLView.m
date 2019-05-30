//
//  OpenGLView.m
//  OpenGLES
//
//  Created by 王景伟 on 2019/5/29.
//  Copyright © 2019 王景伟. All rights reserved.
//

#import "OpenGLView.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface OpenGLView (){
    
    EAGLContext *_eaglContext;
    CAEAGLLayer *_eaglLayer;
    GLuint _colorBufferRender;
    GLuint _frameBuffer;
    GLuint _glProgram;
    GLuint _positionSlot;
    GLuint _textureSlot;
    GLuint _textureCoordsSlot;
    GLuint _textureID;
    CGRect _frameCAEAGLLayer;
    
}

@end

@implementation OpenGLView

+ (Class)layerClass{
    return [CAEAGLLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    ///> 你可以在初始化EAGLContext时指定ES版本号
    _eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    
    ///> 初始化完之后，我们需要对layer层进行一些处理，设置一些属性，使其能够使用openGL
    _eaglLayer = (CAEAGLLayer*)self.layer;
    _eaglLayer.frame = self.frame;
    _eaglLayer.opaque = YES;
    _eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
    
    ///> 初始化完成Layer之后，我们需要初始化一下renderBuffer和FrameBuffer
    glGenRenderbuffers(1, &_colorBufferRender);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorBufferRender);
    [_eaglContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
    
    
    
    
    ///> 要设置当前上下文，你可以通过调用EAGLContext类的setCurrentContext:方法
    [EAGLContext setCurrentContext:_eaglContext];
    
    
    
    
    
    
    
    glGenFramebuffers(1, &_frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER,
                              GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER,
                              _colorBufferRender);
    
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    [_eaglContext presentRenderbuffer:GL_RENDERBUFFER];
    return self;
}

@end
