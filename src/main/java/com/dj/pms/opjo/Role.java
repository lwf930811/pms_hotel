package com.dj.pms.opjo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.sun.mail.imap.protocol.ID;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @ProjectName: pms_hotel
 * @Package: com.dj.pms.opjo
 * @ClassName: Role
 * @Author: Liuwf
 * @Descrtription: 酒店角色
 * @Date: 2020/3/1 8:38
 * @Version: 1.0
 */
@Data
@Accessors(chain = true)
@TableName("hotel_role")
public class Role {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String roleName;
    private Integer isDel;

}
