package com.dj.pms.opjo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.experimental.Accessors;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @ProjectName: pms
 * @Package: com.dj.pms.pojo
 * @ClassName: User
 * @Author: Liuwf
 * @Description:
 * @Date: 2020/1/29 21:01
 * @Version: 1.0
 */
@Data
@Accessors(chain = true)
@TableName("hotel_user")
public class User {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String userName;
    private String password;
    private String salt;
    private String  phone;
    private String hotelName;
    private Integer hotelType;
    private Integer userRole;
    private String hotelAddress;
    @JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8")
    private Date registerTime;
    @JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8")
    private Integer isDel;

}
