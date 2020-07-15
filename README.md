# DeWebSDK

#### 介绍
DeWeb是一个可以直接将Delphi程序快速转换为网页应用的工具！
使用DeWeb, 开发者不需要学习HTML、JavaScript、Java、PHP、ASP、C#等新知识，用Delphi搞定一切。 
DeWeb开发的网页支持所有客户端，包括手机、平板等。

本程序只提供DeWeb的开发包, 用于帮助感兴趣的朋友了解DeWeb的开发进度 

#### 使用说明

DeWeb是一个可以直接将Delphi程序快速转换为网页应用的工具！

使用DeWeb, 开发者不需要学习HTML、JavaScript、Java、PHP、ASP、C#等新知识，
用Delphi搞定一切。 

DeWeb开发的网页支持所有客户端，包括手机、平板等。 

1 复制dcu
  根据Delphi的版本, 复制10.1/10.2/10.3/10.4目录内的文件到当前目录

2 编译
  打开DelphiWeb.dproj, 编译,运行

3 在浏览器中打开,应该可以看到效果
  http://127.0.0.1:8080/

4 新建页面
  (1) 新建一个Form, 比如文件保存为unit9.pas, 窗体Name = TForm9
  (2) 在Form9上放一个Label, Caption = "Hello,World!"
  (3) 在Main.pas中uses中添加unit9,
  (4) 在Main.pas的最后
      在initialization中添加
          RegisterClass(TForm9);
      在finalization中添加
          UnRegisterClass(TForm9);

5 重新编译DelphiWeb.dproj

6 在浏览器中打开,应该可以看到效果
  http://127.0.0.1:8080/form9.dw



#### 开发者

碧树西风
-
资深Delphi开发者
QQ:4530 0355
mail:fenglinyushu@163.com

