package com.dj.pms;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@MapperScan("com.dj.pms.mapper")
@EnableTransactionManagement
public class PmsHotelApplication {

    public static void main(String[] args) {
        SpringApplication.run(PmsHotelApplication.class, args);
    }

}
