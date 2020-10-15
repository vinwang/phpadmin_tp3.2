CREATE TABLE IF NOT EXISTS `sys_conf` (
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置表';

DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `model` smallint(6) NOT NULL DEFAULT '0' COMMENT '操作',
  `logdes` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `logcmd` varchar(255) NOT NULL DEFAULT '',
  `uid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `urid` tinyint(2) NOT NULL DEFAULT '2' COMMENT '角色id',
  `uname` char(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `ulogipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作IP（ipv4）',
  `ulogipv6` char(32) NOT NULL DEFAULT '' COMMENT '操作IP（ipv6）',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统日志表';

DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '控制器方法',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '主菜单分类',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `condition` varchar(100) NOT NULL DEFAULT '' COMMENT '规则附件条件,满足附加条件的规则,才认为是有效的规则',
  `icon` varchar(60) NOT NULL DEFAULT '' COMMENT '图标',
  `pid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '关联id',
  `sort` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned zerofill DEFAULT '00000000000',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

INSERT INTO `auth_rule` (`id`, `name`, `title`, `type`, `status`, `condition`, `icon`, `pid`, `sort`, `create_time`) VALUES
  (1, 'Index/index', '控制台首页', 1, 1, '', 'fa fa-dashboard', 0, 0, 01597385492),
  (28, '', '账号管理', 1, 1, '', 'fa fa-calendar-o', 0, 0, 01597387651),
  (29, 'User/index', '账号列表', 1, 1, '', '', 28, 0, 01597387667),
  (30, 'Auth/index', '角色管理', 1, 1, '', '', 28, 0, 01597387684),
  (31, '', '系统管理', 1, 1, '', 'fa fa-cog', 0, 0, 01597387699),
  (32, 'Sysconf/setconf', '基础参数', 1, 1, '', '', 31, 0, 01597387737),
  (35, 'Sysconf/time', '系统时间', 1, 1, '', '', 31, 0, 01597387784),
  (38, '', '系统日志', 1, 1, '', 'fa fa-file-text-o', 0, 0, 01597387836),
  (39, 'Sysconf/log', '用户操作日志', 1, 1, '', '', 38, 0, 01597387855),
  (50, 'Auth/delete', '删除角色', 1, 0, '', '', 30, 0, 01602727377),
  (49, 'Auth/add', '编辑角色', 1, 0, '', '', 30, 0, 01602725674),
  (48, 'User/delete', '删除用户', 1, 0, '', '', 29, 0, 01602725589),
  (47, 'User/update', '编辑用户', 1, 0, '', '', 29, 0, 01602725357),
  (46, 'User/add', '新增用户', 1, 0, '', '', 29, 0, 01602669767),
  (45, 'Sysconf/backup', '备份还原', 1, 1, '', '', 31, 0, 01598411425);

-- ----------------------------
-- Table structure for auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_access`;
CREATE TABLE `auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '角色组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_access
-- ----------------------------
INSERT INTO `auth_group_access` VALUES ('1', '1');

-- ----------------------------
-- Table structure for sys_auth
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth`;
CREATE TABLE `sys_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '角色名',
  `rules` text NOT NULL COMMENT '用户组拥有的规则id',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `uname` varchar(28) NOT NULL DEFAULT '' COMMENT '用户名',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1正常，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_auth
-- ----------------------------
INSERT INTO `sys_auth` VALUES ('1', '超级管理员', 'all', '1374661035', '1', 'admin', '1');
INSERT INTO `sys_auth` VALUES ('2', '测试', '5,6,7', '1531708447', '0', '', '1');

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users` (
  `uid` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `rid` tinyint(4) NOT NULL DEFAULT '1' COMMENT '角色id',
  `uname` char(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `upwd` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `department` varchar(255) NOT NULL DEFAULT '' COMMENT '部门',
  `post` varchar(255) NOT NULL DEFAULT '' COMMENT '岗位',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `phone` varchar(56) NOT NULL DEFAULT '' COMMENT '联系电话',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号码',
  `address` varchar(500) NOT NULL DEFAULT '' COMMENT '地址',
  `zipcode` mediumint(6) unsigned NOT NULL DEFAULT '0' COMMENT '邮政编码',
  `idcard` varchar(30) NOT NULL DEFAULT '' COMMENT '证件号码',
  `allowips` text COMMENT '允许登录的IPv4',
  `allowipv6` text COMMENT '允许登录的IPv6',
  `allowmacs` text,
  `rprivilege` text,
  `loginfail` enum('0','1') NOT NULL DEFAULT '0',
  `lastlogintime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近登录时间',
  `lastloginip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最近登录IP',
  `lastloginipv6` char(32) NOT NULL DEFAULT '',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES ('1', '1', 'admin', '1af11eb385ff636fe694be62e11342dd', '', '', '', 'admin@admin.com', '13121343423', '', '', '0', '', null, null, null, null, '0', '1594777029', '3232236244', '', '0');
INSERT INTO `sys_users` VALUES ('2', '2', 'test', '18b814ef2fc45ebba9fd25b6dd98f9b5', '', '', '', '', '', '', '', '0', '', '', '', null, '', '0', '1531901638', '2130706433', '', '1531708626');