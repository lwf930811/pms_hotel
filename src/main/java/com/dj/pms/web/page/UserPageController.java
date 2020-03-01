package com.dj.pms.web.page;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.dj.pms.common.SystemConstant;
import com.dj.pms.opjo.BaseData;
import com.dj.pms.opjo.Role;
import com.dj.pms.service.BaseDataService;
import com.dj.pms.service.RoleService;
import com.dj.pms.service.UserService;
import com.dj.pms.utils.PasswordSecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @ProjectName: pms
 * @Package: com.dj.pms.web.page
 * @ClassName: UserPageController
 * @Author: Liuwf
 * @Description:
 * @Date: 2020/1/29 21:40
 * @Version: 1.0
 */
@Controller
@RequestMapping("/user/")
public class UserPageController {
     @Autowired
    private UserService userService;
     @Autowired
     private BaseDataService baseDataService;
     @Autowired
     private RoleService roleService;
/**
 * @Description: 登录
 * @Author: Liuwf
 * @Date:

 * @return: java.lang.String
 **/
    @RequestMapping("toLogin")
    public String toLogin(){

        return "user/login";
    }
/**
 * @Description: 用户注册
 * @Author: Liuwf
 * @Date:
 * @param model:
 * @return: java.lang.String
 **/
    @RequestMapping("toRegister")
    public String toRegister(Model model){
        try {
            QueryWrapper<BaseData> baseDataQueryWrapper = new QueryWrapper<>();
            baseDataQueryWrapper.eq("parent_id",SystemConstant.PARENT_ID);
            baseDataQueryWrapper.eq("is_del",SystemConstant.NOT_DELETE_IS_DEL);
            List<BaseData> baseDataList = baseDataService.list(baseDataQueryWrapper);
            model.addAttribute("baseData",baseDataList);
            String salt = PasswordSecurityUtil.generateSalt();
            model.addAttribute("salt",salt);
            QueryWrapper<Role> roleQueryWrapper = new QueryWrapper<>();
            roleQueryWrapper.eq("is_del",SystemConstant.NOT_DELETE_IS_DEL);
            List<Role> roleList = roleService.list(roleQueryWrapper);
            model.addAttribute("role",roleList);
            return "user/register";
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }



}
