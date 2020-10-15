/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50726
Source Host           : 127.0.0.1:3306
Source Database       : app_idc_eu

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-07-17 15:08:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for acclog_local
-- ----------------------------
DROP TABLE IF EXISTS `acclog_local`;
CREATE TABLE `acclog_local` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '源IP（ipv4格式）',
  `dst_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '目的IP（ipv4格式）',
  `src_ipv6` varchar(50) NOT NULL DEFAULT '' COMMENT '源IP（ipv6格式）',
  `dst_ipv6` varchar(50) NOT NULL DEFAULT '' COMMENT '目的IP（ipv6格式）',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源端口',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '目的端口',
  `src_mac` varchar(48) NOT NULL DEFAULT '' COMMENT '源mac地址',
  `dst_mac` varchar(48) NOT NULL DEFAULT '' COMMENT '目的mac地址',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否阻断',
  `service` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '协议',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  `contentType` varchar(32) DEFAULT '' COMMENT '访问内容类型',
  `applicationProtocol` varchar(6) NOT NULL DEFAULT '2000' COMMENT '应用协议类型',
  PRIMARY KEY (`id`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问日志';

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
-- Table structure for auth_rule
-- ----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_rule
-- ----------------------------
INSERT INTO `auth_rule` VALUES ('1', 'Index/index', '控制台首页', '1', '1', '', 'fa fa-dashboard', '0', '0', '01597385492');
INSERT INTO `auth_rule` VALUES ('2', '', '基础数据管理', '1', '1', '', 'fa fa-group', '0', '0', '01597386204');
INSERT INTO `auth_rule` VALUES ('3', 'Idcinfo/index', '基础数据信息', '1', '1', '', '', '2', '0', '01597386305');
INSERT INTO `auth_rule` VALUES ('4', 'House/index', '机房数据管理', '1', '1', '', '', '3', '0', '01597386444');
INSERT INTO `auth_rule` VALUES ('5', 'Userdata/index', '用户数据管理', '1', '1', '', '', '3', '0', '01597386479');
INSERT INTO `auth_rule` VALUES ('6', 'Securityuser/index', '安全责任人管理', '1', '1', '', '', '3', '0', '01597386500');
INSERT INTO `auth_rule` VALUES ('7', 'Idcback/index', '基础数据核验', '1', '1', '', '', '2', '0', '01597386561');
INSERT INTO `auth_rule` VALUES ('8', 'Idcback/house', '机房数据退回', '1', '1', '', '', '7', '0', '01597386598');
INSERT INTO `auth_rule` VALUES ('9', 'Idcback/user', '用户数据退回', '1', '1', '', '', '7', '0', '01597386612');
INSERT INTO `auth_rule` VALUES ('10', '', '业务状态管理', '1', '1', '', 'fa fa-bank', '0', '0', '01597387002');
INSERT INTO `auth_rule` VALUES ('11', 'Resource/index', '活跃域名', '1', '1', '', '', '10', '0', '01597387025');
INSERT INTO `auth_rule` VALUES ('12', 'Resource/ip', '活跃IPv4', '1', '1', '', '', '10', '0', '01597387042');
INSERT INTO `auth_rule` VALUES ('13', 'Resource/ipsix', '活跃IPv6', '1', '1', '', '', '10', '0', '01597387054');
INSERT INTO `auth_rule` VALUES ('14', '', '信息安全管理', '1', '1', '', 'fa fa-life-saver', '0', '0', '01597387081');
INSERT INTO `auth_rule` VALUES ('15', 'Code/index', 'SMMS基础代码', '1', '1', '', '', '2', '0', '01597387358');
INSERT INTO `auth_rule` VALUES ('16', 'Command/index', 'SMMS指令管理', '1', '1', '', '', '14', '0', '01597387393');
INSERT INTO `auth_rule` VALUES ('17', 'Command/localmanage', '本地指令管理', '1', '1', '', '', '14', '0', '01597387407');
INSERT INTO `auth_rule` VALUES ('18', 'Handle/index', '本地处置管理', '1', '1', '', '', '14', '0', '01597387421');
INSERT INTO `auth_rule` VALUES ('19', 'Blacklist/index', '黑白名单管理', '1', '1', '', '', '14', '0', '01597387439');
INSERT INTO `auth_rule` VALUES ('20', 'Filter/index', '监测指令执行记录', '1', '1', '', '', '14', '0', '01597387460');
INSERT INTO `auth_rule` VALUES ('21', 'Filter/filter', '过滤指令执行记录', '1', '1', '', '', '14', '0', '01597387477');
INSERT INTO `auth_rule` VALUES ('22', 'Safe/site', '违法违规网站监测', '1', '1', '', '', '14', '0', '01597389026');
INSERT INTO `auth_rule` VALUES ('23', 'Monitor/index', '异常IP监测', '1', '1', '', '', '14', '0', '01597387534');
INSERT INTO `auth_rule` VALUES ('24', 'Safe/domaincache', '未备案网站监测', '1', '1', '', '', '14', '0', '01597387574');
INSERT INTO `auth_rule` VALUES ('25', 'Keyword/hitlog', '疑似不良网页监测', '1', '1', '', '', '14', '0', '01597387601');
INSERT INTO `auth_rule` VALUES ('26', '', '访问日志管理', '1', '1', '', 'fa fa-commenting-o', '0', '0', '01597387618');
INSERT INTO `auth_rule` VALUES ('27', 'Visit/index', '日志查询', '1', '1', '', '', '26', '0', '01597387634');
INSERT INTO `auth_rule` VALUES ('28', '', '账号管理', '1', '1', '', 'fa fa-calendar-o', '0', '0', '01597387651');
INSERT INTO `auth_rule` VALUES ('29', 'User/index', '账号列表', '1', '1', '', '', '28', '0', '01597387667');
INSERT INTO `auth_rule` VALUES ('30', 'Auth/index', '角色管理', '1', '1', '', '', '28', '0', '01597387684');
INSERT INTO `auth_rule` VALUES ('31', '', '系统管理', '1', '1', '', 'fa fa-cog', '0', '0', '01597387699');
INSERT INTO `auth_rule` VALUES ('32', 'Sysconf/setconf', '基础参数', '1', '1', '', '', '31', '0', '01597387737');
INSERT INTO `auth_rule` VALUES ('33', 'Sysconf/xtpz', '接口参数', '1', '1', '', '', '31', '0', '01597387747');
INSERT INTO `auth_rule` VALUES ('34', 'Server/index', 'EU探针管理', '1', '1', '', '', '31', '0', '01597904154');
INSERT INTO `auth_rule` VALUES ('35', 'Sysconf/time', '系统时间', '1', '1', '', '', '31', '0', '01597387784');
INSERT INTO `auth_rule` VALUES ('36', 'Keyword/index', '关键词库', '1', '1', '', '', '31', '0', '01597387803');
INSERT INTO `auth_rule` VALUES ('37', 'Domain/index', '域名类型', '1', '1', '', '', '31', '0', '01597387816');
INSERT INTO `auth_rule` VALUES ('38', '', '系统日志', '1', '1', '', 'fa fa-file-text-o', '0', '0', '01597387836');
INSERT INTO `auth_rule` VALUES ('39', 'Sysconf/log', '用户操作日志', '1', '1', '', '', '38', '0', '01597387855');
INSERT INTO `auth_rule` VALUES ('40', 'Sysconf/synclog', 'ISMI接口日志', '1', '1', '', '', '38', '0', '01598340739');
INSERT INTO `auth_rule` VALUES ('41', 'Visit/query', '访问日志查询指令', '1', '1', '', '', '26', '0', '01597389746');
INSERT INTO `auth_rule` VALUES ('42', 'Upload/index', '上报文件处理', '1', '1', '', '', '38', '0', '01597389846');
INSERT INTO `auth_rule` VALUES ('43', 'Download/index', '指令执行情况回复', '1', '1', '', '', '38', '0', '01597389871');
INSERT INTO `auth_rule` VALUES ('44', 'Count/index', '统计指令', '1', '1', '', '', '14', '0', '01597390105');
INSERT INTO `auth_rule` VALUES ('45', 'Sysconf/backup', '备份还原', '1', '1', '', '', '31', '0', '01598411425');

-- ----------------------------
-- Table structure for filterlog_local
-- ----------------------------
DROP TABLE IF EXISTS `filterlog_local`;
CREATE TABLE `filterlog_local` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `cid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '管理指令',
  `data` text NOT NULL,
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '源IP（ipv4格式）',
  `dst_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '目的IP（ipv4格式）',
  `src_ipv6` varchar(32) NOT NULL DEFAULT '' COMMENT '源IP（ipv6格式）',
  `dst_ipv6` varchar(32) NOT NULL DEFAULT '' COMMENT '目的IP（ipv6格式）',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源端口',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '目的端口',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `protocol` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型',
  `service` int(6) NOT NULL DEFAULT '0' COMMENT '协议',
  `report` tinyint(1) NOT NULL DEFAULT '1',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  `contentType` varchar(32) DEFAULT '' COMMENT '访问内容类型',
  `applicationProtocol` varchar(6) NOT NULL DEFAULT '2000' COMMENT '应用协议类型',
  PRIMARY KEY (`id`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='过滤日志';

-- ----------------------------
-- Records of filterlog_local
-- ----------------------------

-- ----------------------------
-- Table structure for find_domain_list
-- ----------------------------
DROP TABLE IF EXISTS `find_domain_list`;
CREATE TABLE `find_domain_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `topdomain` varchar(255) NOT NULL DEFAULT '' COMMENT '对应顶级域名',
  `subdomain` varchar(255) NOT NULL DEFAULT '' COMMENT '域名',
  `findip` int(11) unsigned DEFAULT NULL COMMENT '对应IP',
  `ipv6` varchar(191) DEFAULT '' COMMENT '对应ipv6',
  `firstfindtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '首次采集时间',
  `lastfindtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后活跃时间',
  `visitsamount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问量',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否阻断',
  `record` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `logstatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '报备状态',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `baseunit_id` int(11) unsigned NOT NULL DEFAULT '0',
  `houseid` varchar(32) NOT NULL DEFAULT '0' COMMENT '机房id',
  `topDomainflag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '顶级域名标记',
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `port` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '应用端口',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '传输层协议类型',
  `lasttime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `is_handle` tinyint(1) unsigned DEFAULT '0' COMMENT '是否处置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_domain` (`subdomain`),
  KEY `topdomain` (`topdomain`),
  KEY `subdomain` (`subdomain`),
  KEY `findip` (`findip`),
  KEY `port` (`port`),
  KEY `protocol` (`protocol`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源域名监控表';

-- ----------------------------
-- Records of find_domain_list
-- ----------------------------

-- ----------------------------
-- Table structure for find_ip_list
-- ----------------------------
DROP TABLE IF EXISTS `find_ip_list`;
CREATE TABLE `find_ip_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `findip` int(11) unsigned DEFAULT NULL COMMENT '对应IP',
  `ipv6` varchar(191) DEFAULT '' COMMENT 'ipv6',
  `firstfindtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '首次采集时间',
  `lastfindtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后活跃时间',
  `visitsamount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问量',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否阻断',
  `record` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `logstatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '报备状态',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `baseunit_id` int(11) unsigned NOT NULL DEFAULT '0',
  `houseid` varchar(32) NOT NULL DEFAULT '0' COMMENT '机房id',
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `port` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '应用端口',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '传输层协议类型',
  `lasttime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `is_handle` tinyint(1) unsigned DEFAULT '0' COMMENT '是否处置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_ip` (`findip`,`port`,`protocol`),
  KEY `findip` (`findip`),
  KEY `port` (`port`),
  KEY `protocol` (`protocol`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源IP监控表';

-- ----------------------------
-- Records of find_ip_list
-- ----------------------------

-- ----------------------------
-- Table structure for idc_ack_log
-- ----------------------------
DROP TABLE IF EXISTS `idc_ack_log`;
CREATE TABLE `idc_ack_log` (
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `commandtype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '指令类型',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `resultcode` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '结果',
  `msginfo` varchar(128) NOT NULL DEFAULT '' COMMENT '描述',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  KEY `resultcode` (`resultcode`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ack_return';

-- ----------------------------
-- Records of idc_ack_log
-- ----------------------------

-- ----------------------------
-- Table structure for idc_basx
-- ----------------------------
DROP TABLE IF EXISTS `idc_basx`;
CREATE TABLE `idc_basx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '主键id',
  `mc` varchar(64) NOT NULL DEFAULT '' COMMENT '名称',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='备案属性';

-- ----------------------------
-- Records of idc_basx
-- ----------------------------
INSERT INTO `idc_basx` VALUES ('0', '无', '', '1');
INSERT INTO `idc_basx` VALUES ('1', '经营性网站(ICP经营许可证号)', '', '1');
INSERT INTO `idc_basx` VALUES ('2', '非经营性网站(备案登记号)', '', '1');
INSERT INTO `idc_basx` VALUES ('3', 'SP(备案登记号)', '', '1');
INSERT INTO `idc_basx` VALUES ('4', 'BBS(BBS备案号)', '', '1');
INSERT INTO `idc_basx` VALUES ('999', '其他', '', '1');

-- ----------------------------
-- Table structure for idc_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `idc_blacklist`;
CREATE TABLE `idc_blacklist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '黑白名单ID',
  `domain` varchar(256) NOT NULL DEFAULT '' COMMENT '域名链接',
  `level` int(20) DEFAULT '2048' COMMENT '优先级',
  `state` tinyint(1) unsigned zerofill DEFAULT '1' COMMENT '状态',
  `class_id` int(10) NOT NULL DEFAULT '1' COMMENT '分类ID',
  `source` tinyint(2) DEFAULT '0' COMMENT '记录来源ID 0本地导入添加 1管局下发 2本地处置',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `expiredTime` int(11) DEFAULT NULL COMMENT '过期时间',
  `user` varchar(255) DEFAULT '' COMMENT '用户',
  `remark` varchar(255) DEFAULT NULL,
  `log` tinyint(1) DEFAULT '0' COMMENT '日志',
  `is_sync` tinyint(1) DEFAULT '0' COMMENT '是否同步0-未同步 1已同步',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for idc_command
-- ----------------------------
DROP TABLE IF EXISTS `idc_command`;
CREATE TABLE `idc_command` (
  `commandfileid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '管理指令文件序号',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '指令类型',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否过滤',
  `reason` varchar(128) NOT NULL DEFAULT '' COMMENT '过滤原因',
  `log` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '日志记录',
  `report` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '日志上传',
  `effecttime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生效时间',
  `expiredtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `owner` varchar(32) NOT NULL DEFAULT '' COMMENT '指令属主',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否可读',
  `level` smallint(6) unsigned NOT NULL DEFAULT '2048' COMMENT '优先级',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `operationtype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '操作类型',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  UNIQUE KEY `commandid` (`commandid`),
  KEY `time` (`effecttime`,`expiredtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理指令';

-- ----------------------------
-- Records of idc_command
-- ----------------------------

-- ----------------------------
-- Table structure for idc_commandack
-- ----------------------------
DROP TABLE IF EXISTS `idc_commandack`;
CREATE TABLE `idc_commandack` (
  `commandfileid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '管理指令文件序号',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `houseid` text NOT NULL COMMENT '机房id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '指令类型',
  `resultcode` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '结果',
  `msginfo` varchar(128) NOT NULL DEFAULT '' COMMENT '描述',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  KEY `resultcode` (`resultcode`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指令执行情况';

-- ----------------------------
-- Records of idc_commandack
-- ----------------------------

-- ----------------------------
-- Table structure for idc_commandquery
-- ----------------------------
DROP TABLE IF EXISTS `idc_commandquery`;
CREATE TABLE `idc_commandquery` (
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `add_time` varchar(19) NOT NULL DEFAULT '' COMMENT '时间',
  `local` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息安全管理指令查询指令';

-- ----------------------------
-- Records of idc_commandquery
-- ----------------------------

-- ----------------------------
-- Table structure for idc_commandquery_house
-- ----------------------------
DROP TABLE IF EXISTS `idc_commandquery_house`;
CREATE TABLE `idc_commandquery_house` (
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `houseid` varchar(32) NOT NULL DEFAULT '' COMMENT '机房id',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  KEY `commandid` (`commandid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='查询指令机房';

-- ----------------------------
-- Records of idc_commandquery_house
-- ----------------------------

-- ----------------------------
-- Table structure for idc_commandrecord
-- ----------------------------
DROP TABLE IF EXISTS `idc_commandrecord`;
CREATE TABLE `idc_commandrecord` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `controlsId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '执行记录指令ID',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '下发时间',
  PRIMARY KEY (`id`),
  KEY `commandid` (`commandid`),
  KEY `controlsId` (`controlsId`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法管理指令执行记录指令';

-- ----------------------------
-- Records of idc_commandrecord
-- ----------------------------

-- ----------------------------
-- Table structure for idc_commandrecord_count
-- ----------------------------
DROP TABLE IF EXISTS `idc_commandrecord_count`;
CREATE TABLE `idc_commandrecord_count` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '指令类型',
  `count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '记录数量',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '执行时间',
  PRIMARY KEY (`id`),
  KEY `commandid` (`commandid`),
  KEY `type` (`type`),
  KEY `count` (`count`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法管理指令执行记录指令统计';

-- ----------------------------
-- Records of idc_commandrecord_count
-- ----------------------------

-- ----------------------------
-- Table structure for idc_command_fileid
-- ----------------------------
DROP TABLE IF EXISTS `idc_command_fileid`;
CREATE TABLE `idc_command_fileid` (
  `commandfileid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '管理指令文件序号',
  `timestamp` varchar(19) NOT NULL DEFAULT '' COMMENT '生成时间',
  `local` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理指令文件序号';

-- ----------------------------
-- Records of idc_command_fileid
-- ----------------------------

-- ----------------------------
-- Table structure for idc_command_house
-- ----------------------------
DROP TABLE IF EXISTS `idc_command_house`;
CREATE TABLE `idc_command_house` (
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令ID',
  `houseid` varchar(32) NOT NULL DEFAULT '' COMMENT '机房id',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  KEY `commandid` (`commandid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指令机房';

-- ----------------------------
-- Records of idc_command_house
-- ----------------------------

-- ----------------------------
-- Table structure for idc_command_house_test
-- ----------------------------
DROP TABLE IF EXISTS `idc_command_house_test`;
CREATE TABLE `idc_command_house_test` (
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `houseid` varchar(32) NOT NULL DEFAULT '',
  `local` tinyint(1) NOT NULL DEFAULT '1',
  KEY `commandid` (`commandid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_command_house_test
-- ----------------------------

-- ----------------------------
-- Table structure for idc_command_rule
-- ----------------------------
DROP TABLE IF EXISTS `idc_command_rule`;
CREATE TABLE `idc_command_rule` (
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `subtype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '规则类型',
  `valuestart` varchar(128) NOT NULL DEFAULT '' COMMENT '起始值',
  `valueend` varchar(128) NOT NULL DEFAULT '' COMMENT '终止值',
  `keywordrange` varchar(18) NOT NULL DEFAULT '' COMMENT '匹配范围',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  KEY `commandid` (`commandid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理指令规则';

-- ----------------------------
-- Records of idc_command_rule
-- ----------------------------

-- ----------------------------
-- Table structure for idc_command_rule_test
-- ----------------------------
DROP TABLE IF EXISTS `idc_command_rule_test`;
CREATE TABLE `idc_command_rule_test` (
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `subtype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `valuestart` varchar(128) NOT NULL DEFAULT '',
  `valueend` varchar(128) NOT NULL DEFAULT '',
  `keywordrange` varchar(18) NOT NULL DEFAULT '',
  `local` tinyint(1) unsigned NOT NULL DEFAULT '1',
  KEY `commandid` (`commandid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理指令规则';

-- ----------------------------
-- Records of idc_command_rule_test
-- ----------------------------

-- ----------------------------
-- Table structure for idc_command_test
-- ----------------------------
DROP TABLE IF EXISTS `idc_command_test`;
CREATE TABLE `idc_command_test` (
  `commandfileid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reason` varchar(128) NOT NULL DEFAULT '',
  `log` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `report` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `effecttime` int(10) unsigned NOT NULL DEFAULT '0',
  `expiredtime` int(10) unsigned NOT NULL DEFAULT '0',
  `idcid` varchar(18) NOT NULL DEFAULT '',
  `owner` varchar(32) NOT NULL DEFAULT '',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `level` smallint(6) unsigned NOT NULL DEFAULT '2048',
  `local` tinyint(1) NOT NULL DEFAULT '1',
  `operationtype` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `commandid` (`commandid`),
  KEY `time` (`effecttime`,`expiredtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_command_test
-- ----------------------------

-- ----------------------------
-- Table structure for idc_dllx
-- ----------------------------
DROP TABLE IF EXISTS `idc_dllx`;
CREATE TABLE `idc_dllx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '代理类型',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理类型';

-- ----------------------------
-- Records of idc_dllx
-- ----------------------------
INSERT INTO `idc_dllx` VALUES ('1', 'HTTP代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('2', 'FTP代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('3', 'Telnet代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('4', 'SOCKS代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('5', '网页代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('6', 'SSL代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('7', 'POP3代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('8', 'TUNNEL代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('9', '文献代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('10', 'SSSO代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('11', 'ISA代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('12', '透传代理', '', '1');
INSERT INTO `idc_dllx` VALUES ('999', '其他', '', '1');

-- ----------------------------
-- Table structure for idc_domaincache
-- ----------------------------
DROP TABLE IF EXISTS `idc_domaincache`;
CREATE TABLE `idc_domaincache` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `domain` varchar(255) NOT NULL DEFAULT '' COMMENT '域名',
  `status` tinyint(1) DEFAULT '0' COMMENT '备案状态',
  `name` varchar(255) DEFAULT NULL,
  `primary_icp` varchar(255) DEFAULT NULL COMMENT '备案号',
  `site_icp` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '查询时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`),
  KEY `time` (`time`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_domaincache
-- ----------------------------

-- ----------------------------
-- Table structure for idc_domaininfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_domaininfo`;
CREATE TABLE `idc_domaininfo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `serviceId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '服务信息id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `lastregtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '持续时间',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `serviceId` (`serviceId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='域名';

-- ----------------------------
-- Records of idc_domaininfo
-- ----------------------------

-- ----------------------------
-- Table structure for idc_domainsuffix
-- ----------------------------
DROP TABLE IF EXISTS `idc_domainsuffix`;
CREATE TABLE `idc_domainsuffix` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `domainsuffix` varchar(30) NOT NULL COMMENT '域名类型名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=268 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_domainsuffix
-- ----------------------------
INSERT INTO `idc_domainsuffix` VALUES ('1', 'br.com');
INSERT INTO `idc_domainsuffix` VALUES ('2', 'cn.com');
INSERT INTO `idc_domainsuffix` VALUES ('3', 'eu.com');
INSERT INTO `idc_domainsuffix` VALUES ('4', 'hu.com');
INSERT INTO `idc_domainsuffix` VALUES ('5', 'no.com');
INSERT INTO `idc_domainsuffix` VALUES ('6', 'qc.com');
INSERT INTO `idc_domainsuffix` VALUES ('7', 'sa.com');
INSERT INTO `idc_domainsuffix` VALUES ('8', 'se.com');
INSERT INTO `idc_domainsuffix` VALUES ('9', 'se.net');
INSERT INTO `idc_domainsuffix` VALUES ('10', 'us.com');
INSERT INTO `idc_domainsuffix` VALUES ('11', 'uy.com');
INSERT INTO `idc_domainsuffix` VALUES ('12', 'za.com');
INSERT INTO `idc_domainsuffix` VALUES ('13', 'co.uk');
INSERT INTO `idc_domainsuffix` VALUES ('14', 'org.uk');
INSERT INTO `idc_domainsuffix` VALUES ('15', 'ltd.uk');
INSERT INTO `idc_domainsuffix` VALUES ('16', 'plc.uk');
INSERT INTO `idc_domainsuffix` VALUES ('17', 'me.uk');
INSERT INTO `idc_domainsuffix` VALUES ('18', 'co.ac');
INSERT INTO `idc_domainsuffix` VALUES ('19', 'gv.ac');
INSERT INTO `idc_domainsuffix` VALUES ('20', 'or.ac');
INSERT INTO `idc_domainsuffix` VALUES ('21', 'ac.ac');
INSERT INTO `idc_domainsuffix` VALUES ('22', 'ac.at');
INSERT INTO `idc_domainsuffix` VALUES ('23', 'co.at');
INSERT INTO `idc_domainsuffix` VALUES ('24', 'gv.at');
INSERT INTO `idc_domainsuffix` VALUES ('25', 'or.at');
INSERT INTO `idc_domainsuffix` VALUES ('26', 'asn.au');
INSERT INTO `idc_domainsuffix` VALUES ('27', 'com.au');
INSERT INTO `idc_domainsuffix` VALUES ('28', 'edu.au');
INSERT INTO `idc_domainsuffix` VALUES ('29', 'org.au');
INSERT INTO `idc_domainsuffix` VALUES ('30', 'net.au');
INSERT INTO `idc_domainsuffix` VALUES ('31', 'ac.be');
INSERT INTO `idc_domainsuffix` VALUES ('32', 'adm.br');
INSERT INTO `idc_domainsuffix` VALUES ('33', 'adv.br');
INSERT INTO `idc_domainsuffix` VALUES ('34', 'am.br');
INSERT INTO `idc_domainsuffix` VALUES ('35', 'arq.br');
INSERT INTO `idc_domainsuffix` VALUES ('36', 'art.br');
INSERT INTO `idc_domainsuffix` VALUES ('37', 'bio.br');
INSERT INTO `idc_domainsuffix` VALUES ('38', 'cng.br');
INSERT INTO `idc_domainsuffix` VALUES ('39', 'cnt.br');
INSERT INTO `idc_domainsuffix` VALUES ('40', 'com.br');
INSERT INTO `idc_domainsuffix` VALUES ('41', 'ecn.br');
INSERT INTO `idc_domainsuffix` VALUES ('42', 'eng.br');
INSERT INTO `idc_domainsuffix` VALUES ('43', 'esp.br');
INSERT INTO `idc_domainsuffix` VALUES ('44', 'etc.br');
INSERT INTO `idc_domainsuffix` VALUES ('45', 'eti.br');
INSERT INTO `idc_domainsuffix` VALUES ('46', 'fm.br');
INSERT INTO `idc_domainsuffix` VALUES ('47', 'fot.br');
INSERT INTO `idc_domainsuffix` VALUES ('48', 'fst.br');
INSERT INTO `idc_domainsuffix` VALUES ('49', 'g12.br');
INSERT INTO `idc_domainsuffix` VALUES ('50', 'gov.br');
INSERT INTO `idc_domainsuffix` VALUES ('51', 'ind.br');
INSERT INTO `idc_domainsuffix` VALUES ('52', 'inf.br');
INSERT INTO `idc_domainsuffix` VALUES ('53', 'jor.br');
INSERT INTO `idc_domainsuffix` VALUES ('54', 'lel.br');
INSERT INTO `idc_domainsuffix` VALUES ('55', 'med.br');
INSERT INTO `idc_domainsuffix` VALUES ('56', 'mil.br');
INSERT INTO `idc_domainsuffix` VALUES ('57', 'net.br');
INSERT INTO `idc_domainsuffix` VALUES ('58', 'nom.br');
INSERT INTO `idc_domainsuffix` VALUES ('59', 'ntr.br');
INSERT INTO `idc_domainsuffix` VALUES ('60', 'odo.br');
INSERT INTO `idc_domainsuffix` VALUES ('61', 'org.br');
INSERT INTO `idc_domainsuffix` VALUES ('62', 'ppg.br');
INSERT INTO `idc_domainsuffix` VALUES ('63', 'pro.br');
INSERT INTO `idc_domainsuffix` VALUES ('64', 'psc.br');
INSERT INTO `idc_domainsuffix` VALUES ('65', 'psi.br');
INSERT INTO `idc_domainsuffix` VALUES ('66', 'rec.br');
INSERT INTO `idc_domainsuffix` VALUES ('67', 'slg.br');
INSERT INTO `idc_domainsuffix` VALUES ('68', 'tmp.br');
INSERT INTO `idc_domainsuffix` VALUES ('69', 'tur.br');
INSERT INTO `idc_domainsuffix` VALUES ('70', 'tv.br');
INSERT INTO `idc_domainsuffix` VALUES ('71', 'vet.br');
INSERT INTO `idc_domainsuffix` VALUES ('72', 'zlg.br');
INSERT INTO `idc_domainsuffix` VALUES ('73', 'ab.ca');
INSERT INTO `idc_domainsuffix` VALUES ('74', 'bc.ca');
INSERT INTO `idc_domainsuffix` VALUES ('75', 'mb.ca');
INSERT INTO `idc_domainsuffix` VALUES ('76', 'nb.ca');
INSERT INTO `idc_domainsuffix` VALUES ('77', 'nf.ca');
INSERT INTO `idc_domainsuffix` VALUES ('78', 'ns.ca');
INSERT INTO `idc_domainsuffix` VALUES ('79', 'nt.ca');
INSERT INTO `idc_domainsuffix` VALUES ('80', 'on.ca');
INSERT INTO `idc_domainsuffix` VALUES ('81', 'pe.ca');
INSERT INTO `idc_domainsuffix` VALUES ('82', 'qc.ca');
INSERT INTO `idc_domainsuffix` VALUES ('83', 'sk.ca');
INSERT INTO `idc_domainsuffix` VALUES ('84', 'yk.ca');
INSERT INTO `idc_domainsuffix` VALUES ('85', 'ac.cn');
INSERT INTO `idc_domainsuffix` VALUES ('86', 'sx.cn');
INSERT INTO `idc_domainsuffix` VALUES ('87', 'com.cn');
INSERT INTO `idc_domainsuffix` VALUES ('88', 'edu.cn');
INSERT INTO `idc_domainsuffix` VALUES ('89', 'gov.cn');
INSERT INTO `idc_domainsuffix` VALUES ('90', 'net.cn');
INSERT INTO `idc_domainsuffix` VALUES ('91', 'org.cn');
INSERT INTO `idc_domainsuffix` VALUES ('92', 'bj.cn');
INSERT INTO `idc_domainsuffix` VALUES ('93', 'sh.cn');
INSERT INTO `idc_domainsuffix` VALUES ('94', 'tj.cn');
INSERT INTO `idc_domainsuffix` VALUES ('95', 'cq.cn');
INSERT INTO `idc_domainsuffix` VALUES ('96', 'he.cn');
INSERT INTO `idc_domainsuffix` VALUES ('97', 'nm.cn');
INSERT INTO `idc_domainsuffix` VALUES ('98', 'ln.cn');
INSERT INTO `idc_domainsuffix` VALUES ('99', 'jl.cn');
INSERT INTO `idc_domainsuffix` VALUES ('100', 'hl.cn');
INSERT INTO `idc_domainsuffix` VALUES ('101', 'js.cn');
INSERT INTO `idc_domainsuffix` VALUES ('102', 'jx.cn');
INSERT INTO `idc_domainsuffix` VALUES ('103', 'zj.cn');
INSERT INTO `idc_domainsuffix` VALUES ('104', 'sd.cn');
INSERT INTO `idc_domainsuffix` VALUES ('105', 'ah.cn');
INSERT INTO `idc_domainsuffix` VALUES ('106', 'ha.cn');
INSERT INTO `idc_domainsuffix` VALUES ('107', 'hb.cn');
INSERT INTO `idc_domainsuffix` VALUES ('108', 'hn.cn');
INSERT INTO `idc_domainsuffix` VALUES ('109', 'gd.cn');
INSERT INTO `idc_domainsuffix` VALUES ('110', 'gx.cn');
INSERT INTO `idc_domainsuffix` VALUES ('111', 'hi.cn');
INSERT INTO `idc_domainsuffix` VALUES ('112', 'sc.cn');
INSERT INTO `idc_domainsuffix` VALUES ('113', 'gz.cn');
INSERT INTO `idc_domainsuffix` VALUES ('114', 'yn.cn');
INSERT INTO `idc_domainsuffix` VALUES ('115', 'xz.cn');
INSERT INTO `idc_domainsuffix` VALUES ('116', 'sn.cn');
INSERT INTO `idc_domainsuffix` VALUES ('117', 'gs.cn');
INSERT INTO `idc_domainsuffix` VALUES ('118', 'qh.cn');
INSERT INTO `idc_domainsuffix` VALUES ('119', 'nx.cn');
INSERT INTO `idc_domainsuffix` VALUES ('120', 'xj.cn');
INSERT INTO `idc_domainsuffix` VALUES ('121', 'tw.cn');
INSERT INTO `idc_domainsuffix` VALUES ('122', 'fj.cn');
INSERT INTO `idc_domainsuffix` VALUES ('123', 'hk.cn');
INSERT INTO `idc_domainsuffix` VALUES ('124', '政務.cn');
INSERT INTO `idc_domainsuffix` VALUES ('125', '公益.cn');
INSERT INTO `idc_domainsuffix` VALUES ('126', '政务.cn');
INSERT INTO `idc_domainsuffix` VALUES ('127', 'mil.cn');
INSERT INTO `idc_domainsuffix` VALUES ('128', '其他.cn');
INSERT INTO `idc_domainsuffix` VALUES ('129', 'mo.cn');
INSERT INTO `idc_domainsuffix` VALUES ('130', 'com.hk');
INSERT INTO `idc_domainsuffix` VALUES ('131', 'org.hk');
INSERT INTO `idc_domainsuffix` VALUES ('132', 'net.hk');
INSERT INTO `idc_domainsuffix` VALUES ('133', 'edu.hk');
INSERT INTO `idc_domainsuffix` VALUES ('134', 'com.ec');
INSERT INTO `idc_domainsuffix` VALUES ('135', 'org.ec');
INSERT INTO `idc_domainsuffix` VALUES ('136', 'net.ec');
INSERT INTO `idc_domainsuffix` VALUES ('137', 'mil.ec');
INSERT INTO `idc_domainsuffix` VALUES ('138', 'fin.ec');
INSERT INTO `idc_domainsuffix` VALUES ('139', 'med.ec');
INSERT INTO `idc_domainsuffix` VALUES ('140', 'gov.ec');
INSERT INTO `idc_domainsuffix` VALUES ('141', 'tm.fr');
INSERT INTO `idc_domainsuffix` VALUES ('142', 'com.fr');
INSERT INTO `idc_domainsuffix` VALUES ('143', 'asso.fr');
INSERT INTO `idc_domainsuffix` VALUES ('144', 'presse.fr');
INSERT INTO `idc_domainsuffix` VALUES ('145', 'co.il');
INSERT INTO `idc_domainsuffix` VALUES ('146', 'org.il');
INSERT INTO `idc_domainsuffix` VALUES ('147', 'net.il');
INSERT INTO `idc_domainsuffix` VALUES ('148', 'ac.il');
INSERT INTO `idc_domainsuffix` VALUES ('149', 'k12.il');
INSERT INTO `idc_domainsuffix` VALUES ('150', 'gov.il');
INSERT INTO `idc_domainsuffix` VALUES ('151', 'muni.il');
INSERT INTO `idc_domainsuffix` VALUES ('152', 'ac.in');
INSERT INTO `idc_domainsuffix` VALUES ('153', 'co.in');
INSERT INTO `idc_domainsuffix` VALUES ('154', 'ernet.in');
INSERT INTO `idc_domainsuffix` VALUES ('155', 'gov.in');
INSERT INTO `idc_domainsuffix` VALUES ('156', 'net.in');
INSERT INTO `idc_domainsuffix` VALUES ('157', 'res.in');
INSERT INTO `idc_domainsuffix` VALUES ('158', 'ac.jp');
INSERT INTO `idc_domainsuffix` VALUES ('159', 'co.jp');
INSERT INTO `idc_domainsuffix` VALUES ('160', 'go.jp');
INSERT INTO `idc_domainsuffix` VALUES ('161', 'or.jp');
INSERT INTO `idc_domainsuffix` VALUES ('162', 'ne.jp');
INSERT INTO `idc_domainsuffix` VALUES ('163', 'ac.kr');
INSERT INTO `idc_domainsuffix` VALUES ('164', 'co.kr');
INSERT INTO `idc_domainsuffix` VALUES ('165', 'go.kr');
INSERT INTO `idc_domainsuffix` VALUES ('166', 'ne.kr');
INSERT INTO `idc_domainsuffix` VALUES ('167', 'nm.kr');
INSERT INTO `idc_domainsuffix` VALUES ('168', 'or.kr');
INSERT INTO `idc_domainsuffix` VALUES ('169', 're.kr');
INSERT INTO `idc_domainsuffix` VALUES ('170', 'asso.mc');
INSERT INTO `idc_domainsuffix` VALUES ('171', 'tm.mc');
INSERT INTO `idc_domainsuffix` VALUES ('172', 'com.mm');
INSERT INTO `idc_domainsuffix` VALUES ('173', 'org.mm');
INSERT INTO `idc_domainsuffix` VALUES ('174', 'net.mm');
INSERT INTO `idc_domainsuffix` VALUES ('175', 'edu.mm');
INSERT INTO `idc_domainsuffix` VALUES ('176', 'gov.mm');
INSERT INTO `idc_domainsuffix` VALUES ('177', 'com.mx');
INSERT INTO `idc_domainsuffix` VALUES ('178', 'org.mx');
INSERT INTO `idc_domainsuffix` VALUES ('179', 'net.mx');
INSERT INTO `idc_domainsuffix` VALUES ('180', 'edu.mx');
INSERT INTO `idc_domainsuffix` VALUES ('181', 'gov.mx');
INSERT INTO `idc_domainsuffix` VALUES ('182', 'gob.mx');
INSERT INTO `idc_domainsuffix` VALUES ('183', 'com.pl');
INSERT INTO `idc_domainsuffix` VALUES ('184', 'net.pl');
INSERT INTO `idc_domainsuffix` VALUES ('185', 'org.pl');
INSERT INTO `idc_domainsuffix` VALUES ('186', 'aid.pl');
INSERT INTO `idc_domainsuffix` VALUES ('187', 'agro.pl');
INSERT INTO `idc_domainsuffix` VALUES ('188', 'atm.pl');
INSERT INTO `idc_domainsuffix` VALUES ('189', 'auto.pl');
INSERT INTO `idc_domainsuffix` VALUES ('190', 'biz.pl');
INSERT INTO `idc_domainsuffix` VALUES ('191', 'edu.pl');
INSERT INTO `idc_domainsuffix` VALUES ('192', 'gmina.pl');
INSERT INTO `idc_domainsuffix` VALUES ('193', 'gsm.pl');
INSERT INTO `idc_domainsuffix` VALUES ('194', 'info.pl');
INSERT INTO `idc_domainsuffix` VALUES ('195', 'mail.pl');
INSERT INTO `idc_domainsuffix` VALUES ('196', 'miasta.pl');
INSERT INTO `idc_domainsuffix` VALUES ('197', 'media.pl');
INSERT INTO `idc_domainsuffix` VALUES ('198', 'mil.pl');
INSERT INTO `idc_domainsuffix` VALUES ('199', 'nom.pl');
INSERT INTO `idc_domainsuffix` VALUES ('200', 'pc.pl');
INSERT INTO `idc_domainsuffix` VALUES ('201', 'priv.pl');
INSERT INTO `idc_domainsuffix` VALUES ('202', 'realestate.pl');
INSERT INTO `idc_domainsuffix` VALUES ('203', 'rel.pl');
INSERT INTO `idc_domainsuffix` VALUES ('204', 'shop.pl');
INSERT INTO `idc_domainsuffix` VALUES ('205', 'sklep.pl');
INSERT INTO `idc_domainsuffix` VALUES ('206', 'sos.pl');
INSERT INTO `idc_domainsuffix` VALUES ('207', 'targi.pl');
INSERT INTO `idc_domainsuffix` VALUES ('208', 'tm.pl');
INSERT INTO `idc_domainsuffix` VALUES ('209', 'tourism.pl');
INSERT INTO `idc_domainsuffix` VALUES ('210', 'travel.pl');
INSERT INTO `idc_domainsuffix` VALUES ('211', 'turystyka.pl');
INSERT INTO `idc_domainsuffix` VALUES ('212', 'com.ro');
INSERT INTO `idc_domainsuffix` VALUES ('213', 'org.ro');
INSERT INTO `idc_domainsuffix` VALUES ('214', 'store.ro');
INSERT INTO `idc_domainsuffix` VALUES ('215', 'tm.ro');
INSERT INTO `idc_domainsuffix` VALUES ('216', 'firm.ro');
INSERT INTO `idc_domainsuffix` VALUES ('217', 'www.ro');
INSERT INTO `idc_domainsuffix` VALUES ('218', 'arts.ro');
INSERT INTO `idc_domainsuffix` VALUES ('219', 'rec.ro');
INSERT INTO `idc_domainsuffix` VALUES ('220', 'info.ro');
INSERT INTO `idc_domainsuffix` VALUES ('221', 'nom.ro');
INSERT INTO `idc_domainsuffix` VALUES ('222', 'nt.ro');
INSERT INTO `idc_domainsuffix` VALUES ('223', 'com.ru');
INSERT INTO `idc_domainsuffix` VALUES ('224', 'net.ru');
INSERT INTO `idc_domainsuffix` VALUES ('225', 'org.ru');
INSERT INTO `idc_domainsuffix` VALUES ('226', 'com.sg');
INSERT INTO `idc_domainsuffix` VALUES ('227', 'org.sg');
INSERT INTO `idc_domainsuffix` VALUES ('228', 'net.sg');
INSERT INTO `idc_domainsuffix` VALUES ('229', 'gov.sg');
INSERT INTO `idc_domainsuffix` VALUES ('230', 'ac.th');
INSERT INTO `idc_domainsuffix` VALUES ('231', 'co.th');
INSERT INTO `idc_domainsuffix` VALUES ('232', 'go.th');
INSERT INTO `idc_domainsuffix` VALUES ('233', 'mi.th');
INSERT INTO `idc_domainsuffix` VALUES ('234', 'net.th');
INSERT INTO `idc_domainsuffix` VALUES ('235', 'or.th');
INSERT INTO `idc_domainsuffix` VALUES ('236', 'bbs.tr');
INSERT INTO `idc_domainsuffix` VALUES ('237', 'com.tr');
INSERT INTO `idc_domainsuffix` VALUES ('238', 'edu.tr');
INSERT INTO `idc_domainsuffix` VALUES ('239', 'gov.tr');
INSERT INTO `idc_domainsuffix` VALUES ('240', 'k12.tr');
INSERT INTO `idc_domainsuffix` VALUES ('241', 'mil.tr');
INSERT INTO `idc_domainsuffix` VALUES ('242', 'net.tr');
INSERT INTO `idc_domainsuffix` VALUES ('243', 'org.tr');
INSERT INTO `idc_domainsuffix` VALUES ('244', 'com.tw');
INSERT INTO `idc_domainsuffix` VALUES ('245', 'org.tw');
INSERT INTO `idc_domainsuffix` VALUES ('246', 'net.tw');
INSERT INTO `idc_domainsuffix` VALUES ('247', 'ac.uk');
INSERT INTO `idc_domainsuffix` VALUES ('248', 'uk.co');
INSERT INTO `idc_domainsuffix` VALUES ('249', 'uk.com');
INSERT INTO `idc_domainsuffix` VALUES ('250', 'uk.net');
INSERT INTO `idc_domainsuffix` VALUES ('251', 'gb.com');
INSERT INTO `idc_domainsuffix` VALUES ('252', 'gb.net');
INSERT INTO `idc_domainsuffix` VALUES ('253', 'ac.za');
INSERT INTO `idc_domainsuffix` VALUES ('254', 'alt.za');
INSERT INTO `idc_domainsuffix` VALUES ('255', 'co.za');
INSERT INTO `idc_domainsuffix` VALUES ('256', 'edu.za');
INSERT INTO `idc_domainsuffix` VALUES ('257', 'gov.za');
INSERT INTO `idc_domainsuffix` VALUES ('258', 'mil.za');
INSERT INTO `idc_domainsuffix` VALUES ('259', 'net.za');
INSERT INTO `idc_domainsuffix` VALUES ('260', 'ngo.za');
INSERT INTO `idc_domainsuffix` VALUES ('261', 'nom.za');
INSERT INTO `idc_domainsuffix` VALUES ('262', 'org.za');
INSERT INTO `idc_domainsuffix` VALUES ('263', 'school.za');
INSERT INTO `idc_domainsuffix` VALUES ('264', 'tm.za');
INSERT INTO `idc_domainsuffix` VALUES ('265', 'web.za');
INSERT INTO `idc_domainsuffix` VALUES ('266', 'eu.lv');
INSERT INTO `idc_domainsuffix` VALUES ('267', 'uni.cc');

-- ----------------------------
-- Table structure for idc_download_file
-- ----------------------------
DROP TABLE IF EXISTS `idc_download_file`;
CREATE TABLE `idc_download_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `ctype` tinyint(6) NOT NULL DEFAULT '0' COMMENT '指令类型',
  `subtype` tinyint(6) NOT NULL DEFAULT '0' COMMENT '规则类型',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `filename_de` varchar(255) NOT NULL DEFAULT '',
  `filepath` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `filesize` int(11) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `resultcode` int(10) NOT NULL DEFAULT '0' COMMENT '结果',
  `content` varchar(1024) NOT NULL DEFAULT '' COMMENT '内容',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `commandid` (`commandid`),
  KEY `ctype` (`ctype`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口下载文件列表';

-- ----------------------------
-- Records of idc_download_file
-- ----------------------------

-- ----------------------------
-- Table structure for idc_dwsx
-- ----------------------------
DROP TABLE IF EXISTS `idc_dwsx`;
CREATE TABLE `idc_dwsx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '单位属性名称',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单位属性';

-- ----------------------------
-- Records of idc_dwsx
-- ----------------------------
INSERT INTO `idc_dwsx` VALUES ('1', '军队', '', '1');
INSERT INTO `idc_dwsx` VALUES ('2', '政府机关', '', '1');
INSERT INTO `idc_dwsx` VALUES ('3', '事业单位', '', '1');
INSERT INTO `idc_dwsx` VALUES ('4', '企业', '', '1');
INSERT INTO `idc_dwsx` VALUES ('5', '个人', '', '1');
INSERT INTO `idc_dwsx` VALUES ('6', '社会团体', '', '1');
INSERT INTO `idc_dwsx` VALUES ('999', '其他', '', '1');

-- ----------------------------
-- Table structure for idc_file_load_action
-- ----------------------------
DROP TABLE IF EXISTS `idc_file_load_action`;
CREATE TABLE `idc_file_load_action` (
  `filename` varchar(16) NOT NULL DEFAULT '' COMMENT '源文件',
  `datatype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '上报类型',
  `resulttype` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '处理结果',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '内容',
  `loadtype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  UNIQUE KEY `filename` (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上报文件处理结果';

-- ----------------------------
-- Records of idc_file_load_action
-- ----------------------------

-- ----------------------------
-- Table structure for idc_file_name
-- ----------------------------
DROP TABLE IF EXISTS `idc_file_name`;
CREATE TABLE `idc_file_name` (
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '文件名',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `commandtype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '指令类型',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `id` varchar(32) NOT NULL DEFAULT '',
  KEY ` name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上报文件记录';

-- ----------------------------
-- Table structure for idc_frameinfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_frameinfo`;
CREATE TABLE `idc_frameinfo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `houseId` varchar(32) NOT NULL DEFAULT '' COMMENT '机房id',
  `useType` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '使用类型',
  `distribution` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '分配状态',
  `occupancy` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '占用状态',
  `frameName` varchar(128) NOT NULL DEFAULT '' COMMENT '机位名称',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  PRIMARY KEY (`id`),
  KEY `houseId` (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机架信息';

-- ----------------------------
-- Records of idc_frameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for idc_fwnr
-- ----------------------------
DROP TABLE IF EXISTS `idc_fwnr`;
CREATE TABLE `idc_fwnr` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '服务内容',
  `fl` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务内容';

-- ----------------------------
-- Records of idc_fwnr
-- ----------------------------
INSERT INTO `idc_fwnr` VALUES ('500', '基础应用', '0', '', '1');
INSERT INTO `idc_fwnr` VALUES ('501', '网络媒体', '0', '', '1');
INSERT INTO `idc_fwnr` VALUES ('502', '电子政务/电子商务', '0', '', '1');
INSERT INTO `idc_fwnr` VALUES ('503', '数字娱乐', '0', '', '1');
INSERT INTO `idc_fwnr` VALUES ('504', '其他', '0', '', '1');
INSERT INTO `idc_fwnr` VALUES ('1', '即时通信', '500', '', '1');
INSERT INTO `idc_fwnr` VALUES ('2', '搜索引擎', '500', '', '1');
INSERT INTO `idc_fwnr` VALUES ('3', '综合门户', '500', '', '1');
INSERT INTO `idc_fwnr` VALUES ('4', '网上邮局', '500', '', '1');
INSERT INTO `idc_fwnr` VALUES ('5', '网络新闻', '501', '', '1');
INSERT INTO `idc_fwnr` VALUES ('6', '博客/个人空间', '501', '', '1');
INSERT INTO `idc_fwnr` VALUES ('7', '网络广告/信息', '501', '', '1');
INSERT INTO `idc_fwnr` VALUES ('8', '单位门户网站', '501', '', '1');
INSERT INTO `idc_fwnr` VALUES ('9', '网络购物', '502', '', '1');
INSERT INTO `idc_fwnr` VALUES ('10', '网上支付', '502', '', '1');
INSERT INTO `idc_fwnr` VALUES ('11', '网上银行', '502', '', '1');
INSERT INTO `idc_fwnr` VALUES ('12', '网上炒股/股票基金', '502', '', '1');
INSERT INTO `idc_fwnr` VALUES ('13', '网络游戏', '503', '', '1');
INSERT INTO `idc_fwnr` VALUES ('14', '网络音乐', '503', '', '1');
INSERT INTO `idc_fwnr` VALUES ('15', '网络影视', '503', '', '1');
INSERT INTO `idc_fwnr` VALUES ('16', '网络图片', '503', '', '1');
INSERT INTO `idc_fwnr` VALUES ('17', '网络软件/下载', '503', '', '1');
INSERT INTO `idc_fwnr` VALUES ('18', '网上求职', '504', '', '1');
INSERT INTO `idc_fwnr` VALUES ('19', '网上交友/婚介', '504', '', '1');
INSERT INTO `idc_fwnr` VALUES ('20', '网上房产', '504', '', '1');
INSERT INTO `idc_fwnr` VALUES ('21', '网络教育', '504', '', '1');
INSERT INTO `idc_fwnr` VALUES ('22', '网站建设', '504', '', '1');
INSERT INTO `idc_fwnr` VALUES ('23', 'WAP', '504', '', '1');
INSERT INTO `idc_fwnr` VALUES ('24', '其他', '504', '', '1');

-- ----------------------------
-- Table structure for idc_gatewayinfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_gatewayinfo`;
CREATE TABLE `idc_gatewayinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `houseId` varchar(32) NOT NULL DEFAULT '' COMMENT '所属机房id',
  `bandWidth` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '出入口带宽',
  `gatewayIp` varchar(64) NOT NULL DEFAULT '' COMMENT '出入网关IP地址',
  `linkType` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '链路类型',
  `accessUnit` varchar(64) NOT NULL DEFAULT '' COMMENT '接入单位',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  PRIMARY KEY (`id`),
  KEY `houseId` (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出入口信息';

-- ----------------------------
-- Records of idc_gatewayinfo
-- ----------------------------

-- ----------------------------
-- Table structure for idc_gzlx
-- ----------------------------
DROP TABLE IF EXISTS `idc_gzlx`;
CREATE TABLE `idc_gzlx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '监测过滤规则类型',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='监测过滤规则类型';

-- ----------------------------
-- Records of idc_gzlx
-- ----------------------------
INSERT INTO `idc_gzlx` VALUES ('1', '域名', '', '1');
INSERT INTO `idc_gzlx` VALUES ('2', 'URL', '', '1');
INSERT INTO `idc_gzlx` VALUES ('3', '关键字', '', '1');
INSERT INTO `idc_gzlx` VALUES ('4', '源IP地址', '', '1');
INSERT INTO `idc_gzlx` VALUES ('5', '目的IP地址', '', '1');
INSERT INTO `idc_gzlx` VALUES ('6', '源端口', '', '1');
INSERT INTO `idc_gzlx` VALUES ('7', '目的端口', '', '1');
INSERT INTO `idc_gzlx` VALUES ('8', '传输层协议', '', '1');

-- ----------------------------
-- Table structure for idc_household_inter
-- ----------------------------
DROP TABLE IF EXISTS `idc_household_inter`;
CREATE TABLE `idc_household_inter` (
  `hhID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `houseId` varchar(32) NOT NULL DEFAULT '' COMMENT '占用机房id',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '用户名称id',
  `serviceId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '服务信息id',
  `distributeTime` varchar(10) NOT NULL DEFAULT '' COMMENT '资源分配时间',
  `bandWidth` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '网络带宽',
  `frameInfoId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '机架信息id',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  PRIMARY KEY (`hhID`),
  KEY `userid` (`userid`),
  KEY `serviceId` (`serviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_household_inter
-- ----------------------------

-- ----------------------------
-- Table structure for idc_household_other
-- ----------------------------
DROP TABLE IF EXISTS `idc_household_other`;
CREATE TABLE `idc_household_other` (
  `hhID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `houseId` varchar(32) NOT NULL DEFAULT '' COMMENT '占用机房id',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户名称id',
  `distributeTime` varchar(10) NOT NULL DEFAULT '' COMMENT '资源分配时间',
  `bandWidth` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '网络带宽',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  PRIMARY KEY (`hhID`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_household_other
-- ----------------------------

-- ----------------------------
-- Table structure for idc_houseillegal
-- ----------------------------
DROP TABLE IF EXISTS `idc_houseillegal`;
CREATE TABLE `idc_houseillegal` (
  `logId` bigint(20) NOT NULL AUTO_INCREMENT,
  `houseId` bigint(20) NOT NULL COMMENT '机房ID',
  `destIp` varchar(64) DEFAULT NULL COMMENT '目的IP',
  `destPort` int(20) DEFAULT NULL COMMENT '目的端口',
  `domain` varchar(130) DEFAULT '' COMMENT '域名',
  `url` varchar(333) DEFAULT NULL,
  `serviceType` int(10) DEFAULT '24' COMMENT '服务类型',
  `firstFound` datetime DEFAULT NULL COMMENT '首次发现时间',
  `lastFound` datetime DEFAULT NULL COMMENT '最后发现时间',
  `illegal_count` int(20) DEFAULT '0' COMMENT '违法数量',
  `illegal_info` varchar(255) DEFAULT NULL COMMENT '违法信息',
  `visitCount` bigint(20) DEFAULT '1' COMMENT '访问量',
  `protocol` int(11) DEFAULT '0' COMMENT '协议类型',
  `user` varchar(255) DEFAULT '' COMMENT '用户',
  `currentMsg` varchar(255) DEFAULT NULL COMMENT '处置备注',
  `handleTime` datetime DEFAULT NULL,
  `currentState` tinyint(1) DEFAULT '0' COMMENT '处置状态',
  PRIMARY KEY (`logId`),
  UNIQUE KEY `url` (`url`) USING HASH,
  KEY `domain` (`domain`),
  KEY `illegal_count` (`illegal_count`),
  KEY `illegal_info` (`illegal_info`),
  KEY `lastFound` (`lastFound`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_houseillegal
-- ----------------------------

-- ----------------------------
-- Table structure for idc_houseinfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_houseinfo`;
CREATE TABLE `idc_houseinfo` (
  `houseId` varchar(32) NOT NULL COMMENT '机房id',
  `houseName` varchar(128) NOT NULL DEFAULT '' COMMENT '机房名称',
  `houseType` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '机房性质',
  `houseProvince` varchar(6) NOT NULL DEFAULT '' COMMENT '所在省',
  `houseCity` varchar(6) NOT NULL DEFAULT '' COMMENT '所在市',
  `houseCounty` varchar(6) NOT NULL DEFAULT '' COMMENT '所在县',
  `houseAdd` varchar(128) NOT NULL DEFAULT '' COMMENT '机房地址',
  `houseZip` varchar(6) NOT NULL DEFAULT '' COMMENT '邮编',
  `houseOfficer` varchar(32) NOT NULL DEFAULT '' COMMENT '安全责任人',
  `status` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  PRIMARY KEY (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机房数据';

-- ----------------------------
-- Records of idc_houseinfo
-- ----------------------------

-- ----------------------------
-- Table structure for idc_houseinfo_ip
-- ----------------------------
DROP TABLE IF EXISTS `idc_houseinfo_ip`;
CREATE TABLE `idc_houseinfo_ip` (
  `houseId` varchar(32) DEFAULT NULL COMMENT '机房id',
  `houseIp` varchar(320) DEFAULT NULL COMMENT '机房ip',
  UNIQUE KEY `houseId` (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_houseinfo_ip
-- ----------------------------

-- ----------------------------
-- Table structure for idc_housemonitor
-- ----------------------------
DROP TABLE IF EXISTS `idc_housemonitor`;
CREATE TABLE `idc_housemonitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `houseid` varchar(32) NOT NULL DEFAULT '' COMMENT '机房id',
  `ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '应用服务IP（ipv4格式）',
  `ipv6` char(32) NOT NULL DEFAULT '' COMMENT '应用服务IP（ipv6格式）',
  `port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '端口',
  `domain` varchar(255) NOT NULL DEFAULT '' COMMENT '域名',
  `servicetype` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '服务类型',
  `firstfound` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '首次发现时间',
  `lastfound` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次发现时间',
  `visitCount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '协议',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '数据库处理单位',
  `illegaltype` smallint(6) NOT NULL DEFAULT '999' COMMENT '违法违规情况',
  `currentstate` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前状态',
  `user` varchar(128) NOT NULL DEFAULT 'ISMS' COMMENT '处置人',
  `icperror` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '备案异常 登记异常',
  `regerror` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '违法违规情况',
  `regdomain` varchar(128) NOT NULL DEFAULT '' COMMENT '登记域名',
  `truedomain` varchar(128) NOT NULL DEFAULT '' COMMENT '实际域名',
  `regtype` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '登记使用方式',
  `truetype` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '实际使用方式',
  `handletime` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `web_flag` int(11) NOT NULL DEFAULT '0' COMMENT '页面操作标志(0-页面未操作记录；1-页面操作过的新增记录)',
  PRIMARY KEY (`id`),
  KEY `ipv4` (`ipv4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机房监测数据';

-- ----------------------------
-- Records of idc_housemonitor
-- ----------------------------

-- ----------------------------
-- Table structure for idc_house_back
-- ----------------------------
DROP TABLE IF EXISTS `idc_house_back`;
CREATE TABLE `idc_house_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `backId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '核验号',
  `houseId` varchar(32) NOT NULL DEFAULT '' COMMENT '所属机房id',
  `gatewayId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '互联网出入口信息id',
  `ipSegId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'IP地址段信息id',
  `frameInfoId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '机架信息id',
  PRIMARY KEY (`id`),
  KEY `backId` (`backId`),
  KEY `houseId` (`houseId`),
  KEY `gatewayId` (`gatewayId`),
  KEY `ipSegId` (`ipSegId`),
  KEY `frameInfoId` (`frameInfoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机房数据退回';

-- ----------------------------
-- Records of idc_house_back
-- ----------------------------

-- ----------------------------
-- Table structure for idc_info
-- ----------------------------
DROP TABLE IF EXISTS `idc_info`;
CREATE TABLE `idc_info` (
  `idcId` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `idcName` varchar(128) NOT NULL DEFAULT '' COMMENT '经营者名称',
  `idcAdd` varchar(128) NOT NULL DEFAULT '' COMMENT '通讯地址',
  `idcZip` varchar(6) NOT NULL DEFAULT '' COMMENT '邮编',
  `corp` varchar(128) NOT NULL DEFAULT '' COMMENT '企业法人',
  `idcOfficer` varchar(32) NOT NULL DEFAULT '' COMMENT '网络信息安全责任人',
  `emergencyContact` varchar(32) NOT NULL DEFAULT '' COMMENT '应急联系人',
  PRIMARY KEY (`idcId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='经营单位信息';

-- ----------------------------
-- Table structure for idc_infomanage
-- ----------------------------
DROP TABLE IF EXISTS `idc_infomanage`;
CREATE TABLE `idc_infomanage` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '指令类型',
  `querymonitordayfrom` varchar(10) NOT NULL DEFAULT '' COMMENT '查询的监测数据起止日期',
  `querymonitordayto` varchar(10) NOT NULL DEFAULT '' COMMENT '查询的监测数据结束日期',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `userid` text NOT NULL COMMENT '用户id',
  `houseid` text NOT NULL COMMENT '机房id',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '生成时间',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基础数据管理指令';

-- ----------------------------
-- Records of idc_infomanage
-- ----------------------------

-- ----------------------------
-- Table structure for idc_info_back
-- ----------------------------
DROP TABLE IF EXISTS `idc_info_back`;
CREATE TABLE `idc_info_back` (
  `backId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '核验号',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '核验结果',
  `returnMsg` varchar(512) NOT NULL DEFAULT '' COMMENT '核验信息',
  `timestamp` varchar(19) NOT NULL DEFAULT '' COMMENT '核验时间',
  PRIMARY KEY (`backId`),
  KEY `returnCode` (`returnCode`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基础数据退回';

-- ----------------------------
-- Records of idc_info_back
-- ----------------------------

-- ----------------------------
-- Table structure for idc_ipseg
-- ----------------------------
DROP TABLE IF EXISTS `idc_ipseg`;
CREATE TABLE `idc_ipseg` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `hhID` bigint(20) NOT NULL DEFAULT '0' COMMENT '其他用户占用机房信息id',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '所属用户id',
  `startIp` varchar(64) NOT NULL DEFAULT '' COMMENT '起始IP地址',
  `endIp` varchar(64) NOT NULL DEFAULT '' COMMENT '终止IP地址',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `hhID` (`hhID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IP地址段';

-- ----------------------------
-- Records of idc_ipseg
-- ----------------------------

-- ----------------------------
-- Table structure for idc_ipseginfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_ipseginfo`;
CREATE TABLE `idc_ipseginfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `houseId` varchar(32) NOT NULL DEFAULT '' COMMENT '机房id',
  `startIp` varchar(64) NOT NULL DEFAULT '' COMMENT '起始IP地址',
  `endIp` varchar(64) NOT NULL DEFAULT '' COMMENT '终止IP地址',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '使用方式',
  `user` varchar(128) NOT NULL DEFAULT '' COMMENT '使用人',
  `idType` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '证件类型',
  `idNumber` varchar(32) NOT NULL DEFAULT '' COMMENT '证件号码',
  `useTime` varchar(10) NOT NULL DEFAULT '' COMMENT '分配使用时间',
  `sourceUnit` varchar(128) NOT NULL DEFAULT '' COMMENT '来源单位',
  `allocationUnit` varchar(128) NOT NULL DEFAULT '' COMMENT '分配单位',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  PRIMARY KEY (`id`),
  KEY `houseId` (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IP地址段信息';

-- ----------------------------
-- Records of idc_ipseginfo
-- ----------------------------

-- ----------------------------
-- Table structure for idc_iptrans
-- ----------------------------
DROP TABLE IF EXISTS `idc_iptrans`;
CREATE TABLE `idc_iptrans` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `hhID` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户占用机房信息id',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '所属用户id',
  `internetIp_StartIp` varchar(64) NOT NULL DEFAULT '' COMMENT '互联网起始IP地址',
  `internetIp_EndIp` varchar(64) NOT NULL DEFAULT '' COMMENT '互联网终止IP地址',
  `netIp_StartIp` varchar(64) NOT NULL DEFAULT '' COMMENT '对应私网起始IP地址',
  `netIp_EndIp` varchar(64) NOT NULL DEFAULT '' COMMENT '对应私网终止IP地址',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `hhID` (`hhID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IP地址转换信息';

-- ----------------------------
-- Records of idc_iptrans
-- ----------------------------

-- ----------------------------
-- Table structure for idc_jfxz
-- ----------------------------
DROP TABLE IF EXISTS `idc_jfxz`;
CREATE TABLE `idc_jfxz` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '机房性质',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机房性质';

-- ----------------------------
-- Records of idc_jfxz
-- ----------------------------
INSERT INTO `idc_jfxz` VALUES ('1', '租用', '', '1');
INSERT INTO `idc_jfxz` VALUES ('2', '自建', '', '1');
INSERT INTO `idc_jfxz` VALUES ('999', '其他', '', '1');

-- ----------------------------
-- Table structure for idc_jrfs
-- ----------------------------
DROP TABLE IF EXISTS `idc_jrfs`;
CREATE TABLE `idc_jrfs` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '接入方式',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接入方式';

-- ----------------------------
-- Records of idc_jrfs
-- ----------------------------
INSERT INTO `idc_jrfs` VALUES ('0', '专线', '', '1');
INSERT INTO `idc_jrfs` VALUES ('1', '虚拟主机', '', '1');
INSERT INTO `idc_jrfs` VALUES ('2', '主机托管', '', '1');
INSERT INTO `idc_jrfs` VALUES ('3', '整机租用', '', '1');
INSERT INTO `idc_jrfs` VALUES ('999', '其他', '', '1');

-- ----------------------------
-- Table structure for idc_keyphrases
-- ----------------------------
DROP TABLE IF EXISTS `idc_keyphrases`;
CREATE TABLE `idc_keyphrases` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL DEFAULT '' COMMENT '关键词组名称',
  `state` tinyint(1) DEFAULT '1' COMMENT '状态',
  `class_id` int(11) NOT NULL DEFAULT '0' COMMENT '父类id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_keyphrases
-- ----------------------------

-- ----------------------------
-- Table structure for idc_keywords
-- ----------------------------
DROP TABLE IF EXISTS `idc_keywords`;
CREATE TABLE `idc_keywords` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关键词id',
  `keyword` varchar(255) NOT NULL DEFAULT '' COMMENT '关键词名称',
  `matching` int(20) DEFAULT '0' COMMENT '匹配次数',
  `state` int(10) DEFAULT '1' COMMENT '状态',
  `class_id` int(11) NOT NULL DEFAULT '1' COMMENT '关键词组id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `weight` int(20) DEFAULT '1' COMMENT '权重',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_keywords
-- ----------------------------

-- ----------------------------
-- Table structure for idc_logquery
-- ----------------------------
DROP TABLE IF EXISTS `idc_logquery`;
CREATE TABLE `idc_logquery` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '日志查询指令',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `houseid` varchar(32) NOT NULL DEFAULT '' COMMENT '机房id',
  `starttime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '起始时间',
  `endtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '终止时间',
  `src_ipv4start` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '源起始IP',
  `src_ipv4end` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '源终止IP',
  `dst_ipv4start` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '目的起始IP',
  `dst_ipv4end` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '目的终止IP',
  `src_ipv6start` char(32) NOT NULL DEFAULT '' COMMENT '源起始IP',
  `src_ipv6end` char(32) NOT NULL DEFAULT '' COMMENT '源终止IP',
  `dst_ipv6start` char(32) NOT NULL DEFAULT '' COMMENT '目的起始IP',
  `dst_ipv6end` char(32) NOT NULL DEFAULT '' COMMENT '目的终止IP',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源端口',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '目的端口',
  `url` text NOT NULL COMMENT 'url',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `protocolType` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型',
  `timestamp` varchar(19) NOT NULL DEFAULT '' COMMENT '生成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问日志查询指令';

-- ----------------------------
-- Records of idc_logquery
-- ----------------------------

-- ----------------------------
-- Table structure for idc_nofilter
-- ----------------------------
DROP TABLE IF EXISTS `idc_nofilter`;
CREATE TABLE `idc_nofilter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '指令类型',
  `contents` varchar(128) NOT NULL DEFAULT '' COMMENT '指令内容',
  `level` smallint(6) unsigned NOT NULL DEFAULT '2048' COMMENT '规则优先级',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `local` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1',
  PRIMARY KEY (`id`),
  KEY `commandid` (`commandid`),
  KEY `type` (`type`),
  KEY `level` (`level`),
  KEY `add_time` (`add_time`),
  KEY `local` (`local`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='免过滤网站';

-- ----------------------------
-- Records of idc_nofilter
-- ----------------------------

-- ----------------------------
-- Table structure for idc_personinfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_personinfo`;
CREATE TABLE `idc_personinfo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `idType` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '证件类型',
  `idCode` varchar(32) NOT NULL DEFAULT '' COMMENT '证件号码',
  `tel` varchar(32) NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '移动电话',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT 'E-mail',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='安全责任人和应急联系人';

-- ----------------------------
-- Table structure for idc_queryview
-- ----------------------------
DROP TABLE IF EXISTS `idc_queryview`;
CREATE TABLE `idc_queryview` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `commandid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '指令id',
  `idcid` varchar(18) NOT NULL DEFAULT '' COMMENT '许可证号',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '查询类型',
  `contents` varchar(512) NOT NULL DEFAULT '' COMMENT '查询内容',
  `queryTime` varchar(19) NOT NULL DEFAULT '' COMMENT '截至时间',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '下发时间',
  PRIMARY KEY (`id`),
  KEY `commandid` (`commandid`),
  KEY `type` (`type`),
  KEY `queryTime` (`queryTime`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活跃资源访问量查询指令';

-- ----------------------------
-- Records of idc_queryview
-- ----------------------------

-- ----------------------------
-- Table structure for idc_returncode
-- ----------------------------
DROP TABLE IF EXISTS `idc_returncode`;
CREATE TABLE `idc_returncode` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(64) NOT NULL DEFAULT '' COMMENT '返回结果名称',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='核验数据退回代码';

-- ----------------------------
-- Records of idc_returncode
-- ----------------------------
INSERT INTO `idc_returncode` VALUES ('0', '上报记录通过核验', '', '1');
INSERT INTO `idc_returncode` VALUES ('1', '上报数据与既有数据冲突', '', '1');
INSERT INTO `idc_returncode` VALUES ('2', '上报数据内容不完整', '', '1');
INSERT INTO `idc_returncode` VALUES ('3', '上报数据内容错误', '', '1');
INSERT INTO `idc_returncode` VALUES ('4', '其他原因退回', '', '1');

-- ----------------------------
-- Table structure for idc_server
-- ----------------------------
DROP TABLE IF EXISTS `idc_server`;
CREATE TABLE `idc_server` (
  `spotId` bigint(20) NOT NULL AUTO_INCREMENT,
  `spotType` varchar(128) NOT NULL DEFAULT '' COMMENT '设备名称',
  `spotModel` varchar(128) NOT NULL DEFAULT '' COMMENT '设备型号',
  `houseId` bigint(20) DEFAULT NULL COMMENT '机房id',
  `spotIp` varchar(100) DEFAULT NULL COMMENT '节点ip',
  `port` int(20) DEFAULT NULL COMMENT '端口',
  `user` varchar(100) DEFAULT '' COMMENT '用户名',
  `pass` varchar(100) DEFAULT '' COMMENT '密码',
  `cpu` decimal(10,2) DEFAULT NULL COMMENT 'cpu',
  `memorytotal` int(20) DEFAULT NULL,
  `memoryused` int(20) DEFAULT NULL,
  `memoryfree` int(20) DEFAULT NULL,
  `memorybuffer` int(20) DEFAULT NULL,
  `flow` int(20) DEFAULT NULL,
  `syn` int(5) DEFAULT 0 COMMENT '同步状态',
  `appState` int(5) DEFAULT 0 COMMENT '运行状态',
  `msg` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `pktfilter` varchar(50) DEFAULT NULL,
  `block_status` tinyint(5) DEFAULT NULL,
  `block_message` text DEFAULT NULL,
  `inFlow` decimal(10,2) DEFAULT NULL,
  `outFlow` decimal(10,2) DEFAULT NULL,
  `linkType` tinyint(1) DEFAULT 1,
  `linkState` tinyint(1) DEFAULT 0,
  `license` varchar(50) DEFAULT NULL,
  `interface` varchar(50) DEFAULT NULL,
  `manageip` varchar(50) DEFAULT NULL,
  `testip` text DEFAULT NULL,
  `SyncUrl` varchar(2048) DEFAULT NULL COMMENT '接口地址',
  `passwd` varchar(50) DEFAULT '' COMMENT '身份认证密码',
  `encryptAlgorithm` tinyint(2) DEFAULT 1 COMMENT '加密算法',
  `AESKey` varchar(20) DEFAULT NULL COMMENT '数据加密密钥',
  `AESOffset` varchar(20) DEFAULT NULL COMMENT '加密密钥偏移量',
  `hashAlgorithm` tinyint(2) DEFAULT 1 COMMENT '哈希算法',
  `compressionFormat` tinyint(2) DEFAULT 1 COMMENT '压缩格式',
  `authenticationkey` varchar(50) DEFAULT '' COMMENT '用户认证密码',
  `isp_sync_mode` tinyint(2) DEFAULT 1 COMMENT '同步模式',
  `report_limit` int(10) DEFAULT 1000,
  `report_rate` int(10) DEFAULT 10,
  `com_version` varchar(20) DEFAULT '',
  `wsdlUrl` varchar(255) NOT NULL DEFAULT '' COMMENT '指令接口',
  PRIMARY KEY (`spotId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idc_synclogs
-- ----------------------------
DROP TABLE IF EXISTS `idc_synclogs`;
CREATE TABLE `idc_synclogs` (
 `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
 `euId` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
 `syncMsg` MEDIUMTEXT NOT NULL COMMENT '同步信息' COLLATE 'utf8_general_ci',
 `syncType` TINYINT(1) UNSIGNED NULL DEFAULT '0' COMMENT '1关键词，2关键词库，3eu配置信息',
 `syncTime` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '同步时间',
 `syncStatus` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0未成功，1成功',
 `fileId` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'idc_download_file文件对应id',
 PRIMARY KEY (`id`) USING BTREE
)COMMENT='eu同步日志' COLLATE='utf8_general_ci' ENGINE=InnoDB AUTO_INCREMENT=1;

-- ----------------------------
-- Table structure for idc_serviceinfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_serviceinfo`;
CREATE TABLE `idc_serviceinfo` (
  `serviceId` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '服务信息id',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属用户id',
  `serviceContent` text NOT NULL COMMENT '服务内容',
  `regType` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '备案类型',
  `regId` varchar(64) NOT NULL DEFAULT '' COMMENT '备案/许可证号',
  `setMode` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '接入方式',
  `business` tinyint(1) NOT NULL DEFAULT '0' COMMENT '业务类型',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  `lineNumber` varchar(32) DEFAULT '' COMMENT '线路编号',
  `businessType` int(11) DEFAULT '1' COMMENT '专线业务类型',
  `houseProvince` varchar(6) DEFAULT '' COMMENT '专线接入所在省或直辖市',
  `houseCity` varchar(6) DEFAULT '' COMMENT '专线接入所在所在市或区（县）',
  `houseCounty` varchar(6) DEFAULT '' COMMENT '专线接入所在所在县',
  `registerDate` varchar(10) DEFAULT '' COMMENT '专线注册时间',
  `expireDate` varchar(10) DEFAULT '' COMMENT '专线到期时间',
  PRIMARY KEY (`serviceId`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务信息';

-- ----------------------------
-- Records of idc_serviceinfo
-- ----------------------------

-- ----------------------------
-- Table structure for idc_sitemonitor
-- ----------------------------
DROP TABLE IF EXISTS `idc_sitemonitor`;
CREATE TABLE `idc_sitemonitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `houseid` varchar(32) NOT NULL DEFAULT '' COMMENT '机房id',
  `ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '应用服务IP（ipv4格式）',
  `ipv6` varchar(50) NOT NULL DEFAULT '' COMMENT '应用服务IP（ipv6格式）',
  `port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '端口',
  `domain` varchar(255) NOT NULL DEFAULT '' COMMENT '域名',
  `servicetype` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '服务类型',
  `firstfound` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '首次发现时间',
  `lastfound` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次发现时间',
  `visitCount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '协议',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '数据库处理单位',
  `illegaltype` smallint(6) NOT NULL DEFAULT '999' COMMENT '违法违规情况',
  `currentstate` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前状态',
  `user` varchar(128) NOT NULL DEFAULT 'ISMS' COMMENT '处置人',
  `icperror` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '备案异常 登记异常',
  `regerror` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '违法违规情况',
  `regdomain` varchar(128) NOT NULL DEFAULT '' COMMENT '登记域名',
  `truedomain` varchar(128) NOT NULL DEFAULT '' COMMENT '实际域名',
  `handletime` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `bei_an_web_flag` int(11) NOT NULL DEFAULT '0' COMMENT '页面操作标志(0-页面未操作记录；1-页面操作过的新增记录)',
  `gong_hei_web_flag` int(11) NOT NULL DEFAULT '0' COMMENT '页面操作标志(0-页面未操作记录；1-页面操作过的新增记录)',
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`),
  KEY `currentstate` (`currentstate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法违规网站管理';

-- ----------------------------
-- Records of idc_sitemonitor
-- ----------------------------

-- ----------------------------
-- Table structure for idc_upload_file
-- ----------------------------
DROP TABLE IF EXISTS `idc_upload_file`;
CREATE TABLE `idc_upload_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `ctype` tinyint(6) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `filename_de` varchar(255) NOT NULL DEFAULT '',
  `filepath` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `filesize` int(11) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `resultcode` int(10) NOT NULL DEFAULT '-1' COMMENT '结果',
  `content` varchar(1024) NOT NULL DEFAULT '' COMMENT '内容',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '下发时间',
  PRIMARY KEY (`id`),
  KEY `ctype` (`ctype`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上报文件列表';

-- ----------------------------
-- Records of idc_upload_file
-- ----------------------------

-- ----------------------------
-- Table structure for idc_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `idc_userinfo`;
CREATE TABLE `idc_userinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `nature` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户属性',
  `unitName` varchar(128) NOT NULL DEFAULT '' COMMENT '单位名称',
  `unitNature` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '单位属性',
  `idType` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '证件类型',
  `idNumber` varchar(32) NOT NULL DEFAULT '' COMMENT '证件号码',
  `officer` varchar(32) NOT NULL DEFAULT '' COMMENT '责任人',
  `add` varchar(128) NOT NULL DEFAULT '' COMMENT '单位地址',
  `zipCode` varchar(6) NOT NULL DEFAULT '' COMMENT '邮政编码',
  `registerTime` varchar(10) NOT NULL DEFAULT '' COMMENT '注册时间',
  `serviceRegTime` varchar(10) NOT NULL DEFAULT '' COMMENT '服务开通时间',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '9',
  `remark` varchar(255) DEFAULT '' COMMENT '备注说明',
  PRIMARY KEY (`id`),
  UNIQUE KEY ` unitName` (`unitName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户数据';

-- ----------------------------
-- Records of idc_userinfo
-- ----------------------------

-- ----------------------------
-- Table structure for idc_user_back
-- ----------------------------
DROP TABLE IF EXISTS `idc_user_back`;
CREATE TABLE `idc_user_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `backId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '核验号',
  `userId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `serviceId` bigint(20) NOT NULL DEFAULT '0' COMMENT '服务信息id',
  `domainId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '域名信id',
  `hhID` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户占用机房信息id',
  PRIMARY KEY (`id`),
  KEY `backId` (`backId`),
  KEY `userId` (`userId`),
  KEY `serviceId` (`serviceId`),
  KEY `domainId` (`domainId`),
  KEY `hhID` (`hhID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户数据退回';

-- ----------------------------
-- Records of idc_user_back
-- ----------------------------

-- ----------------------------
-- Table structure for idc_virtualserver
-- ----------------------------
DROP TABLE IF EXISTS `idc_virtualserver`;
CREATE TABLE `idc_virtualserver` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `hhID` bigint(20) NOT NULL DEFAULT '0' COMMENT '占用机房信息id',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `virtualhostName` varchar(128) NOT NULL DEFAULT '' COMMENT '虚拟主机名称',
  `virtualhostState` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '虚拟主机状态',
  `virtualhostType` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '虚拟主机类型',
  `virtualhostAddress` varchar(128) NOT NULL DEFAULT '' COMMENT '虚拟主机网络地址',
  `virtualhostManagementAddress` varchar(128) NOT NULL DEFAULT '' COMMENT '虚拟主机管理地址',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `hhID` (`hhID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟主机信息';

-- ----------------------------
-- Records of idc_virtualserver
-- ----------------------------

-- ----------------------------
-- Table structure for idc_wfwgqk
-- ----------------------------
DROP TABLE IF EXISTS `idc_wfwgqk`;
CREATE TABLE `idc_wfwgqk` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '违法违规情况名称',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法违规情况';

-- ----------------------------
-- Records of idc_wfwgqk
-- ----------------------------
INSERT INTO `idc_wfwgqk` VALUES ('0', '正常', '正常网站', '1');
INSERT INTO `idc_wfwgqk` VALUES ('1', '未备案', '相应网站属未备案', '1');
INSERT INTO `idc_wfwgqk` VALUES ('2', '违法网站', '相应网站属于违法网站', '1');
INSERT INTO `idc_wfwgqk` VALUES ('999', '其他', '其他违法违规类型', '1');

-- ----------------------------
-- Table structure for idc_whitelist
-- ----------------------------
DROP TABLE IF EXISTS `idc_whitelist`;
CREATE TABLE `idc_whitelist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '处置ID',
  `domain` varchar(256) NOT NULL DEFAULT '' COMMENT '域名链接',
  `level` int(20) DEFAULT '2048' COMMENT '优先级',
  `state` tinyint(1) unsigned zerofill DEFAULT '1' COMMENT '状态',
  `class_id` int(10) NOT NULL DEFAULT '1' COMMENT '分类ID',
  `source` tinyint(2) DEFAULT '0' COMMENT '记录来源ID',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '处置时间',
  `expiredTime` int(11) DEFAULT NULL COMMENT '过期时间',
  `user` varchar(255) DEFAULT '' COMMENT '操作用户',
  `remark` varchar(255) DEFAULT NULL,
  `log` tinyint(1) DEFAULT '0' COMMENT '日志',
  `is_sync` tinyint(1) DEFAULT '0' COMMENT '是否同步0-未同步 1已同步',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of idc_whitelist
-- ----------------------------

-- ----------------------------
-- Table structure for idc_zjlx
-- ----------------------------
DROP TABLE IF EXISTS `idc_zjlx`;
CREATE TABLE `idc_zjlx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `mc` varchar(32) NOT NULL DEFAULT '' COMMENT '证件类型名称',
  `bz` varchar(64) NOT NULL DEFAULT '' COMMENT '备注',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='证件类型';

-- ----------------------------
-- Records of idc_zjlx
-- ----------------------------
INSERT INTO `idc_zjlx` VALUES ('1', '工商营业执照号码', '', '1');
INSERT INTO `idc_zjlx` VALUES ('2', '身份证', '', '1');
INSERT INTO `idc_zjlx` VALUES ('3', '组织机构代码证书', '', '1');
INSERT INTO `idc_zjlx` VALUES ('4', '事业法人证书', '', '1');
INSERT INTO `idc_zjlx` VALUES ('5', '军队代号', '', '1');
INSERT INTO `idc_zjlx` VALUES ('6', '社团法人证书', '', '1');
INSERT INTO `idc_zjlx` VALUES ('7', '护照', '', '1');
INSERT INTO `idc_zjlx` VALUES ('8', '军官证', '', '1');
INSERT INTO `idc_zjlx` VALUES ('9', '台胞证', '', '1');
INSERT INTO `idc_zjlx` VALUES ('10', '其他', '', '1');

-- ----------------------------
-- Table structure for monitorlog_local
-- ----------------------------
DROP TABLE IF EXISTS `monitorlog_local`;
CREATE TABLE `monitorlog_local` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `cid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '管理指令',
  `data` text NOT NULL,
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '源IP（ipv4格式）',
  `dst_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '目的IP（ipv4格式）',
  `src_ipv6` char(32) NOT NULL DEFAULT '' COMMENT '源IP（ipv6格式）',
  `dst_ipv6` char(32) NOT NULL DEFAULT '' COMMENT '目的IP（ipv6格式）',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源端口',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '目的端口',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `protocol` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型',
  `service` int(6) NOT NULL DEFAULT '0' COMMENT '协议',
  `report` tinyint(1) NOT NULL DEFAULT '1',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  `contentType` varchar(32) DEFAULT '' COMMENT '访问内容类型',
  `applicationProtocol` varchar(6) NOT NULL DEFAULT '2000' COMMENT '应用协议类型',
  PRIMARY KEY (`id`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='监测日志';

-- ----------------------------
-- Records of monitorlog_local
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_auth
-- ----------------------------
INSERT INTO `sys_auth` VALUES ('1', '超级管理员', 'all', '1374661035', '1', 'admin', '1');
INSERT INTO `sys_auth` VALUES ('2', '测试', '5,6,7', '1531708447', '0', '', '1');

-- ----------------------------
-- Table structure for sys_conf
-- ----------------------------
DROP TABLE IF EXISTS `sys_conf`;
CREATE TABLE `sys_conf` (
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '参数设置名',
  `value` text NOT NULL COMMENT '参数设置值',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of sys_conf
-- ----------------------------
INSERT INTO `sys_conf` VALUES ('basic_monitor_polity', '0');
INSERT INTO `sys_conf` VALUES ('jfind_interval', '60');
INSERT INTO `sys_conf` VALUES ('log_save', '7');
INSERT INTO `sys_conf` VALUES ('upload_log', '0');
INSERT INTO `sys_conf` VALUES ('upload_save_days', '30');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
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
