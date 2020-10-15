<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2014 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用入口文件

// 检测PHP环境
if(version_compare(PHP_VERSION,'5.3.0','<'))  die('require PHP > 5.3.0 !');

// 开启调试模式 建议开发阶段开启 部署阶段注释或者设为false
define('APP_DEBUG', true);

// 定义应用目录
define('DS', DIRECTORY_SEPARATOR);
define('ROOT_PATH', str_replace('\\','/',dirname(__FILE__)));
define('APP_PATH', ROOT_PATH . '/app/');
define('APP_PATH_ADMIN', ROOT_PATH . '/app/Admin/');
define('APP_PATH_ADMIN_VIEW', ROOT_PATH . '/app/Admin/View/');
define('APP_CONFIG_PATH', ROOT_PATH . '/app/Admin/Conf/');
define('APP_CONFIG_PUB', ROOT_PATH . '/public');
define('APP_CONFIG_TP', ROOT_PATH . '/ThinkPHP/Library');
define('_PHP_FILE_', $_SERVER['SCRIPT_NAME']);

require ROOT_PATH . '/ThinkPHP/ThinkPHP.php';