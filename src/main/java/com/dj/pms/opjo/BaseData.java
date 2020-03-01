package com.dj.pms.opjo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @ProjectName: pms_hotel
 * @Package: com.dj.pms.opjo
 * @ClassName: BaseData
 * @Author: Liuwf
 * @Description: 基础数据表
 * @Date: 2020/2/29 12:55
 * @Version: 1.0
 */
@Data
@Accessors(chain = true)
@TableName("hotel_base_data")
public class BaseData {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer parentId;
    private String name;
    private Integer isDel;


}
