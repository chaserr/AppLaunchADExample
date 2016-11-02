# # AppLaunchADExample

##缓存逻辑
1.  为了防止网络延迟加载图片过慢，用户第一次启动app的时候不显示广告
2.  把广告页从服务器加载完成后缓存在本地和内存中
3.  而后每次  启动图片的时候去本地或者缓存中查找， 如果找到了那么直接显示图片， 如果没找到执行第三步
4.  默认先显示系统的LaunchImage,然后执行第二步

##UI逻辑
1.  去掉main.storyBoard和Launch.storyboard，添加自定义的LaunchImage
2.  将window可见，然后在window上覆盖一层imageView,用来展示广告页
3.  如果需要跳转，点击广告页，使用根导航控制器push广告加载页


##使用的第三方
- 使用cocoaPod导入王巍（喵神）的作品`Kingfisher`
- 采用本地缓存加内存缓存机制，来确保启动页广告图片的快速加载 
- 使用`Kingfisher`的时候，注意自己缓存的路径和查找的路径一定要保持一致，Kingfisher的缓存图片默认是路径是default，

【注】：

1. 使用该种模式，不能启用main.storyBoard

2. 不能使用 LaunchScreen.storyBoard

3. 必须要有启动图

![LaunchAdsImage](http://upload-images.jianshu.io/upload_images/1128807-480cba5f068469d1.gif?imageMogr2/auto-orient/strip)
