# DeWebSDK

#### 介绍
DeWeb是一个可以直接将Delphi程序快速转换为网页应用的工具！
使用DeWeb, 开发者不需要学习HTML、JavaScript、Java、PHP、ASP、C#等新知识，用Delphi搞定一切。 
DeWeb开发的网页支持所有客户端，包括手机、平板等。

<br/>
Hello,World<br/>
[http://web0000.com](http://web0000.com)<br/>
综合演示<br/>
[http://web0000.com/demos.dw](http://web0000.com/demos.dw)<br/>
驾校科目一测试系统<br/>
[http://www.web0000.com/driver.dw](http://www.web0000.com/driver.dw)<br/>

本程序只提供DeWeb的开发包, 用于帮助感兴趣的朋友了解DeWeb的开发进度 

#### 使用说明

<br/>
DeWeb是一个可以直接将Delphi程序快速转换为网页应用的工具！

使用DeWeb, 开发者不需要学习HTML、JavaScript、Java、PHP、ASP、C#等新知识，
用Delphi搞定一切。 

DeWeb开发的网页支持所有客户端，包括手机、平板等。 

1 复制dcu
  目前采用D10.4开发, 如果你使用D10.4,直接下载编译即可.
  如果不是,可以根据Delphi的版本, 复制10.1/10.2/10.3/10.4目录内的文件到当前目录

2 编译支持控件
  打开Source\dwVcls目录中的所有dpr, Build即可

3 编译打开DelphiWeb
  打开DelphiWeb.dproj, 编译,运行

4 在浏览器中打开,应该可以看到效果
  http://127.0.0.1/

5 新建页面
  (1) 新建一个Form, 比如文件保存为unit9.pas, 窗体Name = TForm9
  (2) 在Form9上放一个Label, Caption = "Hello,World!"
  (3) 在Main.pas中uses中添加unit9,
  (4) 在Main.pas的最后
      在initialization中添加
          RegisterClass(TForm9);
      在finalization中添加
          UnRegisterClass(TForm9);

6 重新编译DelphiWeb.dproj

7 在浏览器中打开,应该可以看到效果
  http://127.0.0.1/form9.dw



#### 开发者

碧树西风
<br/>
-
<br/>
资深Delphi开发者
<br/>
讨论群:120283369
<br/>
mail:fenglinyushu@163.com

