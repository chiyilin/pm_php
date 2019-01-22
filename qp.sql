/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : qp

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-01-22 17:16:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `qp_admin`
-- ----------------------------
DROP TABLE IF EXISTS `qp_admin`;
CREATE TABLE `qp_admin` (
  `admin_id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(50) NOT NULL,
  `admin_phone` varchar(11) NOT NULL,
  `admin_pwd` varchar(50) NOT NULL,
  `admin_power` tinyint(2) NOT NULL,
  `admin_last_login_time` int(10) DEFAULT NULL,
  `admin_last_login_ip` varchar(20) DEFAULT NULL,
  `admin_is_lock` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否锁定管理员（1、正常；2、锁定）',
  `admin_add_time` int(10) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_admin
-- ----------------------------
INSERT INTO `qp_admin` VALUES ('36', 'admin', '13210628679', '4297f44b13955235245b2497399d7a93', '1', '1548121912', '127.0.0.1', '1', '1535363738');
INSERT INTO `qp_admin` VALUES ('37', 'admin2', '15163444790', 'e10adc3949ba59abbe56e057f20f883e', '1', '1537414588', '::1', '1', '1535365628');
INSERT INTO `qp_admin` VALUES ('38', 'admin3', '18688886666', 'e10adc3949ba59abbe56e057f20f883e', '1', '0', '', '1', '1539334037');
INSERT INTO `qp_admin` VALUES ('39', 'admin4', '17588886666', 'e10adc3949ba59abbe56e057f20f883e', '1', '1539338660', '::1', '1', '1539334252');
INSERT INTO `qp_admin` VALUES ('40', 'cyl', '17600604129', '4297f44b13955235245b2497399d7a93', '1', '0', '::1', '1', '1');
INSERT INTO `qp_admin` VALUES ('41', 'ppp', '15163444793', 'e10adc3949ba59abbe56e057f20f883e', '2', null, null, '1', '1544516163');

-- ----------------------------
-- Table structure for `qp_article`
-- ----------------------------
DROP TABLE IF EXISTS `qp_article`;
CREATE TABLE `qp_article` (
  `article_id` int(10) NOT NULL AUTO_INCREMENT,
  `article_cover` char(255) NOT NULL COMMENT '文章封面',
  `cover_desc` char(255) NOT NULL,
  `article_title` varchar(100) NOT NULL COMMENT '文章标题',
  `article_details` text NOT NULL COMMENT '文章内容',
  `article_cate` tinyint(1) NOT NULL COMMENT '文章所属类型',
  `article_time` int(10) NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qp_article
-- ----------------------------
INSERT INTO `qp_article` VALUES ('55', 'uploads/articleCover/201901/a697853fe3103482f812c9765818094c.jpg', '', '使用教程！', '<p>这是使用教程</p>', '7', '1547777805');

-- ----------------------------
-- Table structure for `qp_article_cate`
-- ----------------------------
DROP TABLE IF EXISTS `qp_article_cate`;
CREATE TABLE `qp_article_cate` (
  `cate_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '文章分类表',
  `cate_name` char(20) NOT NULL COMMENT '分类名称',
  `cate_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '分类状态（1、正常；2、锁定）',
  `cate_sort` int(10) DEFAULT '1' COMMENT '分类排序（正序）',
  `add_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_article_cate
-- ----------------------------
INSERT INTO `qp_article_cate` VALUES ('7', '教程', '1', '1', '1547774844');
INSERT INTO `qp_article_cate` VALUES ('8', '介绍', '1', '1', '1547774858');
INSERT INTO `qp_article_cate` VALUES ('9', '哈哈啊', '1', '1', '1547775596');
INSERT INTO `qp_article_cate` VALUES ('10', '最新活动', '1', '1', '1547775615');
INSERT INTO `qp_article_cate` VALUES ('11', '321123231', '1', '1', '1547777893');

-- ----------------------------
-- Table structure for `qp_banner`
-- ----------------------------
DROP TABLE IF EXISTS `qp_banner`;
CREATE TABLE `qp_banner` (
  `banner_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Banner表',
  `url` varchar(300) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、展示；2、隐藏',
  `path_index` int(10) DEFAULT NULL,
  `path` char(100) NOT NULL,
  `ext` char(255) NOT NULL,
  `ext_str` char(50) NOT NULL,
  `sort` tinyint(2) NOT NULL DEFAULT '1' COMMENT 'Banner排序（正序排列）',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=MyISAM AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_banner
-- ----------------------------
INSERT INTO `qp_banner` VALUES ('193', 'uploads/banner/201812/a8eca367606644b289f1cfa4f2c4a13f.jpg', '1', '2', '/pages/transaction/transaction', '', '', '1', '1545122705');
INSERT INTO `qp_banner` VALUES ('192', 'uploads/banner/201812/6889949760eddb69b0074ab56b55a4e2.jpg', '1', '2', '/pages/transaction/transaction', '', '', '1', '1545122705');
INSERT INTO `qp_banner` VALUES ('194', 'uploads/banner/201901/0f4cbcf44f1bbd84dbfec43f8c9a3d1c.jpg', '1', null, '', '', '', '1', '1547691807');
INSERT INTO `qp_banner` VALUES ('195', 'uploads/banner/201901/5c094a49a67aff15ef36f97a91b63b8a.png', '1', null, '', '', '', '1', '1547691838');

-- ----------------------------
-- Table structure for `qp_category`
-- ----------------------------
DROP TABLE IF EXISTS `qp_category`;
CREATE TABLE `qp_category` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '商品分类表',
  `category_name` varchar(50) NOT NULL,
  `category_icon` char(200) DEFAULT NULL,
  `category_sort` int(10) NOT NULL COMMENT '排序',
  `category_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：正常、2；关闭',
  `category_group_sort` tinyint(1) NOT NULL,
  `category_level` tinyint(1) NOT NULL DEFAULT '1',
  `category_fid` int(10) NOT NULL,
  `category_time` int(10) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_category
-- ----------------------------
INSERT INTO `qp_category` VALUES ('48', '解放区邮票', null, '0', '1', '1', '3', '45', '1544694531');
INSERT INTO `qp_category` VALUES ('47', '民国邮票', null, '0', '1', '1', '3', '45', '1544694511');
INSERT INTO `qp_category` VALUES ('46', '清代邮票', null, '0', '1', '1', '3', '45', '1544694493');
INSERT INTO `qp_category` VALUES ('45', '清民居邮票', null, '0', '1', '1', '2', '34', '1544694481');
INSERT INTO `qp_category` VALUES ('44', '新中国邮票', null, '0', '1', '1', '2', '34', '1544694468');
INSERT INTO `qp_category` VALUES ('39', '其他', null, '0', '1', '6', '1', '0', '1544694257');
INSERT INTO `qp_category` VALUES ('37', '艺术', null, '2', '1', '4', '1', '0', '1544694247');
INSERT INTO `qp_category` VALUES ('38', '文献', null, '1', '1', '5', '1', '0', '1544694253');
INSERT INTO `qp_category` VALUES ('36', '书画', null, '3', '1', '3', '1', '0', '1544694241');
INSERT INTO `qp_category` VALUES ('35', '钱币', null, '4', '1', '2', '1', '0', '1544694234');
INSERT INTO `qp_category` VALUES ('34', '邮品', null, '5', '1', '1', '1', '0', '1544694229');
INSERT INTO `qp_category` VALUES ('49', '全集年票', null, '0', '1', '1', '3', '44', '1544694558');
INSERT INTO `qp_category` VALUES ('50', '小型/全章', null, '0', '1', '1', '3', '44', '1544694573');
INSERT INTO `qp_category` VALUES ('51', '纪特邮票', null, '0', '1', '1', '3', '44', '1544694604');
INSERT INTO `qp_category` VALUES ('52', '编年新邮', null, '0', '1', '1', '3', '44', '1544694623');
INSERT INTO `qp_category` VALUES ('53', '“文”字头邮票', null, '0', '1', '1', '3', '44', '1544694667');
INSERT INTO `qp_category` VALUES ('54', '普改航欠军', null, '0', '1', '1', '3', '44', '1544694698');
INSERT INTO `qp_category` VALUES ('55', '编号邮票', null, '0', '1', '1', '3', '44', '1544694895');
INSERT INTO `qp_category` VALUES ('56', '小本票', null, '0', '1', '1', '3', '44', '1544694949');
INSERT INTO `qp_category` VALUES ('57', '封片简', null, '0', '1', '1', '2', '34', '1544694979');
INSERT INTO `qp_category` VALUES ('58', '清代封片简', null, '0', '1', '1', '3', '57', '1544694998');
INSERT INTO `qp_category` VALUES ('59', '现代钱币', null, '0', '1', '2', '2', '35', '1546652657');
INSERT INTO `qp_category` VALUES ('60', '人民币', null, '0', '1', '2', '3', '59', '1546652670');
INSERT INTO `qp_category` VALUES ('61', 'haha', 'uploads/cate/201901/1376e60baf0eedfeb917f6ec5c17af6d.png', '12', '1', '3', '2', '36', '1547171195');

-- ----------------------------
-- Table structure for `qp_collection`
-- ----------------------------
DROP TABLE IF EXISTS `qp_collection`;
CREATE TABLE `qp_collection` (
  `collection_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '专场表',
  `collection_name` varchar(50) NOT NULL COMMENT '专场名',
  `collection_cover` varchar(300) NOT NULL COMMENT '专场封面',
  `cover_desc` char(50) NOT NULL,
  `category_id` int(10) NOT NULL,
  `collection_start_time` int(10) NOT NULL,
  `collection_end_time` int(10) NOT NULL,
  `collection_introduce` text NOT NULL COMMENT '简介',
  `collection_sort` int(10) NOT NULL DEFAULT '0',
  `collection_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、展示；2、不展示',
  `collection_add_time` int(10) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`collection_id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_collection
-- ----------------------------
INSERT INTO `qp_collection` VALUES ('51', '12.150001', 'uploads/collection/201812/6d0707be358578798137e61079d6973e.jpg', '', '35', '1544803200', '1544889600', '<p>12312<img src=\"http://qp.test/uploads/collectionImg/201812/a678c1302ef282d59b072622a0bab894.jpg\" style=\"max-width: 100%;\"></p><p><br></p>', '0', '1', '1544845025');
INSERT INTO `qp_collection` VALUES ('52', '哈哈哈哈哈', 'uploads/collection/201812/03922f7887f891e5128bc1d246b691be.jpg', '', '34', '1544544000', '1545062400', '<p><span style=\"font-weight: bold;\">专场啊！</span><br></p><p><br></p>', '0', '1', '1544853329');
INSERT INTO `qp_collection` VALUES ('53', '1.1', 'uploads/collection/201812/f493d52032287a531b14b99b2865e12a.jpg', '', '36', '1546272000', '1546358400', '<p>213</p><p><br></p>', '0', '1', '1544855379');
INSERT INTO `qp_collection` VALUES ('54', '2.1', 'uploads/collection/201812/58470d8d8301cb38f2f0fe957897fe5a.png', '', '38', '1548950400', '1550764800', '<p>1</p><p><br></p>', '0', '1', '1544855451');
INSERT INTO `qp_collection` VALUES ('55', '这个结束了', 'uploads/collection/201812/12b319077de054a9208adaa8a349b096.jpg', '', '39', '1543680000', '1544457600', '<p>结束了这个</p>', '0', '1', '1544861940');
INSERT INTO `qp_collection` VALUES ('56', '12.17', 'uploads/collection/201812/b3e77e4f614aacce66689878d64b1e7c.jpg', '', '37', '1544976000', '1545235200', '<p>123</p>', '0', '1', '1545025781');
INSERT INTO `qp_collection` VALUES ('57', '1', 'uploads/collection/201901/7e7c0588cb76a05720fb795259ad73db.jpg', '1213123123', '38', '1547740800', '1548864000', '<p>123</p><p><br></p>', '0', '1', '1547782076');

-- ----------------------------
-- Table structure for `qp_config`
-- ----------------------------
DROP TABLE IF EXISTS `qp_config`;
CREATE TABLE `qp_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '系统配置表',
  `appid` char(20) NOT NULL DEFAULT 'wx6ca7934dacd6334e' COMMENT 'AppID(小程序ID)：',
  `appsecret` char(50) NOT NULL DEFAULT 'f51abca5179ea4d44415cd24c0d09862' COMMENT 'AppSecret(小程序密钥)',
  `mch_id` int(10) NOT NULL DEFAULT '1494620392' COMMENT '微信支付商户号',
  `mch_key` char(50) NOT NULL DEFAULT 'bainianchenshi1chenshimeihuazhen' COMMENT '微信商户密钥',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_config
-- ----------------------------
INSERT INTO `qp_config` VALUES ('1', 'wx6ca7934dacd6334e', '57673a8d4f7ac2c0cd8cc44df9d5322f', '1494620392', 'bainianchenshi1chenshimeihuazhen');

-- ----------------------------
-- Table structure for `qp_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `qp_coupon`;
CREATE TABLE `qp_coupon` (
  `coupon_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `way` tinyint(1) DEFAULT '1' COMMENT '1、管理员手动赠送；2、系统自动赠送',
  `coupon_setting_id` int(10) DEFAULT NULL COMMENT '系统优惠券设置ID',
  `need_money` decimal(10,2) DEFAULT '0.00' COMMENT '需要满足消费金额才能使用的',
  `money` decimal(10,2) DEFAULT '0.00',
  `can_use_expire_time` int(11) unsigned NOT NULL DEFAULT '0',
  `can_use_start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '可以使用时间',
  `coupon_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否使用：1、未使用 2、已使用',
  `add_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`coupon_id`)
) ENGINE=MyISAM AUTO_INCREMENT=402 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_coupon
-- ----------------------------
INSERT INTO `qp_coupon` VALUES ('398', '2721', '1', null, '1.00', '1.00', '4294967295', '1546401304', '1', '10');
INSERT INTO `qp_coupon` VALUES ('399', '2721', '1', null, '2.00', '2.00', '4294967295', '1546401304', '1', '12');
INSERT INTO `qp_coupon` VALUES ('400', null, '2', '8', '10.00', '9.99', '1547713037', '1547108237', '1', '1547108237');
INSERT INTO `qp_coupon` VALUES ('401', '2721', '2', '8', '10.00', '9.99', '1547713078', '1547108278', '1', '1547108278');

-- ----------------------------
-- Table structure for `qp_coupon_setting`
-- ----------------------------
DROP TABLE IF EXISTS `qp_coupon_setting`;
CREATE TABLE `qp_coupon_setting` (
  `coupon_setting_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '优惠券设置表',
  `get_this_money` decimal(10,2) NOT NULL COMMENT '赠送门槛金额',
  `need_money` decimal(10,2) NOT NULL COMMENT '使用门槛金额',
  `money` decimal(10,2) NOT NULL COMMENT '优惠券面额',
  `useful_life` int(3) NOT NULL COMMENT '有效天数，单位（天）',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、正常；2关闭',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`coupon_setting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_coupon_setting
-- ----------------------------
INSERT INTO `qp_coupon_setting` VALUES ('7', '9999.01', '1000.01', '100.01', '8', '2', '1547103906');
INSERT INTO `qp_coupon_setting` VALUES ('8', '10.00', '10.00', '9.99', '7', '1', '1547108033');

-- ----------------------------
-- Table structure for `qp_crontab_setting`
-- ----------------------------
DROP TABLE IF EXISTS `qp_crontab_setting`;
CREATE TABLE `qp_crontab_setting` (
  `crontab_setting_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '定时任务设置表',
  `start_time` char(40) NOT NULL COMMENT '设置定时执行的时间',
  `is_happen` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、未执行；2、已经执行',
  `happen_time` tinyint(10) NOT NULL,
  `controller` char(50) NOT NULL,
  PRIMARY KEY (`crontab_setting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_crontab_setting
-- ----------------------------
INSERT INTO `qp_crontab_setting` VALUES ('1', '2018-12-26 13:54:08', '1', '0', '[\"app\\\\command\\\\Test::setting\"]');

-- ----------------------------
-- Table structure for `qp_entrust`
-- ----------------------------
DROP TABLE IF EXISTS `qp_entrust`;
CREATE TABLE `qp_entrust` (
  `entrust_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `entrust_name` varchar(20) NOT NULL,
  `entrust_phone` char(15) NOT NULL,
  `entrust_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、委托 ；2、估价',
  `entrust_content` text NOT NULL,
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`entrust_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_entrust
-- ----------------------------
INSERT INTO `qp_entrust` VALUES ('37', '0', '池艺林', '17600604129', '1', '123', '1545274919');
INSERT INTO `qp_entrust` VALUES ('39', '2721', '12.20', '15163444791', '1', '123546', '1545286291');
INSERT INTO `qp_entrust` VALUES ('40', '2721', '池艺林', '18888888888', '1', '123', '1547798607');

-- ----------------------------
-- Table structure for `qp_entrust_image`
-- ----------------------------
DROP TABLE IF EXISTS `qp_entrust_image`;
CREATE TABLE `qp_entrust_image` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `entrust_id` int(10) NOT NULL,
  `sort` int(2) NOT NULL,
  `url` varchar(255) NOT NULL,
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_entrust_image
-- ----------------------------
INSERT INTO `qp_entrust_image` VALUES ('5', '37', '1', 'uploads/weituo/201812/5c9a3e750aa38ba40816dd32b15cf2b7.jpg', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('6', '37', '2', 'uploads/weituo/201812/298b77a16e847c4d8d7409ef2f951ecc.jpg', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('7', '37', '3', 'uploads/weituo/201812/743a687ffb80708f5c8477437ce58bcb.jpg', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('8', '37', '5', 'uploads/weituo/201812/92106f0fce0241106944cdabbcc7e445.png', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('9', '37', '4', 'uploads/weituo/201812/1e2014c23e14043bcbbed33f85965cd8.jpg', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('10', '37', '6', 'uploads/weituo/201812/722b1c82bec56e428210687d4cb27dee.png', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('11', '37', '7', 'uploads/weituo/201812/86da1a2db46ec2cf4eb73cce08091c5f.png', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('12', '37', '8', 'uploads/weituo/201812/ea5774d6bdc2da0c72cbc1373d6061b2.jpg', '1545274919');
INSERT INTO `qp_entrust_image` VALUES ('13', '37', '9', 'uploads/weituo/201812/14d548f8198461c4e55198b5ec4ba7ce.jpg', '1545274920');
INSERT INTO `qp_entrust_image` VALUES ('14', '38', '3', 'uploads/weituo/201812/4160d392ab168ce2b5d28f3caa41a02c.jpg', '1545274999');
INSERT INTO `qp_entrust_image` VALUES ('15', '38', '2', 'uploads/weituo/201812/174c34574fe71c515759f81757e8a89d.jpg', '1545274999');
INSERT INTO `qp_entrust_image` VALUES ('16', '38', '1', 'uploads/weituo/201812/307cc09c4bd63c07c76c61b10d761090.jpg', '1545275000');
INSERT INTO `qp_entrust_image` VALUES ('17', '38', '4', 'uploads/weituo/201812/647d07ac0c35c8fe897d6ade0baeaae7.jpg', '1545275000');
INSERT INTO `qp_entrust_image` VALUES ('18', '38', '5', 'uploads/weituo/201812/b649d6144e08d2be3b9ce4ac464a84a6.png', '1545275000');
INSERT INTO `qp_entrust_image` VALUES ('19', '38', '6', 'uploads/weituo/201812/c20505681f963b44f3bfc1f9eb7a3e0e.png', '1545275000');
INSERT INTO `qp_entrust_image` VALUES ('20', '38', '7', 'uploads/weituo/201812/b0b5c81a2eaa47e56889a1aa70f89bc5.png', '1545275000');
INSERT INTO `qp_entrust_image` VALUES ('21', '38', '8', 'uploads/weituo/201812/d59ee6c6d7112ffd4cdf623d36dcf446.jpg', '1545275000');
INSERT INTO `qp_entrust_image` VALUES ('22', '38', '9', 'uploads/weituo/201812/4f4981c3f3bf08e98074049949315bf1.jpg', '1545275000');
INSERT INTO `qp_entrust_image` VALUES ('23', '39', '1', 'uploads/weituo/201812/89564c02539a00e7423c779a00908cb9.jpg', '1545286291');
INSERT INTO `qp_entrust_image` VALUES ('24', '40', '1', 'uploads/weituo/201901/e48ef306d06b83a0044ea27ea10df4ba.jpg', '1547798607');

-- ----------------------------
-- Table structure for `qp_kd_setting`
-- ----------------------------
DROP TABLE IF EXISTS `qp_kd_setting`;
CREATE TABLE `qp_kd_setting` (
  `kd_setting_id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `key` char(50) NOT NULL,
  `customer` char(100) NOT NULL,
  `secret` char(100) NOT NULL,
  PRIMARY KEY (`kd_setting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_kd_setting
-- ----------------------------
INSERT INTO `qp_kd_setting` VALUES ('1', 'HqoIXdJK8609', 'E78A2D80047B3FD188F365DCF215DDA2', '2c85205c0d39440dbfa4c26abc126513');

-- ----------------------------
-- Table structure for `qp_member_price`
-- ----------------------------
DROP TABLE IF EXISTS `qp_member_price`;
CREATE TABLE `qp_member_price` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `sort` tinyint(2) NOT NULL,
  `member_introduce` text,
  `level` tinyint(1) NOT NULL,
  `time` int(10) DEFAULT NULL COMMENT '服务时间（秒）',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qp_member_price
-- ----------------------------
INSERT INTO `qp_member_price` VALUES ('12', 'VIP1', '0.01', '3', '第一章节点播无限制\n \n第一章节点播无限制\n\n第二章节点播无限制\n\n第三章节点播无限制\n\n第四章节点播无限制', '1', null, '1544168093');
INSERT INTO `qp_member_price` VALUES ('13', 'VIP2', '0.02', '2', '第一章节点播无限制\n \n第一章节点播无限制\n\n第二章节点播无限制\n\n第三章节点播无限制\n\n第四章节点播无限制', '2', null, '1544168116');
INSERT INTO `qp_member_price` VALUES ('14', 'VIP3', '0.03', '1', '第一章节点播无限制\n \n第一章节点播无限制\n\n第二章节点播无限制\n\n第三章节点播无限制\n\n第四章节点播无限制', '3', null, '1544520643');

-- ----------------------------
-- Table structure for `qp_nav`
-- ----------------------------
DROP TABLE IF EXISTS `qp_nav`;
CREATE TABLE `qp_nav` (
  `nav_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自定义导航表',
  `cover_src` char(255) NOT NULL COMMENT '封面图片',
  `nav_title` char(20) NOT NULL COMMENT '名称',
  `path_index` int(10) DEFAULT NULL COMMENT '跳转路径',
  `path` char(255) NOT NULL,
  `ext` char(255) NOT NULL,
  `ext_str` char(50) NOT NULL,
  `display` tinyint(1) DEFAULT '1',
  `nav_type` tinyint(1) DEFAULT '1',
  `sort` int(5) NOT NULL DEFAULT '1',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`nav_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_nav
-- ----------------------------
INSERT INTO `qp_nav` VALUES ('17', 'uploads/nav/201901/3dc00cde4a8feab1764466bc90bb8b21.jpg', '钱币', null, '', '', '', '1', '1', '1', '1547693828');
INSERT INTO `qp_nav` VALUES ('18', 'uploads/nav/201901/f2c54bdb46fef90e24c59b835c46d2ef.jpg', '邮品', null, '', '', '', '1', '1', '1', '1547693849');
INSERT INTO `qp_nav` VALUES ('19', 'uploads/nav/201901/9f7992b713edff9723fddff51c90bd43.jpg', '一口价', null, '', '', '', '1', '1', '1', '1547694015');
INSERT INTO `qp_nav` VALUES ('20', 'uploads/nav/201901/00eddf42a7325ea0959dd8290ee8d9f9.jpg', '即拍', null, '', '', '', '1', '1', '1', '1547694043');
INSERT INTO `qp_nav` VALUES ('21', 'uploads/nav/201901/d4027d7cc4fbea4391af236937dbfdbc.jpg', '杂项', null, '', '', '', '1', '1', '1', '1547694058');
INSERT INTO `qp_nav` VALUES ('22', 'uploads/nav/201901/da31be7da6f0fc62e31a1e29ee4c4b5d.jpg', '我的关注', '7', '/pages/mine/attention/attention', '', '', '1', '2', '1', '1547706753');
INSERT INTO `qp_nav` VALUES ('23', 'uploads/nav/201901/0121099decdd8164607dc00c6fda7c02.jpg', '优惠卡券', '9', '/pages/mine/card/card', '', '', '1', '2', '1', '1547706771');
INSERT INTO `qp_nav` VALUES ('24', 'uploads/nav/201901/205fef6f087f633573ae4f8cff8d1bb6.jpg', '交易记录', '6', '/pages/mine/TransactionRecords/TransactionRecords', '', '', '1', '2', '1', '1547706784');
INSERT INTO `qp_nav` VALUES ('25', 'uploads/nav/201901/31c33620afb2f9bc8b500d43ed7fc9a3.jpg', '入住即拍', null, '', '', '', '1', '2', '1', '1547706811');
INSERT INTO `qp_nav` VALUES ('26', 'uploads/nav/201901/cb093b6dfaa34837b63cd6ed92432ca6.jpg', '使用教程', null, '', '', '', '1', '2', '1', '1547706827');
INSERT INTO `qp_nav` VALUES ('27', 'uploads/nav/201901/89222629a382e02ed81dd6ecd4c6160e.jpg', '藏品保障', null, '', '', '', '1', '2', '1', '1547706842');
INSERT INTO `qp_nav` VALUES ('28', 'uploads/nav/201901/74d28f21e512cae1e46d43dfc7bca8a1.jpg', '帮助中心', null, '', '', '', '1', '2', '1', '1547706855');
INSERT INTO `qp_nav` VALUES ('29', 'uploads/nav/201901/014bf695b929cc6bcad855045954354f.jpg', '关于我们', null, '', '', '', '1', '2', '1', '1547706868');

-- ----------------------------
-- Table structure for `qp_product`
-- ----------------------------
DROP TABLE IF EXISTS `qp_product`;
CREATE TABLE `qp_product` (
  `product_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `product_name` varchar(100) NOT NULL COMMENT '产品名称',
  `product_cover` char(255) NOT NULL COMMENT '产品封面',
  `cover_introduce` char(255) DEFAULT NULL COMMENT '产品封面介绍',
  `product_introduce` text NOT NULL COMMENT '产品简介',
  `product_money` decimal(10,2) DEFAULT NULL COMMENT '产品价格',
  `cate_id_first` int(11) DEFAULT NULL COMMENT '一级分类',
  `cate_id_second` int(11) DEFAULT NULL COMMENT '二级分类',
  `cate_id_third` int(11) DEFAULT NULL COMMENT '三级分类',
  `collection_id` int(10) DEFAULT NULL,
  `product_collection_share` tinyint(1) NOT NULL DEFAULT '1' COMMENT '专场精品推荐（1、不推荐；2、推荐）',
  `express_info` text COMMENT '邮费信息',
  `product_face` tinyint(1) NOT NULL,
  `product_zysx` varchar(255) NOT NULL,
  `product_times` decimal(10,2) DEFAULT NULL,
  `product_sort` int(10) NOT NULL DEFAULT '1' COMMENT '产品排序',
  `product_type` tinyint(1) DEFAULT '1' COMMENT '1、竞价；2、一口价',
  `product_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态（1、在售；2、下架）',
  `product_end` tinyint(1) DEFAULT '1' COMMENT '拍卖是否结束（1、未结束；2、已结束）',
  `product_share_index` tinyint(1) DEFAULT '1' COMMENT '1、不推荐；2、推荐',
  `product_start_time` int(10) DEFAULT NULL COMMENT '竞价开始时间',
  `product_end_time` int(10) DEFAULT NULL COMMENT '竞价结束时间',
  `product_time` int(10) NOT NULL COMMENT '产品添加时间',
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_product
-- ----------------------------
INSERT INTO `qp_product` VALUES ('127', '拍卖中34 45 48', 'uploads/productCover/201812/ed52dc41becdfc062eaa0764595d482c.jpg', '2', '<p>2</p><p><br></p>', '1.00', '34', '44', '51', '56', '2', '', '3', '1', '312.00', '1', '1', '1', '1', '2', '1546358400', '1548400532', '1545962366');
INSERT INTO `qp_product` VALUES ('128', '元旦预览专场', 'uploads/productCover/201812/9c7a2fc6adc725516f4a92fbdc116f8a.jpg', '1', '<p>1</p><p><br></p>', '1.00', '34', '57', '58', '56', '2', null, '3', '1', '5.00', '1', '1', '1', '2', '2', '1546358400', '1', '1545962411');
INSERT INTO `qp_product` VALUES ('129', '一口价柚子', 'uploads/productCover/201812/4889f254cafba86dd3dc954fd4abf18a.jpg', '1', '<p>1</p>', '1.00', '34', '57', '58', '52', '1', '', '1', '1', null, '1', '2', '1', '1', '1', null, null, '1545962445');
INSERT INTO `qp_product` VALUES ('130', '民国邮票', 'uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg', '1', '<p>1&nbsp; &nbsp; 1</p>', '1.00', '34', '45', '47', '51', '1', '[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]', '1', '1', null, '1', '2', '1', '2', '1', null, null, '1546065696');

-- ----------------------------
-- Table structure for `qp_product_banner`
-- ----------------------------
DROP TABLE IF EXISTS `qp_product_banner`;
CREATE TABLE `qp_product_banner` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '产品Banner',
  `product_id` int(10) NOT NULL COMMENT '产品ID',
  `url` varchar(300) NOT NULL COMMENT '图片地址',
  `sort` tinyint(2) NOT NULL DEFAULT '1' COMMENT '排序',
  `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、展示；2、不展示',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=762 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_product_banner
-- ----------------------------
INSERT INTO `qp_product_banner` VALUES ('757', '37', 'uploads/productBanner/201810/f7d41857913cb81ad5284a7ca6b49c59.jpg', '1', '1', '1540880509');
INSERT INTO `qp_product_banner` VALUES ('758', '116', 'uploads/productBanner/201812/2860d43d83f8b09234c8fc6318e47af1.jpg', '1', '1', '1545035574');
INSERT INTO `qp_product_banner` VALUES ('759', '128', 'uploads/productBanner/201901/ace7c83191f4ca9865063f4b2114df31.jpg', '1', '1', '1546659391');
INSERT INTO `qp_product_banner` VALUES ('760', '130', 'uploads/productBanner/201901/a362f9408799f5aaae7f84e050e9a814.jpg', '1', '1', '1546659412');
INSERT INTO `qp_product_banner` VALUES ('761', '130', 'uploads/productBanner/201901/0521cd75f01728dc3778c4a3fd6fb04a.jpg', '1', '1', '1546659427');

-- ----------------------------
-- Table structure for `qp_prod_list`
-- ----------------------------
DROP TABLE IF EXISTS `qp_prod_list`;
CREATE TABLE `qp_prod_list` (
  `list_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `order_number` char(30) NOT NULL COMMENT '订单号',
  `transaction_id` char(28) DEFAULT NULL COMMENT '微信支付凭证',
  `express_id` int(10) DEFAULT NULL,
  `express_money` decimal(10,2) DEFAULT NULL COMMENT '邮费价格',
  `product_money` decimal(10,2) NOT NULL COMMENT '产品应付价格（竞价商品时为竞得价）',
  `pay_money` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `coupon_money` decimal(10,2) DEFAULT NULL COMMENT '优惠券优惠价格',
  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否支付（1、未支付；2、已支付（待发货）；3、申请发货中；4、已发货；5、已确认收货）',
  `coupon_id` int(10) DEFAULT NULL COMMENT '优惠券ID',
  `pay_requset_info` text COMMENT '拉起支付的信息',
  `list_type` tinyint(1) DEFAULT NULL COMMENT '订单类型（1、竞拍订单；2、一口价订单）',
  `list_add_time` int(10) NOT NULL COMMENT '订单生成时间',
  `list_pay_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=443 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_prod_list
-- ----------------------------
INSERT INTO `qp_prod_list` VALUES ('430', '2721', '310387782721583', '1547106037', '4', '60.00', '61.00', '61.00', null, '2', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"evrz6gikr4tawij3bdqk8qt28lil7d6m\\\",\\\"package\\\":\\\"prepay_id=wx071117175839284ca488e0d92883959344\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1546831038\\\",\\\"paySign\\\":\\\"C400E602BFC5D27994A09666989661FC76B2ECA89B288D265AC5121D28232A94\\\"}\"', '2', '1546831038', '1547106037');
INSERT INTO `qp_prod_list` VALUES ('431', '2721', '326856392721161', null, '3', '15.00', '16.00', '16.00', null, '1', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"c6mx2y6cm4xuc0qh0975rz7vsos2v9u4\\\",\\\"package\\\":\\\"prepay_id=wx071144450510685777d0f26f2642452076\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1546832685\\\",\\\"paySign\\\":\\\"397DFBF6CFCC0E6DBF5A02AE9DCB2A0F766C1151A9284AC0BB42A1DAE98F105F\\\"}\"', '2', '1546832685', null);
INSERT INTO `qp_prod_list` VALUES ('432', '2721', '501568532721314', '143322314332231433223', '0', '0.00', '7.77', '7.77', null, '2', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"842o9lfzcmmwg2km4du35czafgm7wyz9\\\",\\\"package\\\":\\\"prepay_id=wx071635562197238f866fafd21568615346\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1546850157\\\",\\\"paySign\\\":\\\"508DA32BE3C2CDE2D8AC59C3BBA1D1A15AF3E9111CAE4F50711935BBE2F42705\\\"}\"', '1', '1546850156', '1547087043');
INSERT INTO `qp_prod_list` VALUES ('433', '2721', '550518602721279', null, '3', '15.00', '19.44', '19.44', null, '1', null, null, '1', '1546855051', null);
INSERT INTO `qp_prod_list` VALUES ('434', '2721', '551234112721877', null, '3', '15.00', '19.44', '19.44', null, '1', null, null, '1', '1546855123', null);
INSERT INTO `qp_prod_list` VALUES ('435', '2721', '551412012721449', null, '3', '15.00', '19.44', '19.44', null, '1', null, null, '1', '1546855141', null);
INSERT INTO `qp_prod_list` VALUES ('436', '2721', '551648022721908', null, '3', '15.00', '19.44', '19.44', null, '1', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"lfcnicjc8s9t83xrglh489nhwecb1y8t\\\",\\\"package\\\":\\\"prepay_id=wx071759240136822bd5191f9e3494958795\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1546855165\\\",\\\"paySign\\\":\\\"478810622C80DF5EDFAD7599473448A07E41B78F0BAB7F134A053B8BC657687A\\\"}\"', '1', '1546855164', null);
INSERT INTO `qp_prod_list` VALUES ('437', '2721', '160162582721401', null, '2', '0.00', '1.00', '1.00', null, '1', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"hr85verkcxxsyd8r865eqa9a1z2aheo3\\\",\\\"package\\\":\\\"prepay_id=wx09144015702876e7cf88ffc13110623160\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1547016017\\\",\\\"paySign\\\":\\\"BDA0B00B3C61858C55C2775F994A376B7CB211413C9D03C7F17DBED27A2C5DC7\\\"}\"', '2', '1547016016', null);
INSERT INTO `qp_prod_list` VALUES ('438', '2721', '170611812721729', null, '0', '0.00', '3.33', '1.33', '2.00', '1', '399', '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"965u1y866yueeezah2ypatw1wd8ubk1h\\\",\\\"package\\\":\\\"prepay_id=wx0914574029651076401814641472640583\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1547017061\\\",\\\"paySign\\\":\\\"C9E56BDA5B8C87CEACA12BB6147A4D2BFC28ADA7CB66AF4CE5B2FC2805E13D6A\\\"}\"', '1', '1547017061', null);
INSERT INTO `qp_prod_list` VALUES ('439', '2721', '257357452721623', '143322314332231433223', '2', '0.00', '1.00', '1.00', null, '2', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"e35oodg2760n0q39vhs0kph3czfsfeqw\\\",\\\"package\\\":\\\"prepay_id=wx09172215335136ca3f0fdfeb3437037079\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1547025736\\\",\\\"paySign\\\":\\\"12F7DB33BB02F06E4E93258D8B2A277AA3F8DFD7A9052A22F638860926E2845B\\\"}\"', '2', '1547025735', '1547109507');
INSERT INTO `qp_prod_list` VALUES ('440', '2721', '906288152721160', null, '2', '0.00', '1.00', '1.00', null, '1', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"osrvx9ru1hqklsp47unl9k559evelqu4\\\",\\\"package\\\":\\\"prepay_id=wx11151026947996fe4f6dd9220894721550\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1547190629\\\",\\\"paySign\\\":\\\"E1DBBF979A0D2EF1A395DCA6D26F79F3452F05A726E42955B59FAF897BCB1353\\\"}\"', '2', '1547190628', null);
INSERT INTO `qp_prod_list` VALUES ('441', '2721', '624813212721160', null, '0', '0.00', '3.33', '3.33', null, '1', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"2wzyfzt0h06hjq5vuf0knru7mb4cnrxe\\\",\\\"package\\\":\\\"prepay_id=wx12110801193841ea9286846d2173678357\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1547262482\\\",\\\"paySign\\\":\\\"7300BBA48BF78E461D9975F588E965C3E24D3EDF4CA1A2C2B3653EFB9A8E36EC\\\"}\"', '1', '1547262481', null);
INSERT INTO `qp_prod_list` VALUES ('442', '2721', '297879392721309', null, '0', '0.00', '1.00', '1.00', null, '1', null, '\"{\\\"appId\\\":\\\"wx6ca7934dacd6334e\\\",\\\"nonceStr\\\":\\\"6e1thly3ki96h1yu9mknyprofnm1evow\\\",\\\"package\\\":\\\"prepay_id=wx14093627255713143f8b1e070578852880\\\",\\\"signType\\\":\\\"HMAC-SHA256\\\",\\\"timeStamp\\\":\\\"1547429788\\\",\\\"paySign\\\":\\\"1939D46AF66B1D483A13BCCA70B973EC43A069D8D536A7401F543FB826FF6702\\\"}\"', '2', '1547429787', null);

-- ----------------------------
-- Table structure for `qp_prod_list_between`
-- ----------------------------
DROP TABLE IF EXISTS `qp_prod_list_between`;
CREATE TABLE `qp_prod_list_between` (
  `between_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单商品中间表',
  `get_id` int(10) DEFAULT NULL COMMENT '得表表主键ID',
  `user_id` int(10) NOT NULL,
  `list_id` int(10) NOT NULL,
  `transaction_id` char(30) DEFAULT NULL,
  `order_number` char(30) NOT NULL,
  `product_id` int(10) NOT NULL,
  `product_info` text NOT NULL COMMENT '商品信息',
  `result_money` decimal(10,2) NOT NULL COMMENT '成交价格（不含服务费）',
  `server_money` decimal(10,2) NOT NULL COMMENT '服务费',
  `total_price` decimal(10,2) NOT NULL COMMENT '应付总价（不含邮费）',
  `pay_money` decimal(10,2) NOT NULL COMMENT '单件商品最终实付金额（含邮费）',
  `express_id` int(10) DEFAULT NULL COMMENT '快递邮费ID',
  `express_money` decimal(10,2) DEFAULT NULL COMMENT '邮费价格',
  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、未支付；2、已支付',
  `list_type` tinyint(1) NOT NULL COMMENT '订单类型（1、竞拍订单；2、一口价订单）',
  `tracking_number` char(20) DEFAULT NULL COMMENT '物流单号',
  `on_hand_time` int(10) DEFAULT NULL COMMENT '到手时间',
  `pay_time` int(10) DEFAULT NULL,
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`between_id`)
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_prod_list_between
-- ----------------------------
INSERT INTO `qp_prod_list_between` VALUES ('62', null, '2721', '430', null, '310383712721306130', '130', 'O:24:\"app\\common\\model\\Product\":34:{s:13:\"\0*\0connection\";a:0:{}s:9:\"\0*\0parent\";N;s:8:\"\0*\0query\";N;s:7:\"\0*\0name\";s:7:\"Product\";s:8:\"\0*\0table\";N;s:8:\"\0*\0class\";s:24:\"app\\common\\model\\Product\";s:8:\"\0*\0error\";N;s:11:\"\0*\0validate\";N;s:5:\"\0*\0pk\";N;s:8:\"\0*\0field\";a:0:{}s:9:\"\0*\0except\";a:0:{}s:9:\"\0*\0disuse\";a:0:{}s:11:\"\0*\0readonly\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:9:\"\0*\0hidden\";a:0:{}s:9:\"\0*\0append\";a:0:{}s:7:\"\0*\0data\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:9:\"\0*\0origin\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:11:\"\0*\0relation\";a:0:{}s:7:\"\0*\0auto\";a:0:{}s:9:\"\0*\0insert\";a:0:{}s:9:\"\0*\0update\";a:0:{}s:21:\"\0*\0autoWriteTimestamp\";b:0;s:13:\"\0*\0createTime\";s:11:\"create_time\";s:13:\"\0*\0updateTime\";s:11:\"update_time\";s:13:\"\0*\0dateFormat\";s:11:\"Y-m-d H:i:s\";s:7:\"\0*\0type\";a:0:{}s:11:\"\0*\0isUpdate\";b:1;s:14:\"\0*\0updateWhere\";N;s:16:\"\0*\0failException\";b:0;s:17:\"\0*\0useGlobalScope\";b:1;s:16:\"\0*\0batchValidate\";b:0;s:16:\"\0*\0resultSetType\";s:17:\"\\think\\Collection\";s:16:\"\0*\0relationWrite\";N;}', '1.00', '0.00', '1.00', '61.00', '4', '60.00', '1', '2', null, null, null, '1546831038');
INSERT INTO `qp_prod_list_between` VALUES ('63', null, '2721', '431', null, '326853762721116130', '130', 'O:24:\"app\\common\\model\\Product\":34:{s:13:\"\0*\0connection\";a:0:{}s:9:\"\0*\0parent\";N;s:8:\"\0*\0query\";N;s:7:\"\0*\0name\";s:7:\"Product\";s:8:\"\0*\0table\";N;s:8:\"\0*\0class\";s:24:\"app\\common\\model\\Product\";s:8:\"\0*\0error\";N;s:11:\"\0*\0validate\";N;s:5:\"\0*\0pk\";N;s:8:\"\0*\0field\";a:0:{}s:9:\"\0*\0except\";a:0:{}s:9:\"\0*\0disuse\";a:0:{}s:11:\"\0*\0readonly\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:9:\"\0*\0hidden\";a:0:{}s:9:\"\0*\0append\";a:0:{}s:7:\"\0*\0data\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:9:\"\0*\0origin\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:11:\"\0*\0relation\";a:0:{}s:7:\"\0*\0auto\";a:0:{}s:9:\"\0*\0insert\";a:0:{}s:9:\"\0*\0update\";a:0:{}s:21:\"\0*\0autoWriteTimestamp\";b:0;s:13:\"\0*\0createTime\";s:11:\"create_time\";s:13:\"\0*\0updateTime\";s:11:\"update_time\";s:13:\"\0*\0dateFormat\";s:11:\"Y-m-d H:i:s\";s:7:\"\0*\0type\";a:0:{}s:11:\"\0*\0isUpdate\";b:1;s:14:\"\0*\0updateWhere\";N;s:16:\"\0*\0failException\";b:0;s:17:\"\0*\0useGlobalScope\";b:1;s:16:\"\0*\0batchValidate\";b:0;s:16:\"\0*\0resultSetType\";s:17:\"\\think\\Collection\";s:16:\"\0*\0relationWrite\";N;}', '1.00', '0.00', '1.00', '16.00', '3', '15.00', '3', '2', null, '1547430785', null, '1546832685');
INSERT INTO `qp_prod_list_between` VALUES ('64', '6', '2721', '432', '143322314332231433223', '501567472721811127', '127', 'a:23:{s:10:\"product_id\";i:127;s:12:\"product_name\";s:9:\"拍卖中\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/ed52dc41becdfc062eaa0764595d482c.jpg\";s:15:\"cover_introduce\";s:1:\"2\";s:17:\"product_introduce\";s:8:\"<p>2</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:57;s:13:\"cate_id_third\";i:58;s:13:\"collection_id\";i:52;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:0:\"\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";s:4:\"1.00\";s:12:\"product_sort\";i:1;s:12:\"product_type\";i:1;s:14:\"product_status\";i:1;s:11:\"product_end\";i:2;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";i:1545840000;s:16:\"product_end_time\";i:1546012800;s:12:\"product_time\";i:1545962366;}', '3.00', '0.33', '3.33', '3.33', '0', '0.00', '5', '1', '669549436693', '1547430785', '1547087043', '1546850156');
INSERT INTO `qp_prod_list_between` VALUES ('65', '7', '2721', '432', '143322314332231433223', '501568562721993128', '128', 'a:23:{s:10:\"product_id\";i:128;s:12:\"product_name\";s:18:\"元旦预览专场\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/9c7a2fc6adc725516f4a92fbdc116f8a.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:8:\"<p>1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:57;s:13:\"cate_id_third\";i:58;s:13:\"collection_id\";i:52;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";N;s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";s:4:\"1.00\";s:12:\"product_sort\";i:1;s:12:\"product_type\";i:1;s:14:\"product_status\";i:1;s:11:\"product_end\";i:2;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";i:1546272000;s:16:\"product_end_time\";i:1546444800;s:12:\"product_time\";i:1545962411;}', '4.00', '0.44', '4.44', '4.44', '0', '0.00', '5', '1', '123123123', '1547430785', '1547087043', '1546850156');
INSERT INTO `qp_prod_list_between` VALUES ('66', '7', '2721', '436', null, '551648822721249130', '130', 'a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}', '4.00', '0.44', '4.44', '19.44', '3', '15.00', '3', '1', '213123231', null, null, '1546855164');
INSERT INTO `qp_prod_list_between` VALUES ('67', null, '2721', '437', null, '160166702721835130', '130', 'O:24:\"app\\common\\model\\Product\":34:{s:13:\"\0*\0connection\";a:0:{}s:9:\"\0*\0parent\";N;s:8:\"\0*\0query\";N;s:7:\"\0*\0name\";s:7:\"Product\";s:8:\"\0*\0table\";N;s:8:\"\0*\0class\";s:24:\"app\\common\\model\\Product\";s:8:\"\0*\0error\";N;s:11:\"\0*\0validate\";N;s:5:\"\0*\0pk\";N;s:8:\"\0*\0field\";a:0:{}s:9:\"\0*\0except\";a:0:{}s:9:\"\0*\0disuse\";a:0:{}s:11:\"\0*\0readonly\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:9:\"\0*\0hidden\";a:0:{}s:9:\"\0*\0append\";a:0:{}s:7:\"\0*\0data\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:9:\"\0*\0origin\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:11:\"\0*\0relation\";a:0:{}s:7:\"\0*\0auto\";a:0:{}s:9:\"\0*\0insert\";a:0:{}s:9:\"\0*\0update\";a:0:{}s:21:\"\0*\0autoWriteTimestamp\";b:0;s:13:\"\0*\0createTime\";s:11:\"create_time\";s:13:\"\0*\0updateTime\";s:11:\"update_time\";s:13:\"\0*\0dateFormat\";s:11:\"Y-m-d H:i:s\";s:7:\"\0*\0type\";a:0:{}s:11:\"\0*\0isUpdate\";b:1;s:14:\"\0*\0updateWhere\";N;s:16:\"\0*\0failException\";b:0;s:17:\"\0*\0useGlobalScope\";b:1;s:16:\"\0*\0batchValidate\";b:0;s:16:\"\0*\0resultSetType\";s:17:\"\\think\\Collection\";s:16:\"\0*\0relationWrite\";N;}', '1.00', '0.00', '1.00', '1.00', '2', '0.00', '3', '2', null, null, null, '1547016016');
INSERT INTO `qp_prod_list_between` VALUES ('68', '6', '2721', '438', null, '170615822721222127', '127', 'a:23:{s:10:\"product_id\";i:127;s:12:\"product_name\";s:9:\"拍卖中\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/ed52dc41becdfc062eaa0764595d482c.jpg\";s:15:\"cover_introduce\";s:1:\"2\";s:17:\"product_introduce\";s:8:\"<p>2</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:57;s:13:\"cate_id_third\";i:58;s:13:\"collection_id\";i:52;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:0:\"\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";s:4:\"1.00\";s:12:\"product_sort\";i:1;s:12:\"product_type\";i:1;s:14:\"product_status\";i:1;s:11:\"product_end\";i:2;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";i:1545840000;s:16:\"product_end_time\";i:1546012800;s:12:\"product_time\";i:1545962366;}', '3.00', '0.33', '3.33', '3.33', '0', '0.00', '3', '1', null, null, null, '1547017061');
INSERT INTO `qp_prod_list_between` VALUES ('69', '7', '2721', '439', '143322314332231433223', '257357382721849130', '130', 'O:24:\"app\\common\\model\\Product\":34:{s:13:\"\0*\0connection\";a:0:{}s:9:\"\0*\0parent\";N;s:8:\"\0*\0query\";N;s:7:\"\0*\0name\";s:7:\"Product\";s:8:\"\0*\0table\";N;s:8:\"\0*\0class\";s:24:\"app\\common\\model\\Product\";s:8:\"\0*\0error\";N;s:11:\"\0*\0validate\";N;s:5:\"\0*\0pk\";N;s:8:\"\0*\0field\";a:0:{}s:9:\"\0*\0except\";a:0:{}s:9:\"\0*\0disuse\";a:0:{}s:11:\"\0*\0readonly\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:9:\"\0*\0hidden\";a:0:{}s:9:\"\0*\0append\";a:0:{}s:7:\"\0*\0data\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:9:\"\0*\0origin\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:11:\"\0*\0relation\";a:0:{}s:7:\"\0*\0auto\";a:0:{}s:9:\"\0*\0insert\";a:0:{}s:9:\"\0*\0update\";a:0:{}s:21:\"\0*\0autoWriteTimestamp\";b:0;s:13:\"\0*\0createTime\";s:11:\"create_time\";s:13:\"\0*\0updateTime\";s:11:\"update_time\";s:13:\"\0*\0dateFormat\";s:11:\"Y-m-d H:i:s\";s:7:\"\0*\0type\";a:0:{}s:11:\"\0*\0isUpdate\";b:1;s:14:\"\0*\0updateWhere\";N;s:16:\"\0*\0failException\";b:0;s:17:\"\0*\0useGlobalScope\";b:1;s:16:\"\0*\0batchValidate\";b:0;s:16:\"\0*\0resultSetType\";s:17:\"\\think\\Collection\";s:16:\"\0*\0relationWrite\";N;}', '1.00', '0.00', '1.00', '1.00', '2', '0.00', '6', '2', null, null, '1547109267', '1547025735');
INSERT INTO `qp_prod_list_between` VALUES ('70', null, '2721', '440', null, '906284682721850130', '130', 'O:24:\"app\\common\\model\\Product\":34:{s:13:\"\0*\0connection\";a:0:{}s:9:\"\0*\0parent\";N;s:8:\"\0*\0query\";N;s:7:\"\0*\0name\";s:7:\"Product\";s:8:\"\0*\0table\";N;s:8:\"\0*\0class\";s:24:\"app\\common\\model\\Product\";s:8:\"\0*\0error\";N;s:11:\"\0*\0validate\";N;s:5:\"\0*\0pk\";N;s:8:\"\0*\0field\";a:0:{}s:9:\"\0*\0except\";a:0:{}s:9:\"\0*\0disuse\";a:0:{}s:11:\"\0*\0readonly\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:9:\"\0*\0hidden\";a:0:{}s:9:\"\0*\0append\";a:0:{}s:7:\"\0*\0data\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:9:\"\0*\0origin\";a:23:{s:10:\"product_id\";i:130;s:12:\"product_name\";s:12:\"民国邮票\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/eb3566bac47c9c766c20133b41335ca6.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:23:\"<p>1&nbsp; &nbsp; 1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:45;s:13:\"cate_id_third\";i:47;s:13:\"collection_id\";i:51;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:1011:\"[{\"money\":\"999\",\"name\":\"\\u987a\\u4e30\\u5230\\u4ed8\",\"description\":\"\\u8bf7\\u586b\\u5199\\u987a\\u4e30\\u5230\\u4ed8\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"12\",\"name\":\"Ems\",\"description\":\"\\u8bf7\\u586b\\u5199Ems\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"0\",\"name\":\"\\u4e0a\\u95e8\\u81ea\\u63d0\",\"description\":\"\\u8bf7\\u586b\\u5199\\u4e0a\\u95e8\\u81ea\\u63d0\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":true},{\"money\":\"15\",\"name\":\"\\u5176\\u4ed6\\u5feb\\u9012\",\"description\":\"\\u8bf7\\u586b\\u5199\\u5176\\u4ed6\\u5feb\\u9012\\u5bc4\\u4ef6\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null},{\"money\":\"60\",\"name\":\"\\u6682\\u5b58\",\"description\":\"\\u8bf7\\u586b\\u5199\\u6682\\u5b58\\u7684\\u4ef7\\u683c\\uff0c\\u514d\\u8d39\\u5219\\u586b0\\uff0c\\u5355\\u4f4d\\uff08\\u5143\\uff09\",\"current\":null}]\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1546065696;}s:11:\"\0*\0relation\";a:0:{}s:7:\"\0*\0auto\";a:0:{}s:9:\"\0*\0insert\";a:0:{}s:9:\"\0*\0update\";a:0:{}s:21:\"\0*\0autoWriteTimestamp\";b:0;s:13:\"\0*\0createTime\";s:11:\"create_time\";s:13:\"\0*\0updateTime\";s:11:\"update_time\";s:13:\"\0*\0dateFormat\";s:11:\"Y-m-d H:i:s\";s:7:\"\0*\0type\";a:0:{}s:11:\"\0*\0isUpdate\";b:1;s:14:\"\0*\0updateWhere\";N;s:16:\"\0*\0failException\";b:0;s:17:\"\0*\0useGlobalScope\";b:1;s:16:\"\0*\0batchValidate\";b:0;s:16:\"\0*\0resultSetType\";s:17:\"\\think\\Collection\";s:16:\"\0*\0relationWrite\";N;}', '1.00', '0.00', '1.00', '1.00', '2', '0.00', '1', '2', null, null, null, '1547190628');
INSERT INTO `qp_prod_list_between` VALUES ('71', '6', '2721', '441', null, '624812412721499127', '127', 'a:23:{s:10:\"product_id\";i:127;s:12:\"product_name\";s:9:\"拍卖中\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/ed52dc41becdfc062eaa0764595d482c.jpg\";s:15:\"cover_introduce\";s:1:\"2\";s:17:\"product_introduce\";s:8:\"<p>2</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:57;s:13:\"cate_id_third\";i:58;s:13:\"collection_id\";i:52;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:0:\"\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";s:4:\"1.00\";s:12:\"product_sort\";i:1;s:12:\"product_type\";i:1;s:14:\"product_status\";i:1;s:11:\"product_end\";i:2;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";i:1545840000;s:16:\"product_end_time\";i:1546012800;s:12:\"product_time\";i:1545962366;}', '3.00', '0.33', '3.33', '3.33', '0', '0.00', '1', '1', null, null, null, '1547262481');
INSERT INTO `qp_prod_list_between` VALUES ('72', null, '2721', '442', null, '297879602721755129', '129', 'O:24:\"app\\common\\model\\Product\":34:{s:13:\"\0*\0connection\";a:0:{}s:9:\"\0*\0parent\";N;s:8:\"\0*\0query\";N;s:7:\"\0*\0name\";s:7:\"Product\";s:8:\"\0*\0table\";N;s:8:\"\0*\0class\";s:24:\"app\\common\\model\\Product\";s:8:\"\0*\0error\";N;s:11:\"\0*\0validate\";N;s:5:\"\0*\0pk\";N;s:8:\"\0*\0field\";a:0:{}s:9:\"\0*\0except\";a:0:{}s:9:\"\0*\0disuse\";a:0:{}s:11:\"\0*\0readonly\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:9:\"\0*\0hidden\";a:0:{}s:9:\"\0*\0append\";a:0:{}s:7:\"\0*\0data\";a:23:{s:10:\"product_id\";i:129;s:12:\"product_name\";s:15:\"一口价柚子\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/4889f254cafba86dd3dc954fd4abf18a.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:8:\"<p>1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:57;s:13:\"cate_id_third\";i:58;s:13:\"collection_id\";i:52;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:0:\"\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1545962445;}s:9:\"\0*\0origin\";a:23:{s:10:\"product_id\";i:129;s:12:\"product_name\";s:15:\"一口价柚子\";s:13:\"product_cover\";s:64:\"uploads/productCover/201812/4889f254cafba86dd3dc954fd4abf18a.jpg\";s:15:\"cover_introduce\";s:1:\"1\";s:17:\"product_introduce\";s:8:\"<p>1</p>\";s:13:\"product_money\";s:4:\"1.00\";s:13:\"cate_id_first\";i:34;s:14:\"cate_id_second\";i:57;s:13:\"cate_id_third\";i:58;s:13:\"collection_id\";i:52;s:24:\"product_collection_share\";i:1;s:12:\"express_info\";s:0:\"\";s:12:\"product_face\";i:1;s:12:\"product_zysx\";s:1:\"1\";s:13:\"product_times\";N;s:12:\"product_sort\";i:1;s:12:\"product_type\";i:2;s:14:\"product_status\";i:1;s:11:\"product_end\";i:1;s:19:\"product_share_index\";i:1;s:18:\"product_start_time\";N;s:16:\"product_end_time\";N;s:12:\"product_time\";i:1545962445;}s:11:\"\0*\0relation\";a:0:{}s:7:\"\0*\0auto\";a:0:{}s:9:\"\0*\0insert\";a:0:{}s:9:\"\0*\0update\";a:0:{}s:21:\"\0*\0autoWriteTimestamp\";b:0;s:13:\"\0*\0createTime\";s:11:\"create_time\";s:13:\"\0*\0updateTime\";s:11:\"update_time\";s:13:\"\0*\0dateFormat\";s:11:\"Y-m-d H:i:s\";s:7:\"\0*\0type\";a:0:{}s:11:\"\0*\0isUpdate\";b:1;s:14:\"\0*\0updateWhere\";N;s:16:\"\0*\0failException\";b:0;s:17:\"\0*\0useGlobalScope\";b:1;s:16:\"\0*\0batchValidate\";b:0;s:16:\"\0*\0resultSetType\";s:17:\"\\think\\Collection\";s:16:\"\0*\0relationWrite\";N;}', '1.00', '0.00', '1.00', '1.00', '0', '0.00', '6', '2', null, null, null, '1547429787');

-- ----------------------------
-- Table structure for `qp_prod_list_comment`
-- ----------------------------
DROP TABLE IF EXISTS `qp_prod_list_comment`;
CREATE TABLE `qp_prod_list_comment` (
  `list_comment_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '评价id',
  `product_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品id',
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `list_id` int(10) NOT NULL COMMENT '订单ID',
  `list_comment_content` text NOT NULL COMMENT '评价内容',
  `list_comment_add_time` int(10) NOT NULL COMMENT '评价时间',
  `list_comment_fid` int(11) DEFAULT NULL COMMENT '评论用户id',
  `list_comment_fid_prolistid` int(11) DEFAULT NULL COMMENT '回复评论id',
  `list_comment_fid_lv` int(1) DEFAULT '1' COMMENT '评论等级 1用户评价 2一级评论(回复)',
  `is_read` tinyint(1) DEFAULT '1' COMMENT '1：未读；2、已读',
  `taoc_id` int(11) DEFAULT '0' COMMENT '套餐id',
  PRIMARY KEY (`list_comment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_prod_list_comment
-- ----------------------------
INSERT INTO `qp_prod_list_comment` VALUES ('76', '106', '267', '231', '哈哈哈哈？', '1543983583', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('77', '106', '267', '231', '这么高兴啊！', '1543983602', '267', '76', '2', '2', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('91', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586454', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('90', '101', '2678', '317', '挺实用的课程，直接用来给家人实际练习，效果真有！', '1544524444', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('89', '106', '267', '231', 'wo ?', '1543998888', '267', '88', '2', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('88', '106', '267', '231', 'ni?', '1543997363', '267', '87', '2', '2', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('87', '106', '267', '231', '!', '1543997335', '267', '77', '2', '2', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('92', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586457', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('93', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586459', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('94', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586460', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('95', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586463', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('96', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586463', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('97', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586464', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('98', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586465', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('99', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586466', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('100', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586467', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('101', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586468', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('102', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586468', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('103', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586468', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('104', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586469', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('105', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586470', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('106', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586470', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('107', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586470', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('108', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586471', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('109', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586471', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('110', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586471', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('111', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586471', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('112', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586472', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('113', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586472', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('114', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586472', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('115', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586473', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('116', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586473', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('117', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586473', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('118', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586473', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('119', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586474', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('120', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586474', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('121', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586474', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('122', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586474', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('123', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586475', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('124', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586475', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('125', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586476', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('126', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586476', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('127', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586476', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('128', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586478', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('129', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586479', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('130', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586484', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('131', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586484', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('132', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586484', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('133', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586485', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('134', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586485', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('135', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586485', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('136', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586486', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('137', '100', '2679', '328', '有用，终于可以坐在家里学梅花针了，得出时间再参加陈老师的亲授课堂！', '1544586492', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('138', '101', '2679', '317', '真的吗？', '1544587249', '2678', '90', '2', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('139', '101', '267', '310', '1231132312', '1544588167', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('140', '101', '267', '310', '1231132312', '1544588168', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('141', '101', '267', '310', '1231132312', '1544588234', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('142', '101', '267', '310', '12313231213', '1544588339', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('143', '101', '267', '310', '12313231213', '1544588339', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('144', '101', '267', '310', '12313231213', '1544588340', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('145', '101', '267', '310', '12313231213', '1544588340', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('146', '101', '267', '310', '12313231213', '1544588340', null, null, '1', '1', '0');
INSERT INTO `qp_prod_list_comment` VALUES ('147', '101', '267', '310', '213123312', '1544588384', null, null, '1', '1', '0');

-- ----------------------------
-- Table structure for `qp_prod_list_comment_img`
-- ----------------------------
DROP TABLE IF EXISTS `qp_prod_list_comment_img`;
CREATE TABLE `qp_prod_list_comment_img` (
  `list_comment_img_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '评价图片表',
  `list_comment_id` int(10) NOT NULL COMMENT '评价id',
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `list_comment_img_src` varchar(300) NOT NULL COMMENT '图片地址',
  `list_comment_img_sort` tinyint(2) NOT NULL DEFAULT '1' COMMENT '排序',
  `list_comment_img_add_time` int(10) NOT NULL COMMENT '时间',
  PRIMARY KEY (`list_comment_img_id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_prod_list_comment_img
-- ----------------------------
INSERT INTO `qp_prod_list_comment_img` VALUES ('43', '76', '267', 'uploads/productcomment/201812/22cf77981e6fda84abe9084e7843125c.png', '1', '1');
INSERT INTO `qp_prod_list_comment_img` VALUES ('44', '76', '267', 'uploads/productcomment/201812/22cf77981e6fda84abe9084e7843125c.png', '1', '1');
INSERT INTO `qp_prod_list_comment_img` VALUES ('45', '76', '267', 'uploads/productcomment/201812/22cf77981e6fda84abe9084e7843125c.png', '1', '1');
INSERT INTO `qp_prod_list_comment_img` VALUES ('39', '76', '267', 'uploads/productcomment/201812/22cf77981e6fda84abe9084e7843125c.png', '1', '1543983584');
INSERT INTO `qp_prod_list_comment_img` VALUES ('40', '90', '2678', 'uploads/productcomment/201812/eda34c3a46834f2417571782f5125acf.jpg', '1', '1544524444');
INSERT INTO `qp_prod_list_comment_img` VALUES ('41', '137', '2679', 'uploads/productcomment/201812/0b9483c95efd300a7076939eb5a46a6a.jpg', '1', '1544586492');
INSERT INTO `qp_prod_list_comment_img` VALUES ('42', '76', '267', 'uploads/productcomment/201812/22cf77981e6fda84abe9084e7843125c.png', '1', '1');

-- ----------------------------
-- Table structure for `qp_prod_list_copy`
-- ----------------------------
DROP TABLE IF EXISTS `qp_prod_list_copy`;
CREATE TABLE `qp_prod_list_copy` (
  `list_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `product_id` int(10) DEFAULT '0' COMMENT '产品ID',
  `order_number` char(30) NOT NULL COMMENT '订单号',
  `transaction_id` char(28) DEFAULT NULL COMMENT '微信支付凭证',
  `pay_money` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `prepay_id` text,
  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否支付（1、未支付；2、已支付（未评价）；3、已评价）',
  `pay_requset_info` text COMMENT '拉起支付的信息',
  `list_type` tinyint(1) DEFAULT NULL COMMENT '订单类型（1、竞拍订单；2、一口价订单）',
  `list_add_time` int(10) NOT NULL COMMENT '订单生成时间',
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=332 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_prod_list_copy
-- ----------------------------
INSERT INTO `qp_prod_list_copy` VALUES ('309', '2678', '100', '2018121015444347292678', '4200000230201812101617258604', '0.01', 'wx10173849539273e11ce2c29f0608977623', '2', null, null, '1544434729');
INSERT INTO `qp_prod_list_copy` VALUES ('310', '267', '101', '201812101544434806267', '4200000235201812108058146304', '0.01', 'wx10174006857859f64bc6c1282965946784', '3', null, null, '1544434806');
INSERT INTO `qp_prod_list_copy` VALUES ('311', '257', '101', '201812101544434866257', null, '0.01', 'wx101741068467066fe0c1193f2938339921', '1', null, null, '1544434866');
INSERT INTO `qp_prod_list_copy` VALUES ('312', '257', '101', '201812101544434894257', '4200000217201812106742883998', '0.01', 'wx101741345226014633735c011248376258', '2', null, null, '1544434894');
INSERT INTO `qp_prod_list_copy` VALUES ('313', '2678', '107', '2018121015444528412678', null, '0.01', 'wx10224042083915eb220e6a542863586657', '1', null, null, '1544452841');
INSERT INTO `qp_prod_list_copy` VALUES ('314', '2678', '107', '2018121015444528622678', null, '0.01', 'wx102241031061235eaea8fde42339253629', '1', null, null, '1544452862');
INSERT INTO `qp_prod_list_copy` VALUES ('315', '2678', '107', '2018121015444528842678', '4200000221201812106434217152', '0.01', 'wx10224125140130d1b32eff001729902166', '2', null, null, '1544452884');
INSERT INTO `qp_prod_list_copy` VALUES ('316', '2678', '101', '2018121115444984412678', null, '0.01', 'wx111120421352498e81f230843439059123', '1', null, null, '1544498441');
INSERT INTO `qp_prod_list_copy` VALUES ('317', '2678', '101', '2018121115444984552678', '4200000234201812112840750237', '0.01', 'wx11112055581076bcb0f38df34091946568', '2', null, null, '1544498455');
INSERT INTO `qp_prod_list_copy` VALUES ('318', '267', null, '201812111544522625267', null, '19.89', 'wx11180345602438852e8dc4550551564629', '1', null, null, '1544522625');
INSERT INTO `qp_prod_list_copy` VALUES ('319', '2678', null, '2018121115445248462678', null, '0.02', 'wx11184046323852a1115740fd3317064521', '1', null, null, '1544524846');
INSERT INTO `qp_prod_list_copy` VALUES ('320', '267', null, '201812111544525581267', null, '0.02', 'wx111853014037992bd9218c973424034115', '1', null, null, '1544525581');
INSERT INTO `qp_prod_list_copy` VALUES ('321', '267', null, '201812111544526497267', null, '0.02', 'wx11190817518243cfc65464361839582164', '1', null, null, '1544526497');
INSERT INTO `qp_prod_list_copy` VALUES ('322', '267', null, '201812111544526517267', null, '0.02', 'wx1119083812182234d4125ea52955026089', '1', null, null, '1544526517');
INSERT INTO `qp_prod_list_copy` VALUES ('323', '267', null, '201812111544526522267', null, '0.02', 'wx111908430973785913aabadc2028942490', '1', null, null, '1544526522');
INSERT INTO `qp_prod_list_copy` VALUES ('324', '2679', '104', '2018121215445862402679', null, '99.00', 'wx121144009325167446cf156f1862144082', '1', null, null, '1544586240');
INSERT INTO `qp_prod_list_copy` VALUES ('325', '2679', '106', '2018121215445862562679', null, '99.00', 'wx12114417029127085e1d7ee01789673992', '1', null, null, '1544586256');
INSERT INTO `qp_prod_list_copy` VALUES ('326', '2679', '104', '2018121215445862852679', null, '99.00', 'wx12114445269911736c8620494281375917', '1', null, null, '1544586285');
INSERT INTO `qp_prod_list_copy` VALUES ('327', '2679', '104', '2018121215445863012679', null, '99.00', 'wx121145018524430f171b48122602406952', '1', null, null, '1544586301');
INSERT INTO `qp_prod_list_copy` VALUES ('328', '2679', '100', '2018121215445863212679', '4200000236201812126196783816', '0.01', 'wx1211452189875811b8d917e73629580480', '3', null, null, '1544586321');
INSERT INTO `qp_prod_list_copy` VALUES ('329', '2721', '116', '', null, '127.00', null, '1', null, null, '0');
INSERT INTO `qp_prod_list_copy` VALUES ('330', '2721', '116', '', null, '127.00', null, '1', null, null, '1545806039');
INSERT INTO `qp_prod_list_copy` VALUES ('331', '2721', '116', '', null, '127.00', null, '1', null, null, '1545806121');

-- ----------------------------
-- Table structure for `qp_setting`
-- ----------------------------
DROP TABLE IF EXISTS `qp_setting`;
CREATE TABLE `qp_setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '数据设置表',
  `default_lines` decimal(10,2) NOT NULL DEFAULT '1000.00' COMMENT '用户注册获得的竞拍额度',
  `lines_default_proportion` int(10) NOT NULL DEFAULT '1000' COMMENT '竞拍额度充值比例；1元=?额度',
  `lines_bad_proportion` int(10) NOT NULL DEFAULT '50' COMMENT '违规之后的竞拍额度充值比例',
  `server_rate` int(3) NOT NULL DEFAULT '11' COMMENT '服务费率%',
  `postage_proportion` decimal(10,2) NOT NULL DEFAULT '1.00' COMMENT '积分抵邮费；1元=x积分',
  `save_day` int(10) NOT NULL DEFAULT '60' COMMENT '竞品暂存天数',
  `valid_day` int(10) NOT NULL DEFAULT '3' COMMENT '订单支付有效天数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_setting
-- ----------------------------
INSERT INTO `qp_setting` VALUES ('1', '1000.00', '1000', '50', '11', '1.00', '60', '3');

-- ----------------------------
-- Table structure for `qp_state`
-- ----------------------------
DROP TABLE IF EXISTS `qp_state`;
CREATE TABLE `qp_state` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` char(255) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_state
-- ----------------------------
INSERT INTO `qp_state` VALUES ('1', '会员权益说明', '<p><br></p><p>1、VIP级别将根据不同权益，对应相应课程的权利，等级越高，享受的课程就越多；</p><p>2、VIP级别推荐相应课程，所获取赏金的比例不同，等级越高，赏金就越高；&nbsp;</p><p><br></p><p>本解释权归平台所有</p><p><br></p>');
INSERT INTO `qp_state` VALUES ('2', '分销细则', '<p>陈海东大课堂推广规则：</p><p>1、登录即成为本课堂会员，可以推广中心查看自己的二维码；</p><p>2、登录状态，任意页面的分享等同于二维码效果；新用户登录即视为推荐；</p><p>3、新用户产生课程消费后，陈海东大课堂奖由陈海东老师发一笔红包赏金给予推荐者；</p><p>4、红包赏金大小取决于您的当前VIP等级；</p><p><br></p>');

-- ----------------------------
-- Table structure for `qp_user`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user`;
CREATE TABLE `qp_user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户表',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `user_sex` tinyint(1) DEFAULT '0' COMMENT '会员性别 0女 1男',
  `openid` char(50) NOT NULL,
  `face` varchar(300) DEFAULT NULL COMMENT '头像',
  `user_mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `grand_total` decimal(10,2) DEFAULT NULL COMMENT '累计订单消费',
  `user_level` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、正常用户；2、违规用户',
  `user_lines` decimal(10,2) NOT NULL COMMENT '用户可用竞拍额度（元）',
  `user_is_lock` tinyint(1) DEFAULT '1',
  `user_add_time` int(10) DEFAULT NULL COMMENT '用户注册时间',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2826 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user
-- ----------------------------
INSERT INTO `qp_user` VALUES ('2721', 'Y_Lin', '1', 'opUgV0RfEy_keN4JFrJGunIjAZdY', 'https://wx.qlogo.cn/mmopen/vi_32/AibaQn2JppZY9Ac9sYpVKnhOnZNgwuONWDh3uX49ECickfwdicHx3Gwh7YJN34ibYmSbeCAcHopgDkA9jCWO7FrOFg/132', null, '139.00', '2', '1023.00', '1', '1546934458');

-- ----------------------------
-- Table structure for `qp_user_address`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_address`;
CREATE TABLE `qp_user_address` (
  `address_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '地址编号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `address_name` char(20) DEFAULT NULL,
  `address_phone` char(20) DEFAULT NULL,
  `sheng` char(20) DEFAULT NULL COMMENT '地址省',
  `shi` char(20) DEFAULT NULL COMMENT '地址市',
  `qu` char(20) DEFAULT NULL COMMENT '地址区',
  `more_addr` text COMMENT '区级下详细地址',
  `address_default` tinyint(1) DEFAULT NULL,
  `address_add_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_address
-- ----------------------------
INSERT INTO `qp_user_address` VALUES ('37', '2721', '张三', '15163444790', '广东省', '广州市', '海珠区', '新港中路397号', '1', '1545207412');
INSERT INTO `qp_user_address` VALUES ('38', '2721', '池艺林', '17600604219', '北京市', '北京市', '朝阳区', '123', '2', '1545272088');

-- ----------------------------
-- Table structure for `qp_user_bill`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_bill`;
CREATE TABLE `qp_user_bill` (
  `bill_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '资金流水表',
  `user_id` int(10) NOT NULL,
  `product_id` int(10) DEFAULT NULL COMMENT '产品ID',
  `taoc_id` int(10) DEFAULT NULL COMMENT '套餐ID',
  `jfproduct_id` int(10) DEFAULT NULL COMMENT '积分产品ID',
  `baokao_id` int(10) DEFAULT NULL COMMENT '报考ID',
  `deposit_id` int(10) DEFAULT NULL COMMENT '提现ID',
  `bill_type` tinyint(1) NOT NULL COMMENT '1、余额收益；2、积分收益 ；3、余额消费；4、积分消费',
  `bill_money` decimal(10,2) NOT NULL,
  `bill_add_time` int(10) NOT NULL,
  PRIMARY KEY (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_bill
-- ----------------------------
INSERT INTO `qp_user_bill` VALUES ('1', '267', '104', '10', null, null, null, '3', '10.00', '1');
INSERT INTO `qp_user_bill` VALUES ('2', '267', null, '10', null, null, null, '3', '100.00', '2');
INSERT INTO `qp_user_bill` VALUES ('3', '267', null, null, '1', null, null, '4', '3000.00', '3');
INSERT INTO `qp_user_bill` VALUES ('4', '267', null, null, null, '13', null, '3', '0.01', '1542695565');
INSERT INTO `qp_user_bill` VALUES ('5', '267', null, null, null, '13', null, '3', '0.01', '1542695624');
INSERT INTO `qp_user_bill` VALUES ('6', '267', '99', null, null, null, null, '3', '0.01', '1542695814');
INSERT INTO `qp_user_bill` VALUES ('7', '267', null, null, '1', null, null, '4', '1000.00', '1542696224');
INSERT INTO `qp_user_bill` VALUES ('8', '267', null, null, null, null, '9', '3', '1.00', '1542696432');
INSERT INTO `qp_user_bill` VALUES ('9', '267', null, null, null, null, '10', '3', '1.00', '1542707540');
INSERT INTO `qp_user_bill` VALUES ('10', '267', null, null, null, null, '11', '3', '1.00', '1542707558');
INSERT INTO `qp_user_bill` VALUES ('11', '267', null, null, null, null, '12', '3', '1.00', '1542707680');
INSERT INTO `qp_user_bill` VALUES ('12', '257', '101', null, null, null, null, '3', '0.01', '1542707996');
INSERT INTO `qp_user_bill` VALUES ('13', '259', '101', null, null, null, null, '3', '0.01', '1542709402');
INSERT INTO `qp_user_bill` VALUES ('14', '259', '100', null, null, null, null, '3', '0.01', '1542709434');
INSERT INTO `qp_user_bill` VALUES ('15', '267', null, null, null, null, '13', '3', '1.00', '1542709494');
INSERT INTO `qp_user_bill` VALUES ('16', '267', null, null, null, null, '14', '3', '1.00', '1542709527');
INSERT INTO `qp_user_bill` VALUES ('17', '267', null, null, null, null, '15', '3', '1.00', '1542709651');
INSERT INTO `qp_user_bill` VALUES ('18', '267', null, null, '1', null, null, '4', '1000.00', '1542713222');
INSERT INTO `qp_user_bill` VALUES ('19', '267', null, null, '1', null, null, '4', '1000.00', '1542713241');
INSERT INTO `qp_user_bill` VALUES ('20', '267', null, null, '1', null, null, '4', '1000.00', '1542768991');
INSERT INTO `qp_user_bill` VALUES ('21', '267', null, null, null, null, '16', '3', '1.00', '1542770013');
INSERT INTO `qp_user_bill` VALUES ('22', '267', '101', null, null, null, null, '3', '0.01', '1542778230');
INSERT INTO `qp_user_bill` VALUES ('23', '267', '101', null, null, null, null, '3', '0.01', '1542778455');
INSERT INTO `qp_user_bill` VALUES ('24', '267', '101', null, null, null, null, '3', '0.01', '1542780659');
INSERT INTO `qp_user_bill` VALUES ('25', '259', '101', null, null, null, null, '3', '0.01', '1542783031');
INSERT INTO `qp_user_bill` VALUES ('26', '267', '101', null, null, null, null, '3', '0.01', '1542784785');
INSERT INTO `qp_user_bill` VALUES ('27', '267', '101', null, null, null, null, '3', '0.01', '1542785232');
INSERT INTO `qp_user_bill` VALUES ('28', '267', '101', null, null, null, null, '3', '0.01', '1542785299');
INSERT INTO `qp_user_bill` VALUES ('29', '267', null, null, null, '13', null, '3', '0.01', '1542786518');
INSERT INTO `qp_user_bill` VALUES ('30', '267', null, null, null, '23', null, '3', '0.01', '1542869036');
INSERT INTO `qp_user_bill` VALUES ('31', '267', null, null, null, null, '17', '3', '1.00', '1542870227');
INSERT INTO `qp_user_bill` VALUES ('32', '267', null, null, null, null, '18', '3', '1.00', '1542870228');
INSERT INTO `qp_user_bill` VALUES ('33', '267', null, null, null, '23', null, '3', '0.01', '1542870647');
INSERT INTO `qp_user_bill` VALUES ('34', '259', '100', null, null, null, null, '3', '0.01', '1542873649');
INSERT INTO `qp_user_bill` VALUES ('35', '267', null, null, '1', null, null, '4', '1000.00', '1542880438');
INSERT INTO `qp_user_bill` VALUES ('36', '267', null, null, '1', null, null, '4', '1000.00', '1542880529');
INSERT INTO `qp_user_bill` VALUES ('37', '267', null, null, null, null, '20', '3', '0.01', '1544172024');
INSERT INTO `qp_user_bill` VALUES ('38', '267', null, null, null, null, null, '2', '0.15', '1544411729');
INSERT INTO `qp_user_bill` VALUES ('39', '267', null, null, null, null, null, '2', '0.15', '1544413011');
INSERT INTO `qp_user_bill` VALUES ('40', '267', null, null, null, null, null, '2', '0.15', '1544413018');
INSERT INTO `qp_user_bill` VALUES ('41', '267', null, null, null, null, '21', '3', '0.20', '1544515006');
INSERT INTO `qp_user_bill` VALUES ('42', '267', null, null, null, null, null, '2', '0.25', '1544517116');
INSERT INTO `qp_user_bill` VALUES ('43', '267', null, null, null, null, null, '2', '150.00', '1544517121');
INSERT INTO `qp_user_bill` VALUES ('44', '267', null, null, null, null, null, '1', '0.00', '1544517530');
INSERT INTO `qp_user_bill` VALUES ('45', '267', null, null, null, null, null, '1', '0.00', '1544517557');
INSERT INTO `qp_user_bill` VALUES ('46', '267', null, null, null, null, null, '2', '0.25', '1544517560');
INSERT INTO `qp_user_bill` VALUES ('47', '267', null, null, null, null, null, '2', '0.25', '1544517565');
INSERT INTO `qp_user_bill` VALUES ('48', '267', null, null, null, null, null, '1', '0.00', '1544517572');
INSERT INTO `qp_user_bill` VALUES ('49', '267', null, null, null, null, null, '1', '0.00', '1544517572');
INSERT INTO `qp_user_bill` VALUES ('50', '267', null, null, null, null, null, '1', '0.00', '1544517572');
INSERT INTO `qp_user_bill` VALUES ('51', '267', null, null, null, null, null, '1', '0.00', '1544517572');
INSERT INTO `qp_user_bill` VALUES ('52', '267', null, null, null, null, null, '1', '1.00', '1544517626');
INSERT INTO `qp_user_bill` VALUES ('53', '267', null, null, null, null, null, '1', '1.00', '1544517626');
INSERT INTO `qp_user_bill` VALUES ('54', '267', null, null, null, null, null, '1', '1.00', '1544517626');
INSERT INTO `qp_user_bill` VALUES ('55', '267', null, null, null, null, null, '1', '1.00', '1544517627');
INSERT INTO `qp_user_bill` VALUES ('56', '267', null, null, null, null, null, '1', '1.00', '1544517627');
INSERT INTO `qp_user_bill` VALUES ('57', '267', null, null, null, null, null, '1', '1.00', '1544517627');
INSERT INTO `qp_user_bill` VALUES ('58', '267', null, null, null, null, null, '1', '1.00', '1544517752');
INSERT INTO `qp_user_bill` VALUES ('59', '2678', null, null, '1', null, null, '4', '1.00', '1544584178');
INSERT INTO `qp_user_bill` VALUES ('60', '2678', null, null, '1', null, null, '4', '1.00', '1544584188');
INSERT INTO `qp_user_bill` VALUES ('61', '2678', null, null, '1', null, null, '4', '1.00', '1544584202');
INSERT INTO `qp_user_bill` VALUES ('62', '2678', null, null, '1', null, null, '4', '1.00', '1544584205');
INSERT INTO `qp_user_bill` VALUES ('63', '267', null, null, '1', null, null, '4', '1.00', '1544584422');
INSERT INTO `qp_user_bill` VALUES ('64', '267', null, null, '1', null, null, '4', '1.00', '1544584425');
INSERT INTO `qp_user_bill` VALUES ('65', '267', null, null, '1', null, null, '4', '1.00', '1544584489');
INSERT INTO `qp_user_bill` VALUES ('66', '267', null, null, '1', null, null, '4', '1.00', '1544584491');
INSERT INTO `qp_user_bill` VALUES ('67', '267', null, null, '1', null, null, '4', '1.00', '1544584494');
INSERT INTO `qp_user_bill` VALUES ('68', '267', null, null, '1', null, null, '4', '1.00', '1544584520');
INSERT INTO `qp_user_bill` VALUES ('69', '267', null, null, '1', null, null, '4', '1.00', '1544584520');
INSERT INTO `qp_user_bill` VALUES ('70', '267', null, null, '1', null, null, '4', '1.00', '1544584521');
INSERT INTO `qp_user_bill` VALUES ('71', '267', null, null, '1', null, null, '4', '1.00', '1544584521');
INSERT INTO `qp_user_bill` VALUES ('72', '267', null, null, '1', null, null, '4', '1.00', '1544584521');
INSERT INTO `qp_user_bill` VALUES ('73', '267', null, null, '1', null, null, '4', '1.00', '1544584521');
INSERT INTO `qp_user_bill` VALUES ('74', '267', null, null, '1', null, null, '4', '1.00', '1544584521');
INSERT INTO `qp_user_bill` VALUES ('75', '267', null, null, '1', null, null, '4', '1.00', '1544584521');
INSERT INTO `qp_user_bill` VALUES ('76', '267', null, null, '1', null, null, '4', '1.00', '1544584521');
INSERT INTO `qp_user_bill` VALUES ('77', '267', null, null, '1', null, null, '4', '1.00', '1544584522');
INSERT INTO `qp_user_bill` VALUES ('78', '267', null, null, '1', null, null, '4', '1.00', '1544584522');
INSERT INTO `qp_user_bill` VALUES ('79', '267', null, null, '1', null, null, '4', '1.00', '1544584522');
INSERT INTO `qp_user_bill` VALUES ('80', '267', null, null, '1', null, null, '4', '1.00', '1544584522');
INSERT INTO `qp_user_bill` VALUES ('81', '267', null, null, '1', null, null, '4', '1.00', '1544584522');
INSERT INTO `qp_user_bill` VALUES ('82', '267', null, null, '1', null, null, '4', '1.00', '1544584522');
INSERT INTO `qp_user_bill` VALUES ('83', '267', null, null, '1', null, null, '4', '1.00', '1544584523');
INSERT INTO `qp_user_bill` VALUES ('84', '267', null, null, '1', null, null, '4', '1.00', '1544584523');
INSERT INTO `qp_user_bill` VALUES ('85', '267', null, null, '1', null, null, '4', '1.00', '1544584523');
INSERT INTO `qp_user_bill` VALUES ('86', '267', null, null, '1', null, null, '4', '1.00', '1544584523');
INSERT INTO `qp_user_bill` VALUES ('87', '267', null, null, '1', null, null, '4', '1.00', '1544584523');
INSERT INTO `qp_user_bill` VALUES ('88', '267', null, null, '1', null, null, '4', '1.00', '1544584523');
INSERT INTO `qp_user_bill` VALUES ('89', '267', null, null, '1', null, null, '4', '1.00', '1544584523');
INSERT INTO `qp_user_bill` VALUES ('90', '267', null, null, '1', null, null, '4', '1.00', '1544584524');
INSERT INTO `qp_user_bill` VALUES ('91', '267', null, null, '1', null, null, '4', '1.00', '1544584524');
INSERT INTO `qp_user_bill` VALUES ('92', '267', null, null, '1', null, null, '4', '1.00', '1544584524');
INSERT INTO `qp_user_bill` VALUES ('93', '267', null, null, '1', null, null, '4', '1.00', '1544584524');
INSERT INTO `qp_user_bill` VALUES ('94', '267', null, null, '1', null, null, '4', '1.00', '1544584524');
INSERT INTO `qp_user_bill` VALUES ('95', '267', null, null, '1', null, null, '4', '1.00', '1544584584');
INSERT INTO `qp_user_bill` VALUES ('96', '267', null, null, '1', null, null, '4', '1.00', '1544584944');
INSERT INTO `qp_user_bill` VALUES ('97', '267', null, null, '1', null, null, '4', '1.00', '1544585165');
INSERT INTO `qp_user_bill` VALUES ('98', '267', null, null, '1', null, null, '4', '1.00', '1544585183');
INSERT INTO `qp_user_bill` VALUES ('99', '267', null, null, '1', null, null, '4', '1.00', '1544585210');
INSERT INTO `qp_user_bill` VALUES ('100', '267', null, null, '1', null, null, '4', '1.00', '1544585229');
INSERT INTO `qp_user_bill` VALUES ('101', '267', null, null, '1', null, null, '4', '1.00', '1544585368');
INSERT INTO `qp_user_bill` VALUES ('102', '267', null, null, '1', null, null, '4', '1.00', '1544585386');
INSERT INTO `qp_user_bill` VALUES ('103', '267', null, null, '1', null, null, '4', '1.00', '1544585480');
INSERT INTO `qp_user_bill` VALUES ('104', '267', null, null, '1', null, null, '4', '1.00', '1544585487');
INSERT INTO `qp_user_bill` VALUES ('105', '267', null, null, '1', null, null, '4', '1.00', '1544585490');
INSERT INTO `qp_user_bill` VALUES ('106', '267', null, null, '1', null, null, '4', '1.00', '1544585498');
INSERT INTO `qp_user_bill` VALUES ('107', '267', null, null, '1', null, null, '4', '1.00', '1544585516');
INSERT INTO `qp_user_bill` VALUES ('108', '267', null, null, '1', null, null, '4', '1.00', '1544585564');
INSERT INTO `qp_user_bill` VALUES ('109', '267', null, null, '1', null, null, '4', '1.00', '1544585568');
INSERT INTO `qp_user_bill` VALUES ('110', '267', null, null, '1', null, null, '4', '1.00', '1544585600');
INSERT INTO `qp_user_bill` VALUES ('111', '267', null, null, '1', null, null, '4', '1.00', '1544585602');
INSERT INTO `qp_user_bill` VALUES ('112', '267', null, null, '1', null, null, '4', '1.00', '1544585604');
INSERT INTO `qp_user_bill` VALUES ('113', '2678', null, null, '4', null, null, '4', '2000.00', '1544585839');
INSERT INTO `qp_user_bill` VALUES ('114', '2678', null, null, '4', null, null, '4', '2000.00', '1544585844');
INSERT INTO `qp_user_bill` VALUES ('115', '267', null, null, '7', null, null, '4', '1.00', '1544586826');
INSERT INTO `qp_user_bill` VALUES ('116', '2678', null, null, null, null, null, '2', '0.40', '1544586827');
INSERT INTO `qp_user_bill` VALUES ('117', '267', null, null, '7', null, null, '4', '1.00', '1544588082');

-- ----------------------------
-- Table structure for `qp_user_collection`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_collection`;
CREATE TABLE `qp_user_collection` (
  `collection_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏id',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `collection_time` int(11) NOT NULL COMMENT '收藏时间',
  PRIMARY KEY (`collection_id`)
) ENGINE=MyISAM AUTO_INCREMENT=399 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_collection
-- ----------------------------
INSERT INTO `qp_user_collection` VALUES ('397', '127', '2721', '1547610252');
INSERT INTO `qp_user_collection` VALUES ('396', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('390', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('389', '130', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('388', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('387', '130', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('386', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('385', '130', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('384', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('383', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('380', '130', '2721', '1546073777');
INSERT INTO `qp_user_collection` VALUES ('381', '129', '2721', '1546073849');
INSERT INTO `qp_user_collection` VALUES ('395', '130', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('394', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('393', '130', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('392', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('391', '130', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('382', '129', '2721', '0');
INSERT INTO `qp_user_collection` VALUES ('398', '128', '2721', '1547798456');

-- ----------------------------
-- Table structure for `qp_user_deposit`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_deposit`;
CREATE TABLE `qp_user_deposit` (
  `deposit_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `deposit_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：审核中、2：已提现、3：已驳回',
  `deposit_add_time` int(10) NOT NULL,
  PRIMARY KEY (`deposit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_deposit
-- ----------------------------
INSERT INTO `qp_user_deposit` VALUES ('21', '267', '0.20', '3', '1544515006');

-- ----------------------------
-- Table structure for `qp_user_get_prod`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_get_prod`;
CREATE TABLE `qp_user_get_prod` (
  `get_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户得标表',
  `user_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `result_money` decimal(10,2) NOT NULL COMMENT '成交价格（不含服务费）',
  `server_money` decimal(10,2) DEFAULT NULL COMMENT '服务费',
  `total_price` decimal(10,2) NOT NULL COMMENT '应付总价（不含邮费）',
  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否支付1、未支付；2、已经支付；3、超时未支付',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`get_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_get_prod
-- ----------------------------
INSERT INTO `qp_user_get_prod` VALUES ('6', '2721', '127', '3.00', '0.33', '3.33', '3', '1546584061');
INSERT INTO `qp_user_get_prod` VALUES ('7', '2721', '130', '4.00', '0.44', '4.44', '3', '1546584061');
INSERT INTO `qp_user_get_prod` VALUES ('8', '2721', '128', '57.00', '6.27', '63.27', '1', '1547877136');
INSERT INTO `qp_user_get_prod` VALUES ('9', '2721', '128', '57.00', '6.27', '63.27', '1', '1547877184');
INSERT INTO `qp_user_get_prod` VALUES ('10', '2721', '128', '57.00', '6.27', '63.27', '1', '1547877196');
INSERT INTO `qp_user_get_prod` VALUES ('11', '2721', '128', '57.00', '6.27', '63.27', '1', '1547877271');
INSERT INTO `qp_user_get_prod` VALUES ('12', '2721', '128', '57.00', '6.27', '63.27', '1', '1547877291');
INSERT INTO `qp_user_get_prod` VALUES ('13', '2721', '128', '57.00', '6.27', '63.27', '1', '1547877975');
INSERT INTO `qp_user_get_prod` VALUES ('14', '2721', '128', '57.00', '6.27', '63.27', '1', '1547878031');
INSERT INTO `qp_user_get_prod` VALUES ('15', '2721', '128', '57.00', '6.27', '63.27', '1', '1547878208');
INSERT INTO `qp_user_get_prod` VALUES ('16', '2721', '128', '57.00', '6.27', '63.27', '1', '1547878303');
INSERT INTO `qp_user_get_prod` VALUES ('17', '2721', '128', '57.00', '6.27', '63.27', '1', '1547878344');
INSERT INTO `qp_user_get_prod` VALUES ('18', '2721', '128', '57.00', '6.27', '63.27', '1', '1547878380');
INSERT INTO `qp_user_get_prod` VALUES ('19', '2721', '128', '57.00', '6.27', '63.27', '1', '1547878403');
INSERT INTO `qp_user_get_prod` VALUES ('20', '2721', '128', '57.00', '6.27', '63.27', '1', '1547878740');
INSERT INTO `qp_user_get_prod` VALUES ('21', '2721', '128', '57.00', '6.27', '63.27', '1', '1547882822');
INSERT INTO `qp_user_get_prod` VALUES ('22', '2721', '128', '57.00', '6.27', '63.27', '1', '1547883271');
INSERT INTO `qp_user_get_prod` VALUES ('23', '2721', '128', '57.00', '6.27', '63.27', '1', '1547883310');

-- ----------------------------
-- Table structure for `qp_user_idea`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_idea`;
CREATE TABLE `qp_user_idea` (
  `idea_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户意见反馈表',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `idea_content` varchar(500) NOT NULL COMMENT '用户反馈详情',
  `idea_add_time` int(10) NOT NULL COMMENT '反馈发布时间',
  PRIMARY KEY (`idea_id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_idea
-- ----------------------------

-- ----------------------------
-- Table structure for `qp_user_lines_record`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_lines_record`;
CREATE TABLE `qp_user_lines_record` (
  `lines_record_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `offer_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1：充值；2：消费；3：竞拍结束退会',
  `money` decimal(10,2) NOT NULL,
  `record_add_time` int(10) NOT NULL,
  PRIMARY KEY (`lines_record_id`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_lines_record
-- ----------------------------
INSERT INTO `qp_user_lines_record` VALUES ('1', '1', '0', '0', '2', '0.00', '0');
INSERT INTO `qp_user_lines_record` VALUES ('2', '2721', '35', '128', '2', '7.00', '1547864900');
INSERT INTO `qp_user_lines_record` VALUES ('3', '2721', '36', '128', '2', '-8.00', '1547864943');
INSERT INTO `qp_user_lines_record` VALUES ('4', '2721', '37', '128', '2', '-9.00', '1547865053');
INSERT INTO `qp_user_lines_record` VALUES ('5', '2721', '38', '128', '2', '-11.00', '1547865387');
INSERT INTO `qp_user_lines_record` VALUES ('6', '2721', '39', '128', '2', '-11.00', '1547865387');
INSERT INTO `qp_user_lines_record` VALUES ('7', '2721', '40', '128', '2', '-25.00', '1547865480');
INSERT INTO `qp_user_lines_record` VALUES ('8', '2721', '41', '128', '2', '-30.00', '1547865480');
INSERT INTO `qp_user_lines_record` VALUES ('9', '2721', '42', '128', '2', '-40.00', '1547865578');
INSERT INTO `qp_user_lines_record` VALUES ('10', '2721', '43', '128', '2', '-45.00', '1547865578');
INSERT INTO `qp_user_lines_record` VALUES ('11', '2721', '44', '128', '2', '-50.00', '1547865656');
INSERT INTO `qp_user_lines_record` VALUES ('12', '2721', '45', '128', '2', '-51.00', '1547865677');
INSERT INTO `qp_user_lines_record` VALUES ('13', '2721', '46', '128', '2', '-54.00', '1547865785');
INSERT INTO `qp_user_lines_record` VALUES ('14', '2721', '47', '128', '2', '-57.00', '1547865820');
INSERT INTO `qp_user_lines_record` VALUES ('15', '2721', '46', '0', '3', '54.00', '1547878303');
INSERT INTO `qp_user_lines_record` VALUES ('52', '2721', '35', '0', '3', '7.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('53', '2721', '36', '0', '3', '8.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('54', '2721', '37', '0', '3', '9.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('55', '2721', '38', '0', '3', '11.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('56', '2721', '39', '0', '3', '11.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('57', '2721', '40', '0', '3', '25.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('58', '2721', '41', '0', '3', '30.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('59', '2721', '42', '0', '3', '40.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('60', '2721', '43', '0', '3', '45.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('61', '2721', '44', '0', '3', '50.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('62', '2721', '45', '0', '3', '51.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('63', '2721', '46', '0', '3', '54.00', '1547878740');
INSERT INTO `qp_user_lines_record` VALUES ('64', '2721', '35', '0', '3', '7.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('65', '2721', '36', '0', '3', '8.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('66', '2721', '37', '0', '3', '9.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('67', '2721', '38', '0', '3', '11.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('68', '2721', '39', '0', '3', '11.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('69', '2721', '40', '0', '3', '25.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('70', '2721', '41', '0', '3', '30.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('71', '2721', '42', '0', '3', '40.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('72', '2721', '43', '0', '3', '45.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('73', '2721', '44', '0', '3', '50.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('74', '2721', '45', '0', '3', '51.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('75', '2721', '46', '0', '3', '54.00', '1547882822');
INSERT INTO `qp_user_lines_record` VALUES ('76', '2721', '35', '0', '3', '7.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('77', '2721', '36', '0', '3', '8.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('78', '2721', '37', '0', '3', '9.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('79', '2721', '38', '0', '3', '11.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('80', '2721', '39', '0', '3', '11.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('81', '2721', '40', '0', '3', '25.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('82', '2721', '41', '0', '3', '30.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('83', '2721', '42', '0', '3', '40.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('84', '2721', '43', '0', '3', '45.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('85', '2721', '44', '0', '3', '50.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('86', '2721', '45', '0', '3', '51.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('87', '2721', '46', '0', '3', '54.00', '1547883271');
INSERT INTO `qp_user_lines_record` VALUES ('88', '2721', '35', '0', '3', '7.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('89', '2721', '36', '0', '3', '8.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('91', '2721', '38', '0', '3', '11.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('92', '2721', '39', '0', '3', '11.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('93', '2721', '40', '0', '3', '25.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('94', '2721', '41', '0', '3', '30.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('95', '2721', '42', '0', '3', '40.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('96', '2721', '43', '0', '3', '45.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('97', '2721', '44', '0', '3', '50.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('98', '2721', '45', '0', '3', '51.00', '1547883310');
INSERT INTO `qp_user_lines_record` VALUES ('99', '2721', '46', '0', '3', '54.00', '1547883310');

-- ----------------------------
-- Table structure for `qp_user_message`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_message`;
CREATE TABLE `qp_user_message` (
  `user_message_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户消息表',
  `user_id` int(10) NOT NULL,
  `message_title` char(255) NOT NULL COMMENT '消息标题',
  `message_content` char(255) NOT NULL COMMENT '消息内容',
  `message_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '（消息类型）1：普通消息；2：现金红包；3、积分红包',
  `money` decimal(10,2) DEFAULT NULL,
  `message_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '消息状态 ：1、未读；2、已读',
  `message_add_time` int(10) NOT NULL,
  PRIMARY KEY (`user_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_message
-- ----------------------------
INSERT INTO `qp_user_message` VALUES ('44', '267', '获得一个红包！', '请及时查看！！', '2', '1.00', '2', '1544256322');
INSERT INTO `qp_user_message` VALUES ('45', '267', '获得一个红包！', '请及时查看！！', '3', '0.15', '2', '1544256574');
INSERT INTO `qp_user_message` VALUES ('46', '267', '获得一个红包！', '请及时查看！！', '3', '0.15', '2', '1544408613');
INSERT INTO `qp_user_message` VALUES ('47', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544408823');
INSERT INTO `qp_user_message` VALUES ('48', '257', '获得一个红包！', '请及时查看！！', '3', '0.15', '1', '1544408982');
INSERT INTO `qp_user_message` VALUES ('49', '257', '获得一个红包！', '请及时查看！！', '3', '0.15', '1', '1544409517');
INSERT INTO `qp_user_message` VALUES ('50', '257', '获得一个红包！', '请及时查看！！', '3', '0.15', '1', '1544409666');
INSERT INTO `qp_user_message` VALUES ('51', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544410245');
INSERT INTO `qp_user_message` VALUES ('52', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544410374');
INSERT INTO `qp_user_message` VALUES ('53', '257', '获得一个红包！', '请及时查看！！', '3', '0.15', '1', '1544410439');
INSERT INTO `qp_user_message` VALUES ('54', '257', '获得一个红包！', '请及时查看！！', '3', '0.08', '1', '1544421125');
INSERT INTO `qp_user_message` VALUES ('55', '267', '获得一个红包！', '请及时查看！！', '3', '0.25', '2', '1544421125');
INSERT INTO `qp_user_message` VALUES ('56', '257', '获得一个红包！', '请及时查看！！', '3', '0.08', '1', '1544434627');
INSERT INTO `qp_user_message` VALUES ('57', '267', '获得一个红包！', '请及时查看！！', '2', '0.00', '2', '1544434627');
INSERT INTO `qp_user_message` VALUES ('58', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544434647');
INSERT INTO `qp_user_message` VALUES ('59', '257', '获得一个红包！', '请及时查看！！', '3', '0.08', '1', '1544434689');
INSERT INTO `qp_user_message` VALUES ('60', '267', '获得一个红包！', '请及时查看！！', '3', '0.25', '2', '1544434689');
INSERT INTO `qp_user_message` VALUES ('61', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544434735');
INSERT INTO `qp_user_message` VALUES ('62', '267', '获得一个红包！', '请及时查看！！', '3', '0.25', '2', '1544434735');
INSERT INTO `qp_user_message` VALUES ('63', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544434820');
INSERT INTO `qp_user_message` VALUES ('64', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544452889');
INSERT INTO `qp_user_message` VALUES ('65', '267', '获得一个红包！', '请及时查看！！', '2', '0.00', '2', '1544452889');
INSERT INTO `qp_user_message` VALUES ('66', '257', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544498476');
INSERT INTO `qp_user_message` VALUES ('67', '267', '获得一个红包！', '请及时查看！！', '2', '0.00', '2', '1544498476');
INSERT INTO `qp_user_message` VALUES ('68', '267', '获得一个红包！', '请及时查看！！', '3', '150.00', '2', '1544517088');
INSERT INTO `qp_user_message` VALUES ('69', '267', '获得一个红包！', '请及时查看！！', '2', '0.01', '1', '1544520353');
INSERT INTO `qp_user_message` VALUES ('70', '267', '获得一个红包！', '请及时查看！！', '2', '0.01', '1', '1544521201');
INSERT INTO `qp_user_message` VALUES ('71', '267', '获得一个红包！', '请及时查看！！', '2', '0.00', '1', '1544521439');
INSERT INTO `qp_user_message` VALUES ('72', '267', '获得一个红包！', '请及时查看！！', '2', '0.01', '1', '1544521452');
INSERT INTO `qp_user_message` VALUES ('73', '267', '获得一个红包！', '请及时查看！！', '3', '0.12', '1', '1544586345');
INSERT INTO `qp_user_message` VALUES ('74', '2678', '获得一个红包！', '请及时查看！！', '3', '0.40', '2', '1544586345');

-- ----------------------------
-- Table structure for `qp_user_offer_agent`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_offer_agent`;
CREATE TABLE `qp_user_offer_agent` (
  `offer_agent_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `offer_money` decimal(10,2) NOT NULL,
  `offer_add_time` int(10) NOT NULL,
  PRIMARY KEY (`offer_agent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_offer_agent
-- ----------------------------
INSERT INTO `qp_user_offer_agent` VALUES ('4', '2721', '127', '100.00', '1546503897');
INSERT INTO `qp_user_offer_agent` VALUES ('5', '2721', '128', '20.00', '1547865358');
INSERT INTO `qp_user_offer_agent` VALUES ('6', '2721', '128', '50.00', '1547865474');

-- ----------------------------
-- Table structure for `qp_user_offer_price`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_offer_price`;
CREATE TABLE `qp_user_offer_price` (
  `offer_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户竞拍出价表',
  `user_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `is_agent` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否是代理自动加价（1、普通加价；2、代理自动加价）',
  `offer_money` decimal(10,2) NOT NULL COMMENT '出价金额',
  `offer_add_time` int(10) NOT NULL,
  PRIMARY KEY (`offer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_offer_price
-- ----------------------------
INSERT INTO `qp_user_offer_price` VALUES ('30', '2721', '127', '1', '1.00', '1546503878');
INSERT INTO `qp_user_offer_price` VALUES ('32', '2721', '127', '1', '3.00', '1546504050');
INSERT INTO `qp_user_offer_price` VALUES ('33', '2721', '128', '2', '4.00', '1546504050');
INSERT INTO `qp_user_offer_price` VALUES ('34', '2721', '128', '1', '6.00', '1547798523');
INSERT INTO `qp_user_offer_price` VALUES ('35', '2721', '128', '1', '7.00', '1547864900');
INSERT INTO `qp_user_offer_price` VALUES ('36', '2721', '128', '1', '8.00', '1547864943');
INSERT INTO `qp_user_offer_price` VALUES ('37', '2721', '128', '1', '9.00', '1547865053');
INSERT INTO `qp_user_offer_price` VALUES ('38', '2721', '128', '1', '11.00', '1547865387');
INSERT INTO `qp_user_offer_price` VALUES ('39', '2721', '128', '2', '11.00', '1547865387');
INSERT INTO `qp_user_offer_price` VALUES ('40', '2721', '128', '1', '25.00', '1547865480');
INSERT INTO `qp_user_offer_price` VALUES ('41', '2721', '128', '2', '30.00', '1547865480');
INSERT INTO `qp_user_offer_price` VALUES ('42', '2721', '128', '1', '40.00', '1547865578');
INSERT INTO `qp_user_offer_price` VALUES ('43', '2721', '128', '2', '45.00', '1547865578');
INSERT INTO `qp_user_offer_price` VALUES ('44', '2721', '128', '1', '50.00', '1547865656');
INSERT INTO `qp_user_offer_price` VALUES ('45', '2721', '128', '1', '51.00', '1547865677');
INSERT INTO `qp_user_offer_price` VALUES ('46', '2721', '128', '1', '54.00', '1547865785');
INSERT INTO `qp_user_offer_price` VALUES ('47', '2721', '128', '1', '57.00', '1547865820');

-- ----------------------------
-- Table structure for `qp_user_offer_settime`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_offer_settime`;
CREATE TABLE `qp_user_offer_settime` (
  `time_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '定时出价表',
  `user_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `offer_money` decimal(10,2) NOT NULL,
  `happen_time` int(10) NOT NULL,
  `is_happen` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否已经执行（1、未执行；2、已经执行）',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`time_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_offer_settime
-- ----------------------------

-- ----------------------------
-- Table structure for `qp_user_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_recharge`;
CREATE TABLE `qp_user_recharge` (
  `user_recharge_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '竞拍额度充值记录',
  `order_number` char(20) NOT NULL COMMENT '订单号',
  `transaction_id` char(28) DEFAULT NULL COMMENT '微信支付单号',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否支付(1、未支付；2、已经支付）',
  `lines` decimal(10,2) NOT NULL COMMENT '竞拍额度充值数量',
  `total_price` decimal(10,2) NOT NULL COMMENT '付款金额',
  `pay_time` int(10) NOT NULL,
  `add_time` int(10) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`user_recharge_id`)
) ENGINE=MyISAM AUTO_INCREMENT=152 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_recharge
-- ----------------------------
INSERT INTO `qp_user_recharge` VALUES ('149', '907209432721826', null, '2721', '1', '11000.00', '11.00', '0', '1547190719');
INSERT INTO `qp_user_recharge` VALUES ('150', '911803072721684', null, '2721', '1', '99999999.99', '123123.00', '0', '1547191180');
INSERT INTO `qp_user_recharge` VALUES ('151', '912135092721970', null, '2721', '1', '99999999.99', '121132.00', '0', '1547191213');
