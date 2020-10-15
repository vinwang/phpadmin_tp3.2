<?php
return array(
	//'配置项'=>'配置值'
    'TMPL_PARSE_STRING'  =>array(
        '__PUBLIC__' => '/public/asset', // 更改默认的/Public 替换规则
    ),
    'TMPL_ACTION_ERROR'     =>  APP_PATH_ADMIN_VIEW.'tips.html', // 默认错误跳转对应的模板文件
    'TMPL_ACTION_SUCCESS'   =>  APP_PATH_ADMIN_VIEW.'tips.html', // 默认成功跳转对应的模板文件
    'TOKEN_ON'      =>    true,  // 是否开启令牌验证 默认关闭
    'TOKEN_NAME'    =>    '__hash__',    // 令牌验证的表单隐藏字段名称，默认为__hash__
    'TOKEN_TYPE'    =>    'md5',  //令牌哈希验证规则 默认为MD5
    'TOKEN_RESET'   =>    true,  //令牌验证出错后是否重置令牌 默认为true
    'LOAD_EXT_FILE' => 'custom',
    'LOAD_EXT_CONFIG' => 'idc,menu,logcode',
    'LAYOUT_ON'=>true,
    'LAYOUT_NAME'=>'layout',
    'AUTH_CONFIG' => [ //权限控制
        'AUTH_ON'           => true,                // 认证开关
        'AUTH_TYPE'         => 1,                   // 认证方式，1为实时认证；2为登录认证。
        'AUTH_GROUP'        => 'sys_auth',        // 用户组数据表名
        'AUTH_GROUP_ACCESS' => 'auth_group_access', // 用户-用户组关系表
        'AUTH_RULE'         => 'auth_rule',         // 权限规则表
        'AUTH_USER'         => 'sys_users'             // 用户信息表
    ],
    'SESSION_OPTIONS' => ['expire'=>10800], //session3个小时有效期
    //redis 配置
    'REDIS_HOST' => 'redis',
    'REDIS_PWD' => NULL,
    'REDIS_PORT' => 6379,
    'REDIS_TIMEOUT' => 0,
);  