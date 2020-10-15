-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.23-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出  表 app_cdn.acclog_local 结构
CREATE TABLE IF NOT EXISTS `acclog_local` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0',
  `dst_ipv4` int(11) unsigned NOT NULL DEFAULT '0',
  `src_ipv6` varchar(50) NOT NULL DEFAULT '',
  `dst_ipv6` varchar(50) NOT NULL DEFAULT '',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0',
  `src_mac` varchar(48) NOT NULL DEFAULT '',
  `dst_mac` varchar(48) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `service` int(6) unsigned NOT NULL DEFAULT '0',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `src_ipv4` (`src_ipv4`),
  KEY `dst_ipv4` (`dst_ipv4`),
  KEY `src_port` (`src_port`),
  KEY `dst_port` (`dst_port`),
  KEY `protocol` (`protocol`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问日志';

-- 正在导出表  app_cdn.acclog_local 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `acclog_local` DISABLE KEYS */;
/*!40000 ALTER TABLE `acclog_local` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_all_packet 结构
CREATE TABLE IF NOT EXISTS `cdn_all_packet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '源IP（ipv4格式）',
  `dst_ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '目的IP（ipv4格式）',
  `src_ipv6` varchar(50) NOT NULL DEFAULT '20190304 changlq add 源IP（ipv6格式）',
  `dst_ipv6` varchar(50) NOT NULL DEFAULT '20190304 changlq add 目的IP（ipv6格式）',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源端口',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '目的端口',
  `src_mac` varchar(20) NOT NULL DEFAULT '' COMMENT '源mac地址',
  `dst_mac` varchar(20) NOT NULL DEFAULT '' COMMENT '目的mac地址',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `domain` varchar(255) NOT NULL DEFAULT '' COMMENT '域名',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `service` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '协议',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  `tv_usec` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间(微秒)',
  `ip_type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add IP类型（默认源和目的的IP类型一致:4---ipv4;6-----ipv6）',
  PRIMARY KEY (`id`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='20190704 changlq create 全量数据包（MGetPacket入表,MScanCntrl读取,赋值,删除,并发处理）';

-- 正在导出表  app_cdn.cdn_all_packet 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_all_packet` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_all_packet` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_blacklist 结构
CREATE TABLE IF NOT EXISTS `cdn_blacklist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` int(11) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `operationType` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `contents` varchar(128) NOT NULL DEFAULT '',
  `level` smallint(6) unsigned NOT NULL DEFAULT '2048',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `timeStamp` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `timeStamp` (`timeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法网站列表指令';

-- 正在导出表  app_cdn.cdn_blacklist 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_blacklist` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_black_list 结构
CREATE TABLE IF NOT EXISTS `cdn_black_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `commandid` bigint(20) unsigned NOT NULL COMMENT '关联规则表',
  `code` int(11) unsigned NOT NULL COMMENT '时间戳验证码',
  `tv_usec` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间(微秒)',
  `src_ipv4` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源IP',
  `src_port` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '源端口',
  `dst_ipv4` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '目的IP',
  `dst_port` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '目的端口',
  `protocol` char(20) NOT NULL DEFAULT '' COMMENT '协议',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='20190704 changlq create ROS本地黑名单';

-- 正在导出表  app_cdn.cdn_black_list 的数据：0 rows
/*!40000 ALTER TABLE `cdn_black_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_black_list` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_cdnnetinfo 结构
CREATE TABLE IF NOT EXISTS `cdn_cdnnetinfo` (
  `cdnNetId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topDomain` varchar(128) NOT NULL DEFAULT '',
  `regId` varchar(64) NOT NULL DEFAULT '',
  `domainId` text,
  PRIMARY KEY (`cdnNetId`),
  KEY `topDomain` (`topDomain`),
  KEY `regId` (`regId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cdn子网信息';

-- 正在导出表  app_cdn.cdn_cdnnetinfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_cdnnetinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_cdnnetinfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_command 结构
CREATE TABLE IF NOT EXISTS `cdn_command` (
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reason` varchar(128) NOT NULL DEFAULT '',
  `log` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `report` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `effectTime` int(11) unsigned NOT NULL DEFAULT '0',
  `expiredTime` int(11) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `owner` varchar(32) NOT NULL DEFAULT '',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `level` smallint(6) unsigned NOT NULL DEFAULT '2048',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `backType` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`commandId`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法信息监测过滤指令';

-- 正在导出表  app_cdn.cdn_command 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_command` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_command` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_commandack 结构
CREATE TABLE IF NOT EXISTS `cdn_commandack` (
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `cdnNetId` int(10) unsigned NOT NULL DEFAULT '0',
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `resultcode` smallint(6) unsigned NOT NULL DEFAULT '0',
  `msgInfo` varchar(128) NOT NULL DEFAULT '',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  `backcode` smallint(6) unsigned NOT NULL DEFAULT '0',
  `msg` varchar(128) NOT NULL DEFAULT '',
  KEY `resultcode` (`resultcode`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指令执行情况';

-- 正在导出表  app_cdn.cdn_commandack 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_commandack` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_commandack` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_commandack_test 结构
CREATE TABLE IF NOT EXISTS `cdn_commandack_test` (
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `cdnNetId` int(10) unsigned NOT NULL DEFAULT '0',
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `resultcode` smallint(6) unsigned NOT NULL DEFAULT '0',
  `msgInfo` varchar(128) NOT NULL DEFAULT '',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  `backcode` smallint(6) unsigned NOT NULL DEFAULT '0',
  `msg` varchar(128) NOT NULL DEFAULT '',
  KEY `resultcode` (`resultcode`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='20190704 changlq create 指令执行情况（规则五万）';

-- 正在导出表  app_cdn.cdn_commandack_test 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_commandack_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_commandack_test` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_commandback 结构
CREATE TABLE IF NOT EXISTS `cdn_commandback` (
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `effectTime` int(11) unsigned NOT NULL DEFAULT '0',
  `content` varchar(1000) NOT NULL DEFAULT '',
  `timeStamp` int(11) unsigned NOT NULL DEFAULT '0',
  `feedBackResult` tinyint(1) NOT NULL DEFAULT '0',
  `back_content` varchar(1000) NOT NULL DEFAULT '',
  `back_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`commandId`),
  KEY `feedBackResult` (`feedBackResult`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法管理指令申诉及反馈';

-- 正在导出表  app_cdn.cdn_commandback 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_commandback` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_commandback` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_commandrecord_count 结构
CREATE TABLE IF NOT EXISTS `cdn_commandrecord_count` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `count` int(11) unsigned NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `type` (`type`),
  KEY `count` (`count`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法管理指令执行记录指令统计';

-- 正在导出表  app_cdn.cdn_commandrecord_count 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_commandrecord_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_commandrecord_count` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_command_cdnnet 结构
CREATE TABLE IF NOT EXISTS `cdn_command_cdnnet` (
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  KEY `commandId` (`commandId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理指令生效cdn子网范围';

-- 正在导出表  app_cdn.cdn_command_cdnnet 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_command_cdnnet` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_command_cdnnet` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_command_cdnnet_test 结构
CREATE TABLE IF NOT EXISTS `cdn_command_cdnnet_test` (
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  KEY `commandId` (`commandId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='20190704 changlq create 管理指令生效cdn子网范围（规则五万）';

-- 正在导出表  app_cdn.cdn_command_cdnnet_test 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_command_cdnnet_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_command_cdnnet_test` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_command_rule 结构
CREATE TABLE IF NOT EXISTS `cdn_command_rule` (
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `subtype` tinyint(1) NOT NULL DEFAULT '0',
  `valueStart` varchar(128) NOT NULL DEFAULT '',
  `valueEnd` varchar(128) NOT NULL DEFAULT '',
  `keywordRange` varchar(32) NOT NULL DEFAULT '',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  KEY `subtype` (`subtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理指令规则';

-- 正在导出表  app_cdn.cdn_command_rule 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_command_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_command_rule` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_command_rule_test 结构
CREATE TABLE IF NOT EXISTS `cdn_command_rule_test` (
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `subtype` tinyint(1) NOT NULL DEFAULT '0',
  `valueStart` varchar(128) NOT NULL DEFAULT '',
  `valueEnd` varchar(128) NOT NULL DEFAULT '',
  `keywordRange` varchar(32) NOT NULL DEFAULT '',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  KEY `subtype` (`subtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='20190704 changlq create 管理指令规则（规则五万）';

-- 正在导出表  app_cdn.cdn_command_rule_test 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_command_rule_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_command_rule_test` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_command_test 结构
CREATE TABLE IF NOT EXISTS `cdn_command_test` (
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reason` varchar(128) NOT NULL DEFAULT '',
  `log` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `report` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `effectTime` int(11) unsigned NOT NULL DEFAULT '0',
  `expiredTime` int(11) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(18) NOT NULL DEFAULT '',
  `owner` varchar(32) NOT NULL DEFAULT '',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `level` smallint(6) unsigned NOT NULL DEFAULT '2048',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `backType` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`commandId`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='20190704 changlq create 违法信息监测过滤指令（规则五万）';

-- 正在导出表  app_cdn.cdn_command_test 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_command_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_command_test` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_customerinfo 结构
CREATE TABLE IF NOT EXISTS `cdn_customerinfo` (
  `customerId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `unitName` varchar(128) NOT NULL DEFAULT '',
  `unitNature` smallint(1) unsigned NOT NULL DEFAULT '0',
  `idType` smallint(1) unsigned NOT NULL DEFAULT '0',
  `idNumber` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(128) NOT NULL DEFAULT '',
  `registerTime` varchar(10) NOT NULL DEFAULT '',
  `officeId` int(11) unsigned NOT NULL DEFAULT '0',
  `linkOfficerInfoId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`customerId`),
  UNIQUE KEY ` unitName` (`unitName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户信息';

-- 正在导出表  app_cdn.cdn_customerinfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_customerinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_customerinfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_domaincache 结构
CREATE TABLE IF NOT EXISTS `cdn_domaincache` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `primary_icp` varchar(255) DEFAULT NULL,
  `site_icp` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`),
  KEY `time` (`time`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站备案查询';

-- 正在导出表  app_cdn.cdn_domaincache 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_domaincache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_domaincache` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_domaininfo 结构
CREATE TABLE IF NOT EXISTS `cdn_domaininfo` (
  `domainId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `serviceId` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `source` varchar(1024) NOT NULL DEFAULT '',
  `regId` varchar(64) NOT NULL DEFAULT '',
  `topDomain` varchar(128) NOT NULL DEFAULT '',
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`domainId`),
  KEY `serviceId` (`serviceId`),
  KEY `domain` (`domain`),
  KEY `topDomain` (`topDomain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='域名信息';

-- 正在导出表  app_cdn.cdn_domaininfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_domaininfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_domaininfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_download_file 结构
CREATE TABLE IF NOT EXISTS `cdn_download_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ctype` tinyint(6) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `filename_de` varchar(255) NOT NULL DEFAULT '',
  `filepath` varchar(255) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL DEFAULT '0',
  `resultcode` int(10) NOT NULL DEFAULT '0',
  `content` varchar(1024) NOT NULL DEFAULT '',
  `add_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ctype` (`ctype`),
  KEY `filename` (`filename`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口下载文件列表';

-- 正在导出表  app_cdn.cdn_download_file 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_download_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_download_file` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_dwsx 结构
CREATE TABLE IF NOT EXISTS `cdn_dwsx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `mc` varchar(32) NOT NULL DEFAULT '',
  `bz` varchar(64) NOT NULL DEFAULT '',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单位属性';

-- 正在导出表  app_cdn.cdn_dwsx 的数据：~7 rows (大约)
/*!40000 ALTER TABLE `cdn_dwsx` DISABLE KEYS */;
INSERT INTO `cdn_dwsx` (`id`, `mc`, `bz`, `sfyx`) VALUES
	(1, '军队', '', 1),
	(2, '政府机关', '', 1),
	(3, '事业单位', '', 1),
	(4, '企业', '', 1),
	(5, '个人', '', 1),
	(6, '社会团体', '', 1),
	(999, '其他', '', 1);
/*!40000 ALTER TABLE `cdn_dwsx` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_feedbacksuspiciousandexception 结构
CREATE TABLE IF NOT EXISTS `cdn_feedbacksuspiciousandexception` (
  `feedBackId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `cdnNetDomain` varchar(128) NOT NULL DEFAULT '',
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  `feedBackCdnNetMsg` varchar(1000) NOT NULL DEFAULT '',
  `processCdnNetMethod` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feedBackId`),
  KEY `commandId` (`commandId`),
  KEY `cdnNetDomain` (`cdnNetDomain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='疑似数据与异常数据反馈信息';

-- 正在导出表  app_cdn.cdn_feedbacksuspiciousandexception 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_feedbacksuspiciousandexception` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_feedbacksuspiciousandexception` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_feedback_soucedomain 结构
CREATE TABLE IF NOT EXISTS `cdn_feedback_soucedomain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `feedBackId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `pushDomainId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `domainId` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `source` varchar(128) NOT NULL DEFAULT '',
  `regId` varchar(64) NOT NULL DEFAULT '',
  `topDomain` varchar(128) NOT NULL DEFAULT '',
  `processType` tinyint(1) NOT NULL DEFAULT '0',
  `processMethod` tinyint(1) NOT NULL DEFAULT '0',
  `processMsg` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `feedBackId` (`feedBackId`),
  KEY `pushDomainId` (`pushDomainId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='反馈的域名';

-- 正在导出表  app_cdn.cdn_feedback_soucedomain 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_feedback_soucedomain` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_feedback_soucedomain` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_feedback_souceip 结构
CREATE TABLE IF NOT EXISTS `cdn_feedback_souceip` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `feedBackId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `pushIPId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `sourceIp` varchar(128) NOT NULL DEFAULT '',
  `processType` tinyint(1) NOT NULL DEFAULT '0',
  `processMethod` tinyint(1) NOT NULL DEFAULT '0',
  `processMsg` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `feedBackId` (`feedBackId`),
  KEY `pushIPId` (`pushIPId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='反馈的IP信息';

-- 正在导出表  app_cdn.cdn_feedback_souceip 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_feedback_souceip` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_feedback_souceip` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_filterresult 结构
CREATE TABLE IF NOT EXISTS `cdn_filterresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `srcIp` int(11) unsigned NOT NULL DEFAULT '0',
  `destIp` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `url` varchar(1024) NOT NULL DEFAULT '',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `srcIp` (`srcIp`),
  KEY `destIp` (`destIp`),
  KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法信息过滤记录';

-- 正在导出表  app_cdn.cdn_filterresult 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_filterresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_filterresult` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_frameinfo 结构
CREATE TABLE IF NOT EXISTS `cdn_frameinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `houseId` int(11) unsigned NOT NULL DEFAULT '0',
  `useType` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `frameName` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `houseId` (`houseId`),
  KEY `useType` (`useType`),
  KEY `frameName` (`frameName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机房链路信息';

-- 正在导出表  app_cdn.cdn_frameinfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_frameinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_frameinfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_fwnr 结构
CREATE TABLE IF NOT EXISTS `cdn_fwnr` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `mc` varchar(32) NOT NULL DEFAULT '',
  `fl` smallint(6) unsigned NOT NULL DEFAULT '0',
  `bz` varchar(64) NOT NULL DEFAULT '',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务内容';

-- 正在导出表  app_cdn.cdn_fwnr 的数据：~29 rows (大约)
/*!40000 ALTER TABLE `cdn_fwnr` DISABLE KEYS */;
INSERT INTO `cdn_fwnr` (`id`, `mc`, `fl`, `bz`, `sfyx`) VALUES
	(500, '基础应用', 0, '', 1),
	(501, '网络媒体', 0, '', 1),
	(502, '电子政务/电子商务', 0, '', 1),
	(503, '数字娱乐', 0, '', 1),
	(504, '其他', 0, '', 1),
	(1, '即时通信', 500, '', 1),
	(2, '搜索引擎', 500, '', 1),
	(3, '综合门户', 500, '', 1),
	(4, '网上邮局', 500, '', 1),
	(5, '网络新闻', 501, '', 1),
	(6, '博客/个人空间', 501, '', 1),
	(7, '网络广告/信息', 501, '', 1),
	(8, '单位门户网站', 501, '', 1),
	(9, '网络购物', 502, '', 1),
	(10, '网上支付', 502, '', 1),
	(11, '网上银行', 502, '', 1),
	(12, '网上炒股/股票基金', 502, '', 1),
	(13, '网络游戏', 503, '', 1),
	(14, '网络音乐', 503, '', 1),
	(15, '网络影视', 503, '', 1),
	(16, '网络图片', 503, '', 1),
	(17, '网络软件/下载', 503, '', 1),
	(18, '网上求职', 504, '', 1),
	(19, '网上交友/婚介', 504, '', 1),
	(20, '网上房产', 504, '', 1),
	(21, '网络教育', 504, '', 1),
	(22, '网站建设', 504, '', 1),
	(23, 'WAP', 504, '', 1),
	(24, '其他', 504, '', 1);
/*!40000 ALTER TABLE `cdn_fwnr` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_gatewayinfo 结构
CREATE TABLE IF NOT EXISTS `cdn_gatewayinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `houseId` int(11) unsigned NOT NULL DEFAULT '0',
  `bandWidth` int(11) unsigned NOT NULL DEFAULT '0',
  `linkType` int(11) unsigned NOT NULL DEFAULT '0',
  `linkTime` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `houseId` (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机房链路信息';

-- 正在导出表  app_cdn.cdn_gatewayinfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_gatewayinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_gatewayinfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_gzlx 结构
CREATE TABLE IF NOT EXISTS `cdn_gzlx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `mc` varchar(32) NOT NULL DEFAULT '',
  `bz` varchar(64) NOT NULL DEFAULT '',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='监测过滤规则类型';

-- 正在导出表  app_cdn.cdn_gzlx 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `cdn_gzlx` DISABLE KEYS */;
INSERT INTO `cdn_gzlx` (`id`, `mc`, `bz`, `sfyx`) VALUES
	(1, '域名', '', 1),
	(2, 'URL', '', 1),
	(3, '关键字', '', 1),
	(4, '源IP地址', '', 1),
	(5, '目的IP地址', '', 1),
	(6, '传输层协议', '', 1);
/*!40000 ALTER TABLE `cdn_gzlx` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_handlefeedbacksuspiciousandexception 结构
CREATE TABLE IF NOT EXISTS `cdn_handlefeedbacksuspiciousandexception` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `handleId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `feedBackId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `cdnNetDomain` varchar(128) NOT NULL DEFAULT '',
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  `handleCdnNetType` tinyint(1) NOT NULL DEFAULT '0',
  `handleCdnMsg` varchar(1000) NOT NULL DEFAULT '',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `handleId` (`handleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='疑似数据与异常数据反馈处理';

-- 正在导出表  app_cdn.cdn_handlefeedbacksuspiciousandexception 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_handlefeedbacksuspiciousandexception` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_handlefeedbacksuspiciousandexception` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_handlefeedback_sourcedomain 结构
CREATE TABLE IF NOT EXISTS `cdn_handlefeedback_sourcedomain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `handleId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `pushDomainId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `domainId` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `source` varchar(128) NOT NULL DEFAULT '',
  `regId` varchar(64) NOT NULL DEFAULT '',
  `topDomain` varchar(128) NOT NULL DEFAULT '',
  `handleType` tinyint(1) NOT NULL DEFAULT '0',
  `handleMsg` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `handleId` (`handleId`),
  KEY `pushDomainId` (`pushDomainId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='反馈处理的domain信息';

-- 正在导出表  app_cdn.cdn_handlefeedback_sourcedomain 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_handlefeedback_sourcedomain` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_handlefeedback_sourcedomain` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_handlefeedback_sourceip 结构
CREATE TABLE IF NOT EXISTS `cdn_handlefeedback_sourceip` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `handleId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `pushIPId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `sourceIp` varchar(128) NOT NULL DEFAULT '',
  `handleType` tinyint(1) NOT NULL DEFAULT '0',
  `handleMsg` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `handleId` (`handleId`),
  KEY `pushIPId` (`pushIPId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='反馈处理的IP信息';

-- 正在导出表  app_cdn.cdn_handlefeedback_sourceip 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_handlefeedback_sourceip` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_handlefeedback_sourceip` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_houseinfo 结构
CREATE TABLE IF NOT EXISTS `cdn_houseinfo` (
  `houseId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `houseName` varchar(256) NOT NULL DEFAULT '',
  `houseType` int(11) unsigned NOT NULL DEFAULT '0',
  `rentCompanyName` varchar(256) NOT NULL DEFAULT '',
  `rentCompanyIDCNum` varchar(256) NOT NULL DEFAULT '',
  `houseProvince` varchar(6) NOT NULL DEFAULT '',
  `houseCity` varchar(6) NOT NULL DEFAULT '',
  `houseCounty` varchar(6) NOT NULL DEFAULT '',
  `houseAdd` varchar(256) NOT NULL DEFAULT '',
  `houseZip` varchar(6) NOT NULL DEFAULT '',
  `venderName` varchar(128) NOT NULL DEFAULT '',
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`houseId`),
  KEY `houseName` (`houseName`(255)),
  KEY `houseType` (`houseType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CDN机房信息';

-- 正在导出表  app_cdn.cdn_houseinfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_houseinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_houseinfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_info 结构
CREATE TABLE IF NOT EXISTS `cdn_info` (
  `cdnId` varchar(18) NOT NULL DEFAULT '',
  `cdnName` varchar(128) NOT NULL DEFAULT '',
  `cdnAdd` varchar(128) NOT NULL DEFAULT '',
  `corp` varchar(128) NOT NULL DEFAULT '',
  `cdnOfficeId` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cdnId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='经营单位信息';

-- 正在导出表  app_cdn.cdn_info 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_info` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_infomanage 结构
CREATE TABLE IF NOT EXISTS `cdn_infomanage` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `customerId` varchar(16) NOT NULL DEFAULT '',
  `idNumber` varchar(256) NOT NULL DEFAULT '',
  `customerName` varchar(256) NOT NULL DEFAULT '',
  `queryAccount` varchar(128) NOT NULL DEFAULT '',
  `queryCompany` varchar(128) NOT NULL DEFAULT '',
  `queryCause` varchar(128) NOT NULL DEFAULT '',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基础数据查询指令数据格式';

-- 正在导出表  app_cdn.cdn_infomanage 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_infomanage` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_infomanage` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_ipseginfo 结构
CREATE TABLE IF NOT EXISTS `cdn_ipseginfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `houseId` int(11) unsigned NOT NULL DEFAULT '0',
  `startIp` varchar(128) NOT NULL DEFAULT '',
  `endIp` varchar(128) NOT NULL DEFAULT '',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `houseId` (`houseId`),
  KEY `startIp` (`startIp`),
  KEY `endIp` (`endIp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IP地址段信息';

-- 正在导出表  app_cdn.cdn_ipseginfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_ipseginfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_ipseginfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_jfxz 结构
CREATE TABLE IF NOT EXISTS `cdn_jfxz` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `mc` varchar(32) NOT NULL DEFAULT '',
  `bz` varchar(64) NOT NULL DEFAULT '',
  `sfyx` tinyint(6) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机房性质';

-- 正在导出表  app_cdn.cdn_jfxz 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `cdn_jfxz` DISABLE KEYS */;
INSERT INTO `cdn_jfxz` (`id`, `mc`, `bz`, `sfyx`) VALUES
	(1, '租用', '', 1),
	(2, '自建', '', 1),
	(999, '其他', '', 1);
/*!40000 ALTER TABLE `cdn_jfxz` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_linkofficerinfo 结构
CREATE TABLE IF NOT EXISTS `cdn_linkofficerinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `idType` int(1) unsigned NOT NULL DEFAULT '0',
  `credentialsId` varchar(32) NOT NULL DEFAULT '',
  `tel` varchar(32) NOT NULL DEFAULT '',
  `mobile` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='联系人信息';

-- 正在导出表  app_cdn.cdn_linkofficerinfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_linkofficerinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_linkofficerinfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_linktype 结构
CREATE TABLE IF NOT EXISTS `cdn_linktype` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='链路类型';

-- 正在导出表  app_cdn.cdn_linktype 的数据：~5 rows (大约)
/*!40000 ALTER TABLE `cdn_linktype` DISABLE KEYS */;
INSERT INTO `cdn_linktype` (`id`, `name`) VALUES
	(1, '电信'),
	(2, '联通'),
	(3, '移动'),
	(4, '铁通'),
	(9, '其他');
/*!40000 ALTER TABLE `cdn_linktype` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_logquery 结构
CREATE TABLE IF NOT EXISTS `cdn_logquery` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(18) NOT NULL DEFAULT '',
  `startTime` int(10) unsigned NOT NULL DEFAULT '0',
  `endTime` int(10) unsigned NOT NULL DEFAULT '0',
  `src_ipv4start` int(11) unsigned NOT NULL DEFAULT '0',
  `src_ipv4end` int(11) unsigned NOT NULL DEFAULT '0',
  `dst_ipv4start` int(11) unsigned NOT NULL DEFAULT '0',
  `dst_ipv4end` int(11) unsigned NOT NULL DEFAULT '0',
  `src_ipv6start` varchar(50) NOT NULL DEFAULT '',
  `src_ipv6end` varchar(50) NOT NULL DEFAULT '',
  `dst_ipv6start` varchar(50) NOT NULL DEFAULT '',
  `dst_ipv6end` varchar(50) NOT NULL DEFAULT '',
  `url` text NOT NULL,
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `protocolType` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问日志查询指令';

-- 正在导出表  app_cdn.cdn_logquery 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_logquery` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_logquery` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_monitorresult 结构
CREATE TABLE IF NOT EXISTS `cdn_monitorresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `srcIp` int(11) unsigned NOT NULL DEFAULT '0',
  `destIp` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `url` varchar(1024) NOT NULL DEFAULT '',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `srcIp` (`srcIp`),
  KEY `destIp` (`destIp`),
  KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法信息监测记录';

-- 正在导出表  app_cdn.cdn_monitorresult 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_monitorresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_monitorresult` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_net_link 结构
CREATE TABLE IF NOT EXISTS `cdn_net_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  `nodeId` int(11) unsigned NOT NULL DEFAULT '0',
  `upload` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cdnNetId` (`cdnNetId`),
  KEY `nodeId` (`nodeId`),
  KEY `upload` (`upload`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CDN子网关联关系表';

-- 正在导出表  app_cdn.cdn_net_link 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_net_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_net_link` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_node 结构
CREATE TABLE IF NOT EXISTS `cdn_node` (
  `nodeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nodeName` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CDN节点';

-- 正在导出表  app_cdn.cdn_node 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_node` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_node_link 结构
CREATE TABLE IF NOT EXISTS `cdn_node_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nodeId` int(11) unsigned NOT NULL DEFAULT '0',
  `houseId` int(11) unsigned NOT NULL DEFAULT '0',
  `upload` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `nodeId` (`nodeId`),
  KEY `houseId` (`houseId`),
  KEY `upload` (`upload`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CDN节点关联关系表';

-- 正在导出表  app_cdn.cdn_node_link 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_node_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_node_link` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_pushsuspiciousandexception 结构
CREATE TABLE IF NOT EXISTS `cdn_pushsuspiciousandexception` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `cdnNetDomain` varchar(128) NOT NULL DEFAULT '',
  `cdnNetId` int(10) unsigned NOT NULL DEFAULT '0',
  `sourceType` tinyint(1) NOT NULL DEFAULT '0',
  `local` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `cdnId` (`cdnId`),
  KEY `cdnNetDomain` (`cdnNetDomain`),
  KEY `cdnNetId` (`cdnNetId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='疑似数据与异常数据推送指令';

-- 正在导出表  app_cdn.cdn_pushsuspiciousandexception 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_pushsuspiciousandexception` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_pushsuspiciousandexception` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_pushsuspiciousandexception_domain 结构
CREATE TABLE IF NOT EXISTS `cdn_pushsuspiciousandexception_domain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `pushDomainId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `domainId` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `source` varchar(128) NOT NULL DEFAULT '',
  `regId` varchar(64) NOT NULL DEFAULT '',
  `topDomain` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推送疑似与异常数据域名格式';

-- 正在导出表  app_cdn.cdn_pushsuspiciousandexception_domain 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_pushsuspiciousandexception_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_pushsuspiciousandexception_domain` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_pushsuspiciousandexception_ip 结构
CREATE TABLE IF NOT EXISTS `cdn_pushsuspiciousandexception_ip` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `pushIPId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `sourceIp` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推送疑似与异常数据IP格式';

-- 正在导出表  app_cdn.cdn_pushsuspiciousandexception_ip 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_pushsuspiciousandexception_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_pushsuspiciousandexception_ip` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_resource_list 结构
CREATE TABLE IF NOT EXISTS `cdn_resource_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  `topdomain` varchar(255) NOT NULL DEFAULT '',
  `subdomain` varchar(255) NOT NULL DEFAULT '',
  `findip` int(11) unsigned NOT NULL,
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add',
  `firstfindtime` int(11) unsigned NOT NULL DEFAULT '0',
  `lastfindtime` int(11) unsigned NOT NULL DEFAULT '0',
  `visitsamount` int(11) unsigned NOT NULL DEFAULT '0',
  `port` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '20190704 changlq add',
  `lasttime` int(11) unsigned NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `topdomain` (`topdomain`),
  KEY `subdomain` (`subdomain`),
  KEY `findip` (`findip`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源监控表';

-- 正在导出表  app_cdn.cdn_resource_list 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_resource_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_resource_list` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_returncdnnet 结构
CREATE TABLE IF NOT EXISTS `cdn_returncdnnet` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` int(11) unsigned NOT NULL DEFAULT '0',
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退回的cdn子网数据';

-- 正在导出表  app_cdn.cdn_returncdnnet 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_returncdnnet` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_returncdnnet` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_returncdnnet_node 结构
CREATE TABLE IF NOT EXISTS `cdn_returncdnnet_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` int(11) unsigned NOT NULL DEFAULT '0',
  `nid` int(11) unsigned NOT NULL DEFAULT '0',
  `nodeId` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退回的cdn子网节点数据';

-- 正在导出表  app_cdn.cdn_returncdnnet_node 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_returncdnnet_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_returncdnnet_node` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_returncdnnet_node_house 结构
CREATE TABLE IF NOT EXISTS `cdn_returncdnnet_node_house` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` int(11) unsigned NOT NULL DEFAULT '0',
  `nid` int(11) unsigned NOT NULL DEFAULT '0',
  `houseId` int(11) unsigned NOT NULL DEFAULT '0',
  `gatewayId` varchar(32) NOT NULL DEFAULT '',
  `frameId` varchar(32) NOT NULL DEFAULT '',
  `ipSegId` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `nid` (`nid`),
  KEY `houseId` (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退回的机房信息';

-- 正在导出表  app_cdn.cdn_returncdnnet_node_house 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_returncdnnet_node_house` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_returncdnnet_node_house` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_returninfo 结构
CREATE TABLE IF NOT EXISTS `cdn_returninfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` int(11) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `returnCode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `returnMsg` varchar(512) NOT NULL DEFAULT '',
  `timeStamp` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `cdnId` (`cdnId`),
  KEY `timeStamp` (`timeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基础数据核验处理信息';

-- 正在导出表  app_cdn.cdn_returninfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_returninfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_returninfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_returnuser 结构
CREATE TABLE IF NOT EXISTS `cdn_returnuser` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` int(11) unsigned NOT NULL DEFAULT '0',
  `cdnId` varchar(128) NOT NULL DEFAULT '',
  `customerId` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `customerId` (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退回的客户数据';

-- 正在导出表  app_cdn.cdn_returnuser 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_returnuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_returnuser` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_serviceinfo 结构
CREATE TABLE IF NOT EXISTS `cdn_serviceinfo` (
  `serviceId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `customerId` int(11) unsigned NOT NULL DEFAULT '0',
  `serviceContent` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`serviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='应用服务信息';

-- 正在导出表  app_cdn.cdn_serviceinfo 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_serviceinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_serviceinfo` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_sitemonitor 结构
CREATE TABLE IF NOT EXISTS `cdn_sitemonitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `houseId` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add',
  `commandId` int(11) unsigned NOT NULL DEFAULT '0',
  `cdnNetId` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `ipv4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add',
  `ipv6` varchar(50) NOT NULL DEFAULT '' COMMENT '20190704 changlq add',
  `port` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add',
  `serviceContent` varchar(128) NOT NULL DEFAULT '',
  `illegalType` int(11) unsigned NOT NULL DEFAULT '0',
  `firstFound` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add',
  `lastFound` int(11) unsigned NOT NULL DEFAULT '0',
  `disposalTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '20190724 changlq add',
  `protocol` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '20190704 changlq add',
  `block` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '20190704 changlq add',
  `currentstate` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `visitCount` bigint(20) unsigned NOT NULL DEFAULT '0',
  `operationAccount` varchar(128) NOT NULL DEFAULT '' COMMENT '20190704 changlq add',
  `bei_an_web_flag` int(11) NOT NULL DEFAULT '0' COMMENT '20190704 changlq add 页面操作标志(0-页面未操作记录；1-页面操作过的新增记录)',
  `gong_hei_web_flag` int(11) NOT NULL DEFAULT '0' COMMENT '20190704 changlq add 页面操作标志(0-页面未操作记录；1-页面操作过的新增记录)',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `domain` (`domain`),
  KEY `currentstate` (`currentstate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法违规网站监测数据';

-- 正在导出表  app_cdn.cdn_sitemonitor 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_sitemonitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_sitemonitor` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_upload_file 结构
CREATE TABLE IF NOT EXISTS `cdn_upload_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ctype` tinyint(6) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `filename_de` varchar(255) NOT NULL DEFAULT '',
  `filepath` varchar(255) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL DEFAULT '0',
  `resultcode` int(10) NOT NULL DEFAULT '-1',
  `content` varchar(1024) NOT NULL DEFAULT '',
  `add_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ctype` (`ctype`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上报文件列表';

-- 正在导出表  app_cdn.cdn_upload_file 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cdn_upload_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_upload_file` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_wfwgqk 结构
CREATE TABLE IF NOT EXISTS `cdn_wfwgqk` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `mc` varchar(32) NOT NULL DEFAULT '',
  `bz` varchar(64) NOT NULL DEFAULT '',
  `sfyx` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违法违规情况';

-- 正在导出表  app_cdn.cdn_wfwgqk 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `cdn_wfwgqk` DISABLE KEYS */;
INSERT INTO `cdn_wfwgqk` (`id`, `mc`, `bz`, `sfyx`) VALUES
	(1, '未备案', '相应网站属未备案', 1),
	(2, '违法网站', '相应网站属于违法网站', 1),
	(999, '其他', '其他违法违规类型', 1);
/*!40000 ALTER TABLE `cdn_wfwgqk` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_white_list 结构
CREATE TABLE IF NOT EXISTS `cdn_white_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `commandid` bigint(20) NOT NULL,
  `code` int(11) unsigned NOT NULL,
  `tv_usec` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间(微秒)',
  `domain` varchar(255) NOT NULL DEFAULT '' COMMENT '域名',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='20190704 changlq create ROS本地白名单';

-- 正在导出表  app_cdn.cdn_white_list 的数据：0 rows
/*!40000 ALTER TABLE `cdn_white_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdn_white_list` ENABLE KEYS */;

-- 导出  表 app_cdn.cdn_zjlx 结构
CREATE TABLE IF NOT EXISTS `cdn_zjlx` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `mc` varchar(32) NOT NULL DEFAULT '',
  `bz` varchar(64) NOT NULL DEFAULT '',
  `sfyx` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='证件类型';

-- 正在导出表  app_cdn.cdn_zjlx 的数据：~10 rows (大约)
/*!40000 ALTER TABLE `cdn_zjlx` DISABLE KEYS */;
INSERT INTO `cdn_zjlx` (`id`, `mc`, `bz`, `sfyx`) VALUES
	(1, '工商营业执照号码', '0', 1),
	(2, '身份证', '0', 1),
	(3, '组织机构代码证书', '0', 1),
	(4, '事业法人证书', '0', 1),
	(5, '军队代号', '0', 1),
	(6, '社团法人证书', '0', 1),
	(7, '护照', '0', 1),
	(8, '军官证', '0', 1),
	(9, '台胞证', '0', 1),
	(999, '其他', '0', 1);
/*!40000 ALTER TABLE `cdn_zjlx` ENABLE KEYS */;

-- 导出  表 app_cdn.commandrecord_info 结构
CREATE TABLE IF NOT EXISTS `commandrecord_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `commandId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Type 4 monitor 5 filter',
  `houseId` int(11) unsigned NOT NULL DEFAULT '0',
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0',
  `count` int(11) unsigned NOT NULL DEFAULT '0',
  `total` int(11) unsigned NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commandId` (`commandId`),
  KEY `type` (`type`),
  KEY `count` (`count`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分IP指令统计';

-- 正在导出表  app_cdn.commandrecord_info 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `commandrecord_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `commandrecord_info` ENABLE KEYS */;

-- 导出  表 app_cdn.filterlog_local 结构
CREATE TABLE IF NOT EXISTS `filterlog_local` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0',
  `dst_ipv4` int(11) unsigned NOT NULL DEFAULT '0',
  `src_ipv6` varchar(50) NOT NULL DEFAULT '',
  `dst_ipv6` varchar(50) NOT NULL DEFAULT '',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `protocol` tinyint(1) NOT NULL DEFAULT '0',
  `service` int(6) NOT NULL DEFAULT '0',
  `report` tinyint(1) NOT NULL DEFAULT '1',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `src_ipv4` (`src_ipv4`),
  KEY `dst_ipv4` (`dst_ipv4`),
  KEY `src_port` (`src_port`),
  KEY `dst_port` (`dst_port`),
  KEY `protocol` (`protocol`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='过滤日志';

-- 正在导出表  app_cdn.filterlog_local 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `filterlog_local` DISABLE KEYS */;
/*!40000 ALTER TABLE `filterlog_local` ENABLE KEYS */;

-- 导出  表 app_cdn.logserver_list 结构
CREATE TABLE IF NOT EXISTS `logserver_list` (
  `hid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(256) NOT NULL DEFAULT '',
  `logip` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`hid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志服务器列表';

-- 正在导出表  app_cdn.logserver_list 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `logserver_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `logserver_list` ENABLE KEYS */;

-- 导出  表 app_cdn.monitorlog_local 结构
CREATE TABLE IF NOT EXISTS `monitorlog_local` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `src_ipv4` int(11) unsigned NOT NULL DEFAULT '0',
  `dst_ipv4` int(11) unsigned NOT NULL DEFAULT '0',
  `src_ipv6` varchar(50) NOT NULL DEFAULT '',
  `dst_ipv6` varchar(50) NOT NULL DEFAULT '',
  `src_port` bigint(20) unsigned NOT NULL DEFAULT '0',
  `dst_port` bigint(20) unsigned NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `protocol` tinyint(1) NOT NULL DEFAULT '0',
  `service` int(6) NOT NULL DEFAULT '0',
  `report` tinyint(1) NOT NULL DEFAULT '1',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `src_ipv4` (`src_ipv4`),
  KEY `dst_ipv4` (`dst_ipv4`),
  KEY `src_port` (`src_port`),
  KEY `dst_port` (`dst_port`),
  KEY `protocol` (`protocol`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='监测日志';

-- 正在导出表  app_cdn.monitorlog_local 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `monitorlog_local` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitorlog_local` ENABLE KEYS */;

-- 导出  表 app_cdn.sys_conf 结构
CREATE TABLE IF NOT EXISTS `sys_conf` (
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- 正在导出表  app_cdn.sys_conf 的数据：~25 rows (大约)
/*!40000 ALTER TABLE `sys_conf` DISABLE KEYS */;
INSERT INTO `sys_conf` (`name`, `value`) VALUES
	('commandfileid', '1'),
	('commandVersion', 'v1.0'),
	('compressionForma', '1'),
	('encryptAlgorithm', '1'),
	('encrypt_iv', '1234567890ABCDEF'),
	('encrypt_key', '1234567890ABCDEF'),
	('ftp_999', '/cdn_home/999'),
	('ftp_folder', '/cdn_home'),
	('ftp_port', '21'),
	('ftp_pwd', 'BGKJ'),
	('ftp_server', '211.102.216.49'),
	('ftp_uname', 'BGKJ'),
	('hasha1gorithm', '1'),
	('illegalweb_icp_ip_polity', '0'),
	('illegalweb_icp_polity', '0'),
	('illegalweb_list_polity', '1'),
	('jfind_interval', '60'),
	('log_save', '7'),
	('smms_ip', 'http://211.102.216.38:80/smci_cdn/cdn_commandack?wsdl'),
	('timelog_auto_stop', '0'),
	('timelog_save_xml', '0'),
	('time_edit_hand', '0'),
	('upload_save_days', '30'),
	('user_pwd', 'LLX360'),
	('xml_xsd_check', '0');
/*!40000 ALTER TABLE `sys_conf` ENABLE KEYS */;

-- 导出  表 app_cdn.sys_log 结构
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

-- 正在导出表  app_cdn.sys_log 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;

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
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

-- 正在导出表  app_cdn.auth_rule 的数据：~121 rows (大约)
/*!40000 ALTER TABLE `auth_rule` DISABLE KEYS */;
INSERT INTO `auth_rule` (`id`, `pid`, `title`, `icon`, `name`, `type`, `condition`, `sort`) VALUES
	(1, 0, '数据管理', '', '', 1, '', 1),
	(2, 1, '基础数据管理', '', '/cdnInfo/list', 1, 'cdn:info:list', 2),
	(4, 1, '基础数据信息', '', '/cdn/gatewayinfo/list', 1, 'cdn:gatewayinfo:list', 3),
	(5, 1, '基础数据监测', '', '/cdn/infomanage/list', 1, 'cdn:infomanage:list', 4),
	(6, 1, '基础数据核验', '', '/cdn/returninfo/list', 1, 'cdn:returninfo:list', 5),
	(7, 0, '业务状态', '', '', 1, NULL, 1),
	(8, 7, '监测过滤日志', '', '/cdn/monitorlogLocal/page', 1, 'cdn:monitorlogLocal:page', 2),
	(9, 7, '资源监控', '', '/cdn/resourceList/domainList', 1, 'cdn:resourceList:domainList', 3),
	(10, 7, '疑似异常数据', '', '/cdn/pushsuspiciousandexception/list', 1, 'cdn:pushsuspiciousandexception:list', 4),
	(11, 0, '信息安全', '', '', 1, NULL, 1),
	(12, 11, '违法违规网站管理', '', '/cdn/sitemonitor/list', 1, 'cdn:sitemonitor:list', 2),
	(13, 11, '管理指令', '', '/cdn/command/list', 1, 'cdn:command:list', 3),
	(14, 0, '访问日志', '', '', 1, 'cdn:acclog:list', 1),
	(15, 14, '访问日志', '', '/acclog/local/page', 1, 'cdn:acclog:page', 2),
	(16, 14, '访问日志查询指令', '', '/cdn/logquery/list', 1, 'cdn:logquery:list', 3),
	(17, 14, '服务器配置', '', '/cdn/logserverList/list', 1, 'cdn:logserverList:list', 4),
	(18, 0, '系统日志', '', '', 1, NULL, 1),
	(19, 18, '系统日志', '', '/cdn/sysLog/list', 1, 'sys:sysLog:list', 2),
	(20, 18, '上报文件处理', '', '/cdn/uploadFile/list', 1, 'cdn:uploadFile:list', 3),
	(21, 18, '下发文件处理', '', '/cdn/downloadFile/list', 1, 'cdn:downloadFile:list', 4),
	(22, 18, '指令执行情况回复', '', '/cdn/commandack/list', 1, 'cdn:commandack:list', 5),
	(23, 0, '系统管理', '', '', 1, NULL, 1),
	(24, 23, '用户管理', '', '/users/list', 1, 'cdn:user:list', 2),
	(25, 23, '角色管理', '', '/roles/list', 1, 'cdn:role:list', 3),
	(26, 23, '时间设置', '', '/toTime', 1, 'sys:see:toTime', 4),
	(27, 23, '系统设置', '', '/cdn/sysConf/sysList', 1, 'sys:sysConf:sysList', 5),
	(28, 23, '参数设置', '', '/cdn/sysConf/parList', 1, 'sys:sysConf:parList', 6),
	(29, 23, '备份和恢复', '', '/backup', 1, 'sys:data:tobackup', 7),
	(30, 23, '磁盘清理', '', '/cleanup', 1, 'sys:disk:tocleanup', 8),
	(32, 1, '代码表', '', '/cdn/dwsx/list', 1, 'cdn:dwsx:list', 6),
	(33, 24, '用户修改', '', '/users/toUpdate', 1, 'cdn:user:update', 1),
	(34, 24, '用户添加', '', '/users/add', 1, 'cdn:user:add', 2),
	(35, 2, '主体信息管理', '', '/cdnInfo/list', 1, 'cdn:info:list', 1),
	(36, 2, '添加主体信息', '', '/cdnInfo/add', 1, 'cdn:info:add', 2),
	(37, 2, '修改主体信息', '', '/cdnInfo/toUpdate', 1, 'cdn:info:toUpdate', 3),
	(38, 2, '删除主体信息', '', '/cdnInfo/delete', 1, 'cdn:info:delete', 4),
	(39, 2, '客户信息管理', '', '/cdn/customerinfo/list', 1, 'cdn:customerinfo:list', 5),
	(40, 2, '添加客户信息', '', '/cdn/customerinfo/add', 1, 'cdn:customerinfo:add', 6),
	(41, 2, '修改客户信息', '', '/cdn/customerinfo/toUpdate', 1, 'cdn:customerinfo:toUpdate', 7),
	(42, 2, '删除客户信息', '', '/cdn/customerinfo/delete', 1, 'cdn:customerinfo:delete', 8),
	(43, 2, 'CDN机房管理', '', '/cdn/houseinfo/list', 1, 'cdn:houseinfo:list', 9),
	(44, 2, '添加机房信息', '', '/cdn/houseinfo/add', 1, 'cdn:houseinfo:add', 10),
	(45, 2, '修改机房信息', '', '/cdn/houseinfo/toUpdate', 1, 'cdn:houseinfo:toUpdate', 11),
	(46, 2, '删除机房信息', '', '/cdn/houseinfo/delete', 1, 'cdn:houseinfo:delete', 12),
	(47, 2, 'CDN节点管理', '', '/cdn/node/list', 1, 'cdn:node:list', 13),
	(48, 2, '添加节点信息', '', '/cdn/node/add', 1, 'cdn:node:add', 14),
	(49, 2, '修改节点信息', '', '/cdn/node/toUpdate', 1, 'cdn:node:toUpdate', 15),
	(50, 2, '删除节点信息', '', '/cdn/node/delete', 1, 'cdn:node:delete', 16),
	(51, 2, 'CDN子网信息', '', '/cdn/cdnnetinfo/list', 1, 'cdn:cdnnetinfo:list', 17),
	(52, 2, '添加子网信息', '', '/cdn/cdnnetinfo/add', 1, 'cdn:cdnnetinfo:add', 18),
	(53, 2, '修改子网信息', '', '/cdn/cdnnetinfo/toUpdate', 1, 'cdn:cdnnetinfo:toUpdate', 19),
	(54, 2, '删除子网信息', '', '/cdn/cdnnetinfo/delete', 1, 'cdn:cdnnetinfo:delete', 20),
	(55, 2, '安全责任人管理', '', '/cdn/linkofficerinfo/list', 1, 'cdn:linkofficerinfo:list', 21),
	(56, 2, '添加安全责任人', '', '/cdn/linkofficerinfo/add', 1, 'cdn:linkofficerinfo:add', 22),
	(57, 2, '修改安全责任人', '', '/cdn/linkofficerinfo/toUpdate', 1, 'cdn:linkofficerinfo:toUpdate', 23),
	(58, 2, '删除安全责任人', '', '/cdn/linkofficerinfo/delete', 1, 'cdn:linkofficerinfo:delete', 24),
	(59, 4, '链路信息', '', '/cdn/gatewayinfo/list', 1, 'cdn:gatewayinfo:list', 1),
	(60, 4, 'IP地址段信息', '', '/cdn/ipseginfo/list', 1, 'cdn:ipseginfo:list', 2),
	(61, 4, '服务信息', '', '/cdn/serviceinfo/list', 1, 'cdn:serviceinfo:list', 3),
	(62, 4, '域名信息', '', '/cdn/domaininfo/list', 1, 'cdn:domaininfo:list', 4),
	(63, 5, '基础数据管理指令', '', '/cdn/infomanage/list', 1, 'cdn:infomanage:list', 1),
	(64, 5, '基础数据管理指令本地基础数据管理指令', '', '/cdn/infomanage/localList', 1, 'cdn:infomanage:localList', 2),
	(65, 5, '添加本地指令', '', '/cdn/infomanage/add', 1, 'cdn:infomanage:add', 3),
	(66, 5, '修改本地指令', '', '/cdn/infomanage/toUpdate', 1, 'cdn:infomanage:toUpdate', 4),
	(67, 5, '删除本地指令', '', '/cdn/infomanage/delete', 1, 'cdn:infomanage:delete', 5),
	(68, 6, '基础数据核验', '', '/cdn/returninfo/list', 1, 'cdn:returninfo:list', 1),
	(69, 6, '客户数据退回', '', '/cdn/returnuser/list', 1, 'cdn:returnuser:list', 2),
	(70, 6, '子网数据退回', '', '/cdn/returncdnnet/list', 1, 'cdn:returncdnnet:list', 3),
	(71, 6, '节点数据退回', '', '/cdn/returncdnnetNnode/list', 1, 'cdn:returncdnnetNnode:list', 4),
	(72, 6, '机房数据退回', '', '/cdn/returncdnnetNodeHouse/list', 1, 'cdn:returncdnnetNodeHouse:list', 5),
	(73, 32, '单位属性', '', '/cdn/dwsx/list', 1, 'cdn:dwsx:list', 1),
	(74, 32, '证件类型', '', '/cdn/zjlx/list', 1, 'cdn:zjlx:list', 2),
	(75, 32, '机房性质', '', '/cdn/jfxz/list', 1, 'cdn:jfxz:list', 3),
	(76, 32, '服务内容', '', '/cdn/fwnr/list', 1, 'cdn:fwnr:list', 4),
	(77, 32, '监测过滤规则类型', '', '/cdn/gzlx/list', 1, 'cdn:gzlx:list', 5),
	(78, 32, '违法违规情况', '', '/cdn/wfwgqk/list', 1, 'cdn:wfwgqk:list', 6),
	(79, 8, '信息监测日志', '', '/cdn/monitorlogLocal/page', 1, 'cdn:monitorlogLocal:page', 1),
	(80, 8, '信息过滤日志', '', '/cdn/filterlogLocal/page', 1, 'cdn:filterlogLocal:page', 2),
	(81, 9, '域名监控', '', '/cdn/resourceList/domainList', 1, 'cdn:resourceList:domainList', 1),
	(82, 9, 'IP监控', '', '/cdn/resourceList/ipList', 1, 'cdn:resourceList:ipList', 2),
	(83, 10, '疑似与异常数据推送指令', '', '/cdn/pushsuspiciousandexception/list', 1, 'cdn:pushsuspiciousandexception:list', 1),
	(84, 10, '疑似与异常数据反馈信息', '', '/cdn/feedbacksuspiciousandexception/list', 1, 'cdn:feedbacksuspiciousandexception:list', 2),
	(85, 10, '疑似与异常数据反馈处理', '', '/cdn/handlefeedbacksuspiciousandexception/list', 1, 'cdn:handlefeedbacksuspiciousandexception:list', 3),
	(86, 12, '违法违规网站监测', '', '/cdn/sitemonitor/list', 1, 'cdn:sitemonitor:list', 1),
	(87, 12, '违法网站列表', '', '/cdn/blacklist/list', 1, 'cdn:blacklist:list', 2),
	(88, 12, '网站备案查询', '', '/cdn/domaincache/list', 1, 'cdn:domaincache:list', 3),
	(89, 12, '添加网站备案', '', '/cdn/domaincache/add', 1, 'cdn:domaincache:add', 4),
	(90, 12, '修改网站备案', '', '/cdn/domaincache/toUpdate', 1, 'cdn:domaincache:toUpdate', 5),
	(91, 12, '删除网站备案', '', '/cdn/domaincache/delete', 1, 'cdn:domaincache:delete', 6),
	(92, 13, '管理指令', '', '/cdn/command/list', 1, 'cdn:command:list', 1),
	(93, 13, '本地管理指令', '', '/cdn/command/localList', 1, 'cdn:command:localList', 2),
	(94, 13, '添加本地管理指令', '', '/cdn/command/add', 1, 'cdn:command:add', 3),
	(95, 13, '修改本地管理指令', '', '/cdn/command/toUpdate', 1, 'cdn:command:toUpdate', 4),
	(96, 13, '删除本地管理指令', '', '/cdn/command/delete', 1, 'cdn:command:delete', 5),
	(97, 13, '指令申诉', '', '/cdn/commandback/list', 1, 'cdn:commandback:list', 6),
	(98, 15, '访问日志', '', '/acclog/local/page', 1, 'cdn:acclog:page', 1),
	(99, 16, '访问日志查询指令', '', '/cdn/logquery/list', 1, 'cdn:logquery:list', 1),
	(100, 16, '本地访问日志查询指令', '', '/cdn/logquery/localList', 1, 'cdn:logquery:localList', 2),
	(101, 16, '添加本地访问日志查询指令', '', '/cdn/logquery/add', 1, 'cdn:logquery:add', 3),
	(102, 16, '修改本地访问日志查询指令', '', '/cdn/logquery/toUpdate', 1, 'cdn:logquery:toUpdate', 4),
	(103, 16, '删除本地访问日志查询指令', '', '/cdn/logquery/delete', 1, 'cdn:logquery:delete', 5),
	(104, 17, '服务器配置', '', '/cdn/logserverList/list', 1, 'cdn:logserverList:list', 1),
	(105, 24, '删除用户', '', '/users/delete', 1, 'cdn:user:delete', 3),
	(106, 25, '添加角色', '', '/roles/add', 1, 'sys:roles:add', 1),
	(107, 25, '修改角色', '', '/roles/toUpdate', 1, 'sys:roles:toUpdate', 2),
	(108, 25, '删除角色', '', '/roles/delete', 1, 'sys:roles:delete', 3),
	(109, 19, '系统日志', '', '/cdn/sysLog/list', 1, 'sys:sysLog:list', 1),
	(110, 20, '上报文件处理', '', '/cdn/uploadFile/list', 1, 'cdn:uploadFile:list', 1),
	(111, 20, '重新上报', '', '/cdn/uploadFile/exportXml', 1, 'cdn:uploadFile:exportXml', 2),
	(112, 21, '下发文件处理', '', '/cdn/downloadFile/list', 1, 'cdn:downloadFile:list', 1),
	(113, 22, '指令执行情况回复', '', '/cdn/commandack/list', 1, 'cdn:commandack:list', 1),
	(114, 27, '系统配置', '', '/cdn/sysConf/sysList', 1, 'sys:sysConf:sysList', 1),
	(115, 27, '修改系统配置', '', '/cdn/sysConf/sysUpdate', 1, 'sys:sysConf:sysUpdate', 2),
	(116, 28, '参数配置', '', '/cdn/sysConf/parList', 1, 'sys:sysConf:parList', 1),
	(117, 28, '修改参数配置', '', '/cdn/sysConf/parUpdate', 1, 'sys:sysConf:parUpdate', 2),
	(118, 29, '备份', '', '/backUp', 1, 'sys:data:backUp', 2),
	(119, 29, '恢复', '', '/recovery', 1, 'sys:data:recovery', 3),
	(120, 29, '删除备份文件', '', '/recovery/delete', 1, 'sys:data:delete', 4),
	(121, 30, '磁盘清理', '', '/cleanUP', 1, 'sys:disk:cleanUP', 1),
	(122, 26, '时间设置', '', '/time', 1, 'sys:time:setTime', 1),
	(123, 26, '修改时间', '', '/updateTime', 1, 'sys:time:updateTime', 2);
/*!40000 ALTER TABLE `auth_rule` ENABLE KEYS */;

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


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
