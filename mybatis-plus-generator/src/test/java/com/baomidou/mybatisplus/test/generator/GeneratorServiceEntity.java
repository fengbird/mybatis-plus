package com.baomidou.mybatisplus.test.generator;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import org.junit.Test;

/**
 * Created by jobob on 17/5/16.
 */
public class GeneratorServiceEntity {

    @Test
    public void generateCode() {
        String packageName = "com.baomidou.springboot";
        boolean serviceNameStartWithI = true;//user -> UserService, 设置成true: user -> IUserService
        generateByTables(serviceNameStartWithI, packageName, "user");
    }

    private void generateByTables(boolean serviceNameStartWithI, String packageName, String... tableNames) {
        GlobalConfig config = new GlobalConfig();
        config.setSwagger2(false)//开启swagger2日志打印
            .setBaseResultMap(false)//mybatis的xml文件包含BaseResultMap
            .setEnableExport(false)//开启Excel导出功能
            .setEnableSave(false)//开启保存功能
            .setEnableDelete(false)//开启删除功能
            .setEnableImport(false)//开启导入功能
            .setEnableShiro(false)//开启shiro权限控制
            .setEnableSysLog(false)//开启用户操作日志记录
            .setEnableMultiplyTables(false)//开启多表关联查询
            .setEnableSingleTable(false) //开启单表查询,与上面的多表关联二选一
        ;
        String dbUrl = "jdbc:mysql://localhost:3306/mybatis-plus";
        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        dataSourceConfig.setDbType(DbType.MYSQL)
                .setUrl(dbUrl)
                .setUsername("root")
                .setPassword("toor")
                .setDriverName("com.mysql.jdbc.Driver");
        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig
            .setCapitalMode(true)
            .setNaming(NamingStrategy.underline_to_camel)
            .setRestControllerStyle(true)
            .setSuperControllerClass("org.ice.jee.commons.core.base.BaseController")
            .setInclude(tableNames);//修改替换成你需要的表名，多个表名传数组
        config.setActiveRecord(false)
                .setAuthor("zhaotengchao")
                .setOutputDir("d:\\hahaha")
                .setFileOverride(true);
        if (!serviceNameStartWithI) {
            config.setServiceName("%sService");
        }

        // 包配置
        PackageConfig pc = new PackageConfig();
        pc.setParent("org.vz.finance.integration");
        pc.setEntity("model");
        pc.setMapper("common.mapper");
        pc.setXml("common.mappers.xml");
        pc.setServiceImpl("common.service.impl");
        pc.setService("common.service");
        pc.setController("common.controller");

        new AutoGenerator().setGlobalConfig(config)
                .setDataSource(dataSourceConfig)
                .setStrategy(strategyConfig)
                .setPackageInfo(
                        new PackageConfig()
                            .setParent(packageName)
                            .setController("controller")
                            .setEntity("entity")
                ).setTemplateEngine(new FreemarkerTemplateEngine())
                .setTemplate(
                    new TemplateConfig()
                        .setController("myTemplates/controller.java")
                        .setProvider("myTemplates/provider.java")
                        .setProviderImpl("myTemplates/providerImpl.java")
                        .setService("myTemplates/service.java")
                        .setServiceImpl("myTemplates/serviceImpl.java")
                        .setMapper("myTemplates/mapper.java")
                        .setXml("myTemplates/mapper.xml")
                        .setEntity("myTemplates/entity.java")
                        .setReq("myTemplates/req.java")
                        .setResp("myTemplates/resp.java")
                ).execute();
    }

    private void generateByTables(String packageName, String... tableNames) {
        generateByTables(true, packageName, tableNames);
    }
}
