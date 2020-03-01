package com.dj.pms.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dj.pms.mapper.UserMapper;
import com.dj.pms.opjo.User;
import com.dj.pms.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ProjectName: pms_hotel
 * @Package: com.dj.pms.service.impl
 * @ClassName: UserServiceImpl
 * @Author: Liuwf
 * @Description: 用户实现类
 * @Date: 2020/2/29 12:22
 * @Version: 1.0
 */
@Service
@Transactional(rollbackFor = Exception.class)//碰到异常做回滚
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {


}
