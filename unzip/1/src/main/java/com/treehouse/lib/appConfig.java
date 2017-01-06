package com.treehouse.lib;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.security.auth.login.AppConfigurationEntry;

/**
 * Created by admin on 2016-12-27.
 */
@Configuration
@EnableAutoConfiguration
@ComponentScan
public class appConfig {
    public static void main(String[] args){
        SpringApplication.run(appConfig.class, args);
        System.out.println("Spring Boot Started.");
    }
}
