# lua_cjson

1、当前遇到的问题
lua对于number处理的类型内置为double  ，lua_cjson对于number类型处理也是double
这样当json报文的数值型超过14位以后，解析出来的值就会变成科学计数法

2、针对这个问题，自己对lua_cjson代码进行了修改，可以支持到19位的数值型。

注：缺点不支持本身是科学计数法的取值。
