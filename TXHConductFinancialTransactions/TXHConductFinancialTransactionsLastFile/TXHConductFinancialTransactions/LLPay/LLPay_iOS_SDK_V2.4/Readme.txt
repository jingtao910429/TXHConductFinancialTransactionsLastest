IOS接入指南
下面是基本的接入指南：
1. 导入文件
2. 添加头文件引用
3. 设置link标志
Target->Build Setting ，Other Linker Flags 设置为 -all_load
可能添加-all_load以后和其他库冲突，可以尝试使用 -force_load 单独load库, force_load后面跟的是 lib库的完整路径
-force_load $(SRCROOT)/***/libPaySdkColor.a (****需要按照你的库放置的路径决定)

4. 调用sdk显示，注意retain，自动释放以后，调用后会崩溃
self.sdk = [[[LLPaySdk alloc] init] autorealse]; // 创建
self.sdk.sdkDelegate = self;  // 设置回调
NSDictionary* signedDic = [payUtil signedOrderDic:orderParam andSignKey:md5key_or_rsakey] // 加过签名的订单字典
[self.sdk presentPaySdkInViewController:rootVC withTraderInfo:signedDic];

5. 编写结果回调
// 订单支付结果返回，主要是异常和成功的不同状态
- (void)paymentEnd:(LLWalletPayResult)resultCode withResultDic:(NSDictionary *)dic


SDK可配置部分

iOS SDK可以通过修改资源bundle进行定制， 因为是在bundle里面，请在修改好以后clean proj，这样才会生效。

1、图片的替换，在内部的图片可以替换修改位自己的样式
2、颜色等的修改，可以修改default.css文件，支持#abcdef，123,123,123两种颜色表示
3、修改值意义列表

导航栏颜色：替换shoushi3.png文件，以及修改css文件中NavBar字段（后面只表示字段，都是在default.css文件中）中的background-color
导航栏标题：NavBar字段中的titleIconName; titleText
确认按钮：#a-button
取消按钮：#b-button
文本框：UITextField
弹出对话框的确认字体颜色: #TX-3


参数字段部分
参数说明在demo中有，可以参考。字段名和wap不一致，请参考demo中的参数说明，参数中的user_id 不是商户号，是商户自己体系中的用户编号，前置卡输入时，no_agree是通过API查询得到的绑卡序号
  
使用部分
Demo中的输入项，是用来测试各种支付条件，包括认证支付（输入姓名，身份证），前置支付（输入卡号，协议号）。不是必须，请根据自己的支付方式测试。
支持银行数量，是根据支付类型以及商户来，可以配置，请联系运营。
支付的验密方式（短信，手势码，支付密码）需要通过我们的服务器人员配置的，请联系相关服务器对接人员。


常见问题

签名请尽量使用服务器端签名，假如使用客户端签名，请使用Demo中的payutil

1、运行直接崩溃

	答：1、sdk没有retain保管。
		2、sdk中使用了类扩展，请在other link flag中添加 -all_load

2、提示初始化错误

	答：1、检查环境和商户号等是否匹配；2、检查签名方法是否正确（参考签名工具）；3、订单信息是否有遗漏项；


3、初始化常见错误提示，解释，以及应对方法

	1、所传的类型不是NSString
		解释：连连的订单需要传入的订单格式为{“strkey”: “strvalue”, “strkey1″ : “strvalue2“}，请不要传递 {“key”: [v1, v2]} 或者 {“key”: {“ikey”:”v”}} 这种
		应对，修改订单内值的格式，特别是risk_item，需要变成 {“risk_item”:”{\”r_key\”:\”v\”}”}这样

	2、商户无此支付产品权限

		解释：我们的产品分为认证支付、快捷支付等多种支付方式。一种支付方式对应的包、支付调用方法、商户号都有所不同。
		应对：先检查商户号是否是正确的商户号，比如   <认证支付测试商户号  201408071000001543>  <快捷支付测试商户号  201408071000001546>
		然后检查所对应的包或者调用方法对不对。在iOS中，已经提取了专门的调用方法。
		// 快捷支付
		- (void)presentQuickPaySdkInViewController:(UIViewController*)viewController withTraderInfo:(NSDictionary*)traderInfo;
		// 认证支付
		- (void)presentVerifyPaySdkInViewController:(UIViewController*)viewController withTraderInfo:(NSDictionary*)traderInfo;

	3、商户无此支付权限
		解释：一个商户号对应的商品业务类型是有限的。
		应对：修改  商户业务类型 busi_partner 是 String(6) 虚拟商品销售：101001
 		实物商品销售：109001
 		外部账户充值：108001

	4、签名验证不对
		解释：签名有特定规则，订单里面的特定参数参与签名。
		应对：ios最新的Demo中提供了payUtil函数，直接调用，就能生成签名正确的订单。然后再次提醒，我们墙裂建议商户在服务器端完成签名操作。


