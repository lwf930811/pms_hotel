package com.dj.pms.common;

public interface SystemConstant {

	/**
	 * 1：未删除
	 */
	 Integer NOT_DELETE_IS_DEL = 1;

	/**
	 * 2：删除
	 */
	 Integer DELETE_IS_DEL = 2;

	/**
	 * 分页2
	 */
	 Integer PAGE_SIZE = 2;

	/**
	 * 输入不能为空
	 */
	 String NOT_NULL = "输入不能为空";

	/**
	 * 服务器异常
	 */
	 String EXCEPTION = "服务器异常";

	/**
	 * 账号或密码错误
	 */
	 String NUMBER_PWD_ERROR = "账号或密码错误";
	
	/**
	 * 该邮箱已注册
	 */
	 String EMAIL_ERROR = "该邮箱已注册";

	/**
	 * 该电话号已注册
	 */
	 String PHONE_ERROR = "该电话号已注册";

	/**
	 * 该用户名已注册
	 */
	 String NAME_ERROR = "该用户名已注册";
	
	/**
	 * 输入有误
	 */
	 String INPUT_ERROR = "输入有误";

	/**
	 * 激活
	 */
	 Integer ACTIVATE_STATUS = 2;

	
	/**
	 * 该验证码以失效，请重新获取
	 */
	 String TIME_OUT = "该验证码以失效，请重新获取";
	/**
	 * 激活邮件主题
	 */
	 String  ACTIVATE= "验证邮箱激活";

	/**
	 * 注册成功！我们已经发送了一封邮件到您的邮箱，请点击邮箱中的链接来激活您的账户！
	 */
	 String EMAIL = "注册成功！我们已经发送了一封邮件到您的邮箱，请点击邮箱中的链接来激活您的账户！";
	/**
	 * @Description:父级pid -1
	 * @Author: Liuwf
	 * @Date:
	 * @param null:
	 * @return: null
	 **/
	 Integer PARENT_ID = 1;
	/**
	 * @Description:parentId=1
	 * @Author: Liuwf
	 * @Date:
	 * @param null:
	 * @return: null
	 **/
	 String PARENT_NAME  = "-";
	 /**
	  * @Description:用户session USER_SESSION
	  * @Author: Liuwf
	  * @Date:
	  * @param null:
	  * @return: null
	  **/
	String USER_SESSION = "USER_SESSION";
	/**
	 * @Description:用户资源USER_RESOURCE
	 * @Author: Liuwf
	 * @Date:
	 * @param null:
	 * @return: null
	 **/
	String  USER_RESOURCE = "USER_RESOURCE";
	/**
	 * @Description:用户名不存在
	 * @Author: Liuwf
	 * @Date:
	 * @param null:
	 * @return: null
	 **/
	String NULL_USERNAME  = "用户名不存在";

}
