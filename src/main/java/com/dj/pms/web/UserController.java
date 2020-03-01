package com.dj.pms.web;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dj.pms.common.ResultModel;
import com.dj.pms.common.SystemConstant;
import com.dj.pms.opjo.User;
import com.dj.pms.opjo.UserRole;
import com.dj.pms.service.UserRoleService;
import com.dj.pms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @ProjectName: pms_hotel
 * @Package: com.dj.pms.web
 * @ClassName: UserController
 * @Author: Liuwf
 * @Description: 用户
 * @Date: 2020/2/29 12:11
 * @Version: 1.0
 */
@RestController
@RequestMapping("/user/")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserRoleService userRoleService;
    /**
     * @Description: 用户名去重
     * @Author: Liuwf
     * @Date:
     * @param userName:
     * @return: boolean
     **/
    @RequestMapping("findName")
    public boolean findName(String userName){
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("user_name",userName);
        User user = userService.getOne(userQueryWrapper);
        return user == null ? true : false;
    }
    /**
     * @Description:电话号码去重
     * @Author: Liuwf
     * @Date:
     * @param phone:
     * @return: boolean
     **/
    @RequestMapping("findPhone")
    public boolean findPhone(String phone){
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("phone",phone);
        User user = userService.getOne(userQueryWrapper);
        return user == null ? true : false;
    }
    /**
     * @Description: 注册
     * @Author: Liuwf
     * @Date:
     * @param user:
     * @return: com.dj.pms.common.ResultModel<java.lang.Object>
     **/
    @RequestMapping("insertUser")
    public ResultModel<Object> add(User user) {
        try {
            user.setRegisterTime(new Date());
            userService.save(user);
            UserRole userRole = new UserRole();
            userRole.setUserId(user.getId()).setRoleId(user.getUserRole()).setIsDel(SystemConstant.NOT_DELETE_IS_DEL);
            userRoleService.save(userRole);
            return new ResultModel<>().success();
        }catch (Exception e){
            e.printStackTrace();
            return new ResultModel<>().error(SystemConstant.EXCEPTION);
        }
    }
/**
 * @Description: 获取密码盐
 * @Author: Liuwf
 * @Date:
 * @param
 * @return: null
 **/
    @RequestMapping("getSalt")
    public ResultModel<Object> getSalt(String userName){
        try {
            QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
            userQueryWrapper.or(i -> i.eq("user_name",userName).or().eq("phone",userName));
            userQueryWrapper.eq("is_del",SystemConstant.NOT_DELETE_IS_DEL);
            User user = userService.getOne(userQueryWrapper);
            if (user == null) {
                return new ResultModel<>().error(SystemConstant.INPUT_ERROR);
            }
            ResultModel resultModel = new ResultModel().success(true);
            resultModel.setData(user.getSalt());
            return resultModel;
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(SystemConstant.EXCEPTION);
        }
    }
    /**
     * @Description:用户登录
     * @Author: Liuwf
     * @Date:
     * @param
     * @return: null
     **/
    @RequestMapping("login")
    public ResultModel<Object> login(String userName, String password, HttpSession session) {
        try {
            //判断不为空
            if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
                return new ResultModel<>().error(SystemConstant.NOT_NULL);
            }
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            //用户名/手机号/邮箱+密码登陆
            queryWrapper.or(i -> i.eq("user_name", userName)
                    .or().eq("phone", userName));
            queryWrapper.eq("password", password);
            User user = userService.getOne(queryWrapper);
            if (null == user){
                return new ResultModel<>().error(SystemConstant.NUMBER_PWD_ERROR);
            }
            return new ResultModel<>().success(user);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error(SystemConstant.EXCEPTION);
        }
    }


}
