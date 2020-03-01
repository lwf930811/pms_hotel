package com.dj.pms.opjo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @ProjectName: pms_hotel
 * @Package: com.dj.pms.opjo
 * @ClassName: UserRole
 * @Author: Liuwf
 * @Description: 用户角色关联
 * @Date: 2020/3/1 11:11
 * @Version: 1.0
 */
@Data
@Accessors(chain = true)
@TableName("hotel_user_role")
public class UserRole {
    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 角色id
     */
    private Integer roleId;

    /**
     * 是否删除 1正常 0删除
     */
    private Integer isDel;

}
