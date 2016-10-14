# RouterDemo

[RouterDemo](https://github.com/kaka2928/RouterDemo) 是一个iOS业务路由的例子，核心代码包括路由[CCRouter](https://github.com/kaka2928/RouterDemo/tree/master/RouterDemo/router)、事务基类和例子事务[businesses](https://github.com/kaka2928/RouterDemo/tree/master/RouterDemo/businesses);

```console
	事务设计规范：
	1.Business_matrix类 
	1.1 businessNotFound、actionNotFound  分别实现对无效事务、无效操作的路由；
	1.2 paramCheckWith:params:completion  对接口中需要解析参数进行有效性检查；
	1.3 Action_remoteCallBack  第三方App交互中，执行 [AppDelegate openURL:]中对应App的回调；子事务中需要执行第三方App回调时，子类中需要重写该方法；

	
```
