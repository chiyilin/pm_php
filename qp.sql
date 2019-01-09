/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : qp

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-12-26 13:02:48
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
INSERT INTO `qp_admin` VALUES ('36', 'admin', '13210628679', '4297f44b13955235245b2497399d7a93', '1', '1545790623', '127.0.0.1', '1', '1535363738');
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
  `article_title` varchar(100) NOT NULL COMMENT '文章标题',
  `article_details` text NOT NULL COMMENT '文章内容',
  `article_cate` tinyint(1) NOT NULL COMMENT '文章所属类型',
  `article_time` int(10) NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qp_article
-- ----------------------------
INSERT INTO `qp_article` VALUES ('52', 'uploads/articleCover/201811/b462a952f027387bc3512c576f0f1ede.jpg', '中医进家，幸福开花：免费学习取证《高级中医理疗师》11月11日开课', '<p><img src=\"https://class.chdmhz.com/uploads/productImg/201812/573865587542396819b1b64d9a9d6335.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/fa5c35715c75653334678d6debc49757.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/541b808e57f372dce8113eb6ea1613f6.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/ac1f32a363a4932d298889ae0ea67c09.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/fc6532e4cb4ce8718e1ac17a58f0a272.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/71821ff5d00c54645b76c5deab1fd1de.jpg\"><br></p><p><br></p>', '6', '1541408676');
INSERT INTO `qp_article` VALUES ('53', 'uploads/articleCover/201811/02759ccb4aa21be6eb4ffad0b9abe5e6.jpg', '11.162018年名家精华钜礼：《六壬神课金口诀基础实战精华班》11月18日隆重开课', '<p><img src=\"https://class.chdmhz.com/uploads/productImg/201812/573865587542396819b1b64d9a9d6335.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/fa5c35715c75653334678d6debc49757.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/541b808e57f372dce8113eb6ea1613f6.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/ac1f32a363a4932d298889ae0ea67c09.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/fc6532e4cb4ce8718e1ac17a58f0a272.jpg\"><img src=\"https://class.chdmhz.com/uploads/productImg/201812/71821ff5d00c54645b76c5deab1fd1de.jpg\"><br></p><p><br></p>', '5', '1542421689');
INSERT INTO `qp_article` VALUES ('54', 'uploads/articleCover/201812/c5383df0eb81073b123d761d067fc6fb.jpg', '1', '<p>北京医宗金鉴中医技术研究院 院长</p><p>&nbsp;百年信康健康科技（北京）有限公司 董事长</p><p>&nbsp;中国中医科学研究院人体5S健康管理中心首席导师</p><p>全国科技人才培养工程培训中心 主任&nbsp;</p><p>陈海东梅花针人体规律学 研究创始人</p><p>&nbsp;陈海东梅花针爱心大使走进因病致贫家庭活动发起人 1979年生，祖籍安徽六安，自幼学医，少时得家师真传特色中医手法正骨、梅花针、胎息灸、寻经放血术、汤药秘方。从事临床实践20余年，调理康复患者数以千计，具有丰富中医临床辩证调理经验。1999年在中国中医研究院中国传统医学科技推广交流中心高级针灸,推拿调理班学习。 2002年被北京仁德洲中医药科学研究院聘为副院长，主任研究员。2003年在北京成立医学机构【北京世纪杏林脊椎矫正医学研究院】。 2004年在中华人民共和国卫生部职业技能鉴定指导中心，获得高级康复保健师。2005年在青岛成立了个人医学机构【青岛三奇堂人体脊柱平衡研究院】，专门从事颈椎病、腰椎病、胸椎病的调理和研究，硕果累累。&nbsp;&nbsp;<br></p><p><br></p>', '6', '1544493750');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_article_cate
-- ----------------------------
INSERT INTO `qp_article_cate` VALUES ('5', '简介', '1', '1', '1541408022');
INSERT INTO `qp_article_cate` VALUES ('6', '教程', '1', '1', '1541408028');

-- ----------------------------
-- Table structure for `qp_banner`
-- ----------------------------
DROP TABLE IF EXISTS `qp_banner`;
CREATE TABLE `qp_banner` (
  `banner_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Banner表',
  `url` varchar(300) NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、展示；2、隐藏',
  `path_index` int(10) DEFAULT NULL,
  `path` char(100) DEFAULT NULL,
  `ext` char(255) DEFAULT NULL,
  `sort` tinyint(2) NOT NULL DEFAULT '1' COMMENT 'Banner排序（正序排列）',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=MyISAM AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_banner
-- ----------------------------
INSERT INTO `qp_banner` VALUES ('193', 'uploads/banner/201812/a8eca367606644b289f1cfa4f2c4a13f.jpg', '1', null, null, null, '1', '1545122705');
INSERT INTO `qp_banner` VALUES ('192', 'uploads/banner/201812/6889949760eddb69b0074ab56b55a4e2.jpg', '1', null, null, null, '1', '1545122705');

-- ----------------------------
-- Table structure for `qp_category`
-- ----------------------------
DROP TABLE IF EXISTS `qp_category`;
CREATE TABLE `qp_category` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '商品分类表',
  `category_name` varchar(50) NOT NULL,
  `category_sort` int(10) NOT NULL COMMENT '排序（正序）',
  `category_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：正常、2；关闭',
  `category_group_sort` tinyint(1) NOT NULL,
  `category_level` tinyint(1) NOT NULL DEFAULT '1',
  `category_fid` int(10) NOT NULL,
  `category_time` int(10) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_category
-- ----------------------------
INSERT INTO `qp_category` VALUES ('48', '解放区邮票', '0', '1', '1', '3', '45', '1544694531');
INSERT INTO `qp_category` VALUES ('47', '民国邮票', '0', '1', '1', '3', '45', '1544694511');
INSERT INTO `qp_category` VALUES ('46', '清代邮票', '0', '1', '1', '3', '45', '1544694493');
INSERT INTO `qp_category` VALUES ('45', '清民居邮票', '0', '1', '1', '2', '34', '1544694481');
INSERT INTO `qp_category` VALUES ('44', '新中国邮票', '0', '1', '1', '2', '34', '1544694468');
INSERT INTO `qp_category` VALUES ('39', '其他', '0', '1', '6', '1', '0', '1544694257');
INSERT INTO `qp_category` VALUES ('37', '艺术', '2', '1', '4', '1', '0', '1544694247');
INSERT INTO `qp_category` VALUES ('38', '文献', '1', '1', '5', '1', '0', '1544694253');
INSERT INTO `qp_category` VALUES ('36', '书画', '3', '1', '3', '1', '0', '1544694241');
INSERT INTO `qp_category` VALUES ('35', '钱币', '4', '1', '2', '1', '0', '1544694234');
INSERT INTO `qp_category` VALUES ('34', '邮品', '5', '1', '1', '1', '0', '1544694229');
INSERT INTO `qp_category` VALUES ('49', '全集年票', '0', '1', '1', '3', '44', '1544694558');
INSERT INTO `qp_category` VALUES ('50', '小型/全章', '0', '1', '1', '3', '44', '1544694573');
INSERT INTO `qp_category` VALUES ('51', '纪特邮票', '0', '1', '1', '3', '44', '1544694604');
INSERT INTO `qp_category` VALUES ('52', '编年新邮', '0', '1', '1', '3', '44', '1544694623');
INSERT INTO `qp_category` VALUES ('53', '“文”字头邮票', '0', '1', '1', '3', '44', '1544694667');
INSERT INTO `qp_category` VALUES ('54', '普改航欠军', '0', '1', '1', '3', '44', '1544694698');
INSERT INTO `qp_category` VALUES ('55', '编号邮票', '0', '1', '1', '3', '44', '1544694895');
INSERT INTO `qp_category` VALUES ('56', '小本票', '0', '1', '1', '3', '44', '1544694949');
INSERT INTO `qp_category` VALUES ('57', '封片简', '0', '1', '1', '2', '34', '1544694979');
INSERT INTO `qp_category` VALUES ('58', '清代封片简', '0', '1', '1', '3', '57', '1544694998');

-- ----------------------------
-- Table structure for `qp_collection`
-- ----------------------------
DROP TABLE IF EXISTS `qp_collection`;
CREATE TABLE `qp_collection` (
  `collection_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '专场表',
  `collection_name` varchar(50) NOT NULL COMMENT '专场名',
  `collection_cover` varchar(300) NOT NULL COMMENT '专场封面',
  `category_id` int(10) NOT NULL,
  `collection_start_time` int(10) NOT NULL,
  `collection_end_time` int(10) NOT NULL,
  `collection_introduce` text NOT NULL COMMENT '简介',
  `collection_sort` int(10) NOT NULL DEFAULT '0',
  `collection_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、展示；2、不展示',
  `collection_add_time` int(10) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`collection_id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_collection
-- ----------------------------
INSERT INTO `qp_collection` VALUES ('51', '12.150001', 'uploads/collection/201812/6d0707be358578798137e61079d6973e.jpg', '35', '1544803200', '1544889600', '<p>12312<img src=\"http://qp.test/uploads/collectionImg/201812/a678c1302ef282d59b072622a0bab894.jpg\" style=\"max-width: 100%;\"></p><p><br></p>', '0', '1', '1544845025');
INSERT INTO `qp_collection` VALUES ('52', '哈哈哈哈哈', 'uploads/collection/201812/03922f7887f891e5128bc1d246b691be.jpg', '0', '1544544000', '1545062400', '<p><span style=\"font-weight: bold;\">专场啊！</span><br></p><p><br></p>', '0', '1', '1544853329');
INSERT INTO `qp_collection` VALUES ('53', '1.1', 'uploads/collection/201812/f493d52032287a531b14b99b2865e12a.jpg', '0', '1546272000', '1546358400', '<p>213</p><p><br></p>', '0', '1', '1544855379');
INSERT INTO `qp_collection` VALUES ('54', '2.1', 'uploads/collection/201812/58470d8d8301cb38f2f0fe957897fe5a.png', '0', '1548950400', '1550764800', '<p>1</p><p><br></p>', '0', '1', '1544855451');
INSERT INTO `qp_collection` VALUES ('55', '这个结束了', 'uploads/collection/201812/12b319077de054a9208adaa8a349b096.jpg', '0', '1543680000', '1544457600', '<p>结束了这个</p>', '0', '1', '1544861940');
INSERT INTO `qp_collection` VALUES ('56', '12.17', 'uploads/collection/201812/b3e77e4f614aacce66689878d64b1e7c.jpg', '37', '1544976000', '1545235200', '<p>123</p>', '0', '1', '1545025781');

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
INSERT INTO `qp_crontab_setting` VALUES ('1', '2018-12-16 14:00:05', '1', '0', '[\"app\\\\command\\\\Test::firstTest\"]');

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
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_entrust
-- ----------------------------
INSERT INTO `qp_entrust` VALUES ('37', '0', '池艺林', '17600604129', '1', '123', '1545274919');
INSERT INTO `qp_entrust` VALUES ('39', '2721', '12.20', '15163444791', '1', '123546', '1545286291');

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
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

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
  `nav_id` int(10) NOT NULL AUTO_INCREMENT,
  `cover_src` char(255) NOT NULL,
  `nav_title` char(20) NOT NULL,
  `path_index` int(10) DEFAULT NULL,
  `path` char(255) DEFAULT NULL,
  `ext` char(255) DEFAULT NULL,
  `display` tinyint(1) DEFAULT '1',
  `nav_type` tinyint(1) DEFAULT '1',
  `add_time` int(10) NOT NULL,
  `sort` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`nav_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_nav
-- ----------------------------
INSERT INTO `qp_nav` VALUES ('5', 'uploads/nav/201812/ba75f9475afe787ce1a4b6f05bdf29f0.jpg', '新闻公告', '16', '/pages/article/list/list', null, '1', '1', '1543917310', '1');
INSERT INTO `qp_nav` VALUES ('6', 'uploads/nav/201812/fe5aa584fee512c80e9423d7a73bf5bf.jpg', '播放记录', '15', '/pages/mine/history/history', null, '1', '1', '1543917327', '1');
INSERT INTO `qp_nav` VALUES ('7', 'uploads/nav/201812/96098e402e4a4697109511ebaea784a7.jpg', '报名报考', '12', '/pages/mhzindex/examination/examination', 'a:1:{i:0;s:1:\"0\";}', '1', '1', '1543917360', '1');
INSERT INTO `qp_nav` VALUES ('8', 'uploads/nav/201812/efe564f72aaf2b9e9516002b9bc4bd65.jpg', '我的课程', '22', '/pages/mine/MySubject/MySubject', null, '1', '1', '1543917391', '1');
INSERT INTO `qp_nav` VALUES ('11', 'uploads/nav/201812/c1fad8dcb874aa2e95c95c202cb6a9be.jpg', '报名', '12', '/pages/mhzindex/examination/examination', 'a:1:{i:0;s:1:\"0\";}', '1', '2', '1544090353', '1');
INSERT INTO `qp_nav` VALUES ('12', 'uploads/nav/201812/a9989b48e2c1ae3f5fc9ba59616bcd75.jpg', '报考', '12', '/pages/mhzindex/examination/examination', 'a:1:{i:0;s:1:\"1\";}', '1', '2', '1544090371', '1');

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
  `cate_id_first` int(11) DEFAULT NULL COMMENT '课程一级分类',
  `cate_id_second` int(11) DEFAULT NULL COMMENT '产品二级分类',
  `cate_id_third` int(11) DEFAULT NULL,
  `product_face` tinyint(1) NOT NULL,
  `product_zysx` varchar(255) NOT NULL,
  `product_times` decimal(10,2) DEFAULT NULL,
  `product_sort` int(10) NOT NULL DEFAULT '1' COMMENT '产品排序',
  `product_type` tinyint(1) DEFAULT '1' COMMENT '1、竞价；2、一口价',
  `product_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态（1、在售；2、下架）',
  `product_share_index` tinyint(1) DEFAULT '1' COMMENT '1、不推荐；2、推荐',
  `product_start_time` int(10) DEFAULT NULL COMMENT '竞价开始时间',
  `product_end_time` int(10) DEFAULT NULL COMMENT '竞价结束时间',
  `product_time` int(10) NOT NULL COMMENT '产品添加时间',
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_product
-- ----------------------------
INSERT INTO `qp_product` VALUES ('116', '12.17', 'uploads/productCover/201812/b1fab28450fa5c6140c70b49277ecb27.jpg', '暂无', '<p>312</p>', '99.99', '34', '45', null, '1', '注意事项', '20.00', '1', '1', '1', null, '1544976000', '1544976005', '1545034143');
INSERT INTO `qp_product` VALUES ('117', '12.21', 'uploads/productCover/201812/5ecb32539ec7c7b2cfae162c4dfc7e39.jpg', '封面简介', '<p>哈哈哈？<img src=\"http://qp.test/uploads/productImg/201812/ef9e7ed807a4eda3789ec2f82f1e7dbe.jpg\" style=\"max-width: 100%;\"></p>', '999.00', '34', '45', '48', '1', '注意事项', '100.00', '1', '2', '1', null, '1545321600', '1545321600', '1545376111');
INSERT INTO `qp_product` VALUES ('118', '这是一件拍卖商品', 'uploads/productCover/201812/e438316b933f3d7598ded55c06fb3c3b.jpg', '213', '<p>哈哈哈</p>', '100.00', '34', '45', '48', '1', '152132', '20.00', '1', '1', '1', null, '1544457600', '1546012800', '1545443252');
INSERT INTO `qp_product` VALUES ('119', '一口价商品', 'uploads/productCover/201812/c07b97497818bc1e1fe9a31b269089c8.jpg', '20', '<p>312</p>', '100.00', '34', '45', '48', '2', '哈哈哈', null, '1', '1', '1', null, null, null, '1545443299');
INSERT INTO `qp_product` VALUES ('120', '又一个一口价商品', 'uploads/productCover/201812/c0e4ea44588d4980d21d72d33fcfc290.jpg', '456', '<p>123</p>', '123.00', '34', '45', '48', '1', '123', null, '1', '2', '1', null, null, null, '1545443398');
INSERT INTO `qp_product` VALUES ('121', '12.25', 'uploads/productCover/201812/c47a00b47d356c459087befb614f03f8.png', '213', '<p>1</p>', '99.00', '34', '45', '48', '1', '0123', null, '1', '1', '1', '1', null, null, '1545718149');
INSERT INTO `qp_product` VALUES ('122', '哈哈', 'uploads/productCover/201812/f87a252ee8fda77732aee866b8f171e3.png', '1', '<p>1&nbsp;&nbsp;&nbsp;&nbsp;</p>', '1.00', '34', '45', '47', '1', '1', null, '1', '1', '1', '1', null, null, '1545718217');
INSERT INTO `qp_product` VALUES ('123', '哈哈', 'uploads/productCover/201812/f87a252ee8fda77732aee866b8f171e3.png', '1', '<p>1&nbsp;&nbsp;&nbsp;&nbsp;</p>', '1.00', '34', '45', '47', '1', '1', null, '1', '1', '1', '1', null, null, '1545718228');
INSERT INTO `qp_product` VALUES ('124', '9999', 'uploads/productCover/201812/8d7c70ec8839ee7ffebe816d3633de7c.png', '1', '<p>1&nbsp;&nbsp;&nbsp;&nbsp;1</p>', '1.00', '34', '45', '48', '1', '1', null, '1', '1', '1', '2', null, null, '1545718373');
INSERT INTO `qp_product` VALUES ('125', '888', 'uploads/productCover/201812/8d7c70ec8839ee7ffebe816d3633de7c.png', '1', '<p>1&nbsp;&nbsp;&nbsp;&nbsp;1</p>', '1.00', '34', '45', '48', '1', '1', null, '1', '1', '2', '1', null, null, '1545718383');

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
) ENGINE=MyISAM AUTO_INCREMENT=759 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_product_banner
-- ----------------------------
INSERT INTO `qp_product_banner` VALUES ('757', '37', 'uploads/productBanner/201810/f7d41857913cb81ad5284a7ca6b49c59.jpg', '1', '1', '1540880509');
INSERT INTO `qp_product_banner` VALUES ('758', '116', 'uploads/productBanner/201812/2860d43d83f8b09234c8fc6318e47af1.jpg', '1', '1', '1545035574');

-- ----------------------------
-- Table structure for `qp_prod_list`
-- ----------------------------
DROP TABLE IF EXISTS `qp_prod_list`;
CREATE TABLE `qp_prod_list` (
  `list_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `product_id` int(10) DEFAULT '0' COMMENT '产品ID',
  `taoc_id` int(11) DEFAULT '0' COMMENT '套餐id',
  `order_number` char(30) NOT NULL COMMENT '订单号',
  `transaction_id` char(28) DEFAULT NULL COMMENT '微信支付凭证',
  `pay_money` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `prepay_id` text,
  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否支付（1、未支付；2、已支付（未评价）；3、已评价）',
  `list_add_time` int(10) NOT NULL COMMENT '订单生成时间',
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=329 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_prod_list
-- ----------------------------
INSERT INTO `qp_prod_list` VALUES ('309', '2678', '100', null, '2018121015444347292678', '4200000230201812101617258604', '0.01', 'wx10173849539273e11ce2c29f0608977623', '2', '1544434729');
INSERT INTO `qp_prod_list` VALUES ('310', '267', '101', null, '201812101544434806267', '4200000235201812108058146304', '0.01', 'wx10174006857859f64bc6c1282965946784', '3', '1544434806');
INSERT INTO `qp_prod_list` VALUES ('311', '257', '101', null, '201812101544434866257', null, '0.01', 'wx101741068467066fe0c1193f2938339921', '1', '1544434866');
INSERT INTO `qp_prod_list` VALUES ('312', '257', '101', null, '201812101544434894257', '4200000217201812106742883998', '0.01', 'wx101741345226014633735c011248376258', '2', '1544434894');
INSERT INTO `qp_prod_list` VALUES ('313', '2678', '107', null, '2018121015444528412678', null, '0.01', 'wx10224042083915eb220e6a542863586657', '1', '1544452841');
INSERT INTO `qp_prod_list` VALUES ('314', '2678', '107', null, '2018121015444528622678', null, '0.01', 'wx102241031061235eaea8fde42339253629', '1', '1544452862');
INSERT INTO `qp_prod_list` VALUES ('315', '2678', '107', null, '2018121015444528842678', '4200000221201812106434217152', '0.01', 'wx10224125140130d1b32eff001729902166', '2', '1544452884');
INSERT INTO `qp_prod_list` VALUES ('316', '2678', '101', null, '2018121115444984412678', null, '0.01', 'wx111120421352498e81f230843439059123', '1', '1544498441');
INSERT INTO `qp_prod_list` VALUES ('317', '2678', '101', null, '2018121115444984552678', '4200000234201812112840750237', '0.01', 'wx11112055581076bcb0f38df34091946568', '2', '1544498455');
INSERT INTO `qp_prod_list` VALUES ('318', '267', null, '10', '201812111544522625267', null, '19.89', 'wx11180345602438852e8dc4550551564629', '1', '1544522625');
INSERT INTO `qp_prod_list` VALUES ('319', '2678', null, '10', '2018121115445248462678', null, '0.02', 'wx11184046323852a1115740fd3317064521', '1', '1544524846');
INSERT INTO `qp_prod_list` VALUES ('320', '267', null, '10', '201812111544525581267', null, '0.02', 'wx111853014037992bd9218c973424034115', '1', '1544525581');
INSERT INTO `qp_prod_list` VALUES ('321', '267', null, '10', '201812111544526497267', null, '0.02', 'wx11190817518243cfc65464361839582164', '1', '1544526497');
INSERT INTO `qp_prod_list` VALUES ('322', '267', null, '10', '201812111544526517267', null, '0.02', 'wx1119083812182234d4125ea52955026089', '1', '1544526517');
INSERT INTO `qp_prod_list` VALUES ('323', '267', null, '10', '201812111544526522267', null, '0.02', 'wx111908430973785913aabadc2028942490', '1', '1544526522');
INSERT INTO `qp_prod_list` VALUES ('324', '2679', '104', null, '2018121215445862402679', null, '99.00', 'wx121144009325167446cf156f1862144082', '1', '1544586240');
INSERT INTO `qp_prod_list` VALUES ('325', '2679', '106', null, '2018121215445862562679', null, '99.00', 'wx12114417029127085e1d7ee01789673992', '1', '1544586256');
INSERT INTO `qp_prod_list` VALUES ('326', '2679', '104', null, '2018121215445862852679', null, '99.00', 'wx12114445269911736c8620494281375917', '1', '1544586285');
INSERT INTO `qp_prod_list` VALUES ('327', '2679', '104', null, '2018121215445863012679', null, '99.00', 'wx121145018524430f171b48122602406952', '1', '1544586301');
INSERT INTO `qp_prod_list` VALUES ('328', '2679', '100', null, '2018121215445863212679', '4200000236201812126196783816', '0.01', 'wx1211452189875811b8d917e73629580480', '3', '1544586321');

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
-- Table structure for `qp_setting`
-- ----------------------------
DROP TABLE IF EXISTS `qp_setting`;
CREATE TABLE `qp_setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '分销设置表',
  `default_lines` decimal(10,2) NOT NULL DEFAULT '1000.00' COMMENT '用户注册获得的竞拍额度',
  `lines_default_proportion` int(10) NOT NULL DEFAULT '1000' COMMENT '竞拍额度充值比例；1元=?额度',
  `lines_bad_proportion` int(10) NOT NULL DEFAULT '50' COMMENT '违规之后的竞拍额度充值比例',
  `server_rate` int(3) NOT NULL DEFAULT '11' COMMENT '服务费率%',
  `postage_proportion` decimal(10,2) NOT NULL DEFAULT '1.00' COMMENT '积分抵邮费；1元=x积分',
  `save_day` int(10) NOT NULL DEFAULT '60' COMMENT '竞品暂存天数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_setting
-- ----------------------------
INSERT INTO `qp_setting` VALUES ('1', '1000.00', '1000', '50', '11', '1.00', '60');

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
  `openid` varchar(100) NOT NULL,
  `face` varchar(300) DEFAULT NULL COMMENT '头像',
  `user_mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `user_is_lock` tinyint(1) DEFAULT '1',
  `user_add_time` int(10) DEFAULT NULL COMMENT '用户注册时间',
  `lines` decimal(10,2) NOT NULL COMMENT '用户可用竞拍额度（元）',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2722 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user
-- ----------------------------
INSERT INTO `qp_user` VALUES ('2721', 'Y_Lin', '1', 'oXXyo5aN4ePWCKg-k5OPVxP-4Ops', 'https://wx.qlogo.cn/mmopen/vi_32/2TdZ2bbwCNxfj0UPicQMiaBtFq7ibbVte3RS6kXk2FIr3Dkd4Ie7DX0EjFy10VjibSbEIibsPdCvDJqCh6QjxcVfd1A/132', null, '1', '1544758831', '1000.00');

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
INSERT INTO `qp_user_address` VALUES ('37', '2721', '张三', '15163444790', '广东省', '广州市', '海珠区', '新港中路397号', '2', '1545207412');
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
) ENGINE=MyISAM AUTO_INCREMENT=379 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_collection
-- ----------------------------

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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_offer_agent
-- ----------------------------
INSERT INTO `qp_user_offer_agent` VALUES ('3', '10086', '116', '121.00', '1545463655');

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
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_offer_price
-- ----------------------------
INSERT INTO `qp_user_offer_price` VALUES ('5', '2721', '116', '1', '100.00', '1545463626');
INSERT INTO `qp_user_offer_price` VALUES ('13', '2721', '116', '1', '101.00', '1545464081');
INSERT INTO `qp_user_offer_price` VALUES ('14', '10086', '116', '1', '121.00', '1545464081');
INSERT INTO `qp_user_offer_price` VALUES ('15', '2721', '124', '1', '1.00', '1545720042');
INSERT INTO `qp_user_offer_price` VALUES ('16', '2721', '124', '1', '2.00', '1545720051');
INSERT INTO `qp_user_offer_price` VALUES ('17', '2721', '124', '1', '3.00', '1545720054');
INSERT INTO `qp_user_offer_price` VALUES ('18', '2721', '124', '1', '4.00', '1545720055');
INSERT INTO `qp_user_offer_price` VALUES ('19', '2721', '124', '1', '5.00', '1545720057');
INSERT INTO `qp_user_offer_price` VALUES ('20', '2721', '124', '1', '6.00', '1545720060');
INSERT INTO `qp_user_offer_price` VALUES ('21', '2721', '124', '1', '7.00', '1545720062');
INSERT INTO `qp_user_offer_price` VALUES ('22', '2721', '124', '1', '8.00', '1545720064');
INSERT INTO `qp_user_offer_price` VALUES ('23', '2721', '124', '1', '9.00', '1545720065');
INSERT INTO `qp_user_offer_price` VALUES ('24', '2721', '124', '1', '10.00', '1545720067');
INSERT INTO `qp_user_offer_price` VALUES ('25', '2721', '116', '1', '122.00', '1545723930');
INSERT INTO `qp_user_offer_price` VALUES ('26', '2721', '116', '1', '123.00', '1545723934');
INSERT INTO `qp_user_offer_price` VALUES ('27', '2721', '116', '1', '124.00', '1545723936');
INSERT INTO `qp_user_offer_price` VALUES ('28', '2721', '116', '1', '127.00', '1545724058');

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
INSERT INTO `qp_user_offer_settime` VALUES ('1', '2721', '116', '141.00', '1544975975', '1', '1545468244');

-- ----------------------------
-- Table structure for `qp_user_record`
-- ----------------------------
DROP TABLE IF EXISTS `qp_user_record`;
CREATE TABLE `qp_user_record` (
  `user_record_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '会员充值记录ID',
  `order_number` char(20) NOT NULL COMMENT '订单号',
  `member_price_id` int(10) NOT NULL,
  `transaction_id` char(28) DEFAULT NULL COMMENT '微信支付单号',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `member_pay_money` decimal(10,2) NOT NULL COMMENT '实付金额',
  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否支付(1、未支付；2、已经支付）',
  `service_name` varchar(20) NOT NULL COMMENT '服务名称',
  `begin_time` int(10) DEFAULT NULL COMMENT '生效时间',
  `end_time` int(10) DEFAULT NULL COMMENT '到期时间',
  `service_time` int(10) DEFAULT NULL COMMENT '服务时间（月）',
  `user_record_add_time` int(10) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`user_record_id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qp_user_record
-- ----------------------------
INSERT INTO `qp_user_record` VALUES ('130', '20181211154452144777', '14', '4200000235201812113499220602', '2678', '0.03', '2', 'VIP3', null, null, null, '1544521447');
INSERT INTO `qp_user_record` VALUES ('129', '20181211154452143488', '13', '4200000236201812110690314509', '2678', '0.01', '2', 'VIP2', null, null, null, '1544521434');
INSERT INTO `qp_user_record` VALUES ('128', '20181211154452142351', '13', null, '2678', '0.01', '1', 'VIP2', null, null, null, '1544521423');
INSERT INTO `qp_user_record` VALUES ('127', '20181211154452118034', '14', '4200000218201812118355127160', '2678', '0.03', '2', 'VIP3', null, null, null, '1544521180');
INSERT INTO `qp_user_record` VALUES ('126', '20181211154452113138', '14', null, '2678', '0.03', '1', 'VIP3', null, null, null, '1544521131');
INSERT INTO `qp_user_record` VALUES ('125', '20181211154452052737', '13', '4200000220201812119255838488', '267', '0.01', '2', 'vip3', null, null, null, '1544520527');
INSERT INTO `qp_user_record` VALUES ('124', '20181211154452033341', '12', '4200000225201812118449956433', '2678', '0.02', '2', 'vip2', null, null, null, '1544520333');
INSERT INTO `qp_user_record` VALUES ('123', '20181211154452026330', '13', null, '267', '3.00', '1', 'vip3', null, null, null, '1544520263');
INSERT INTO `qp_user_record` VALUES ('122', '20181208154425656830', '12', '4200000231201812083577235440', '267', '0.01', '2', 'vip2', null, null, null, '1544256568');
