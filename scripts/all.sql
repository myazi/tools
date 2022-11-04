-- MySQL dump 10.13  Distrib 5.6.34, for Linux (x86_64)
--
-- Host: localhost    Database: c2m
-- ------------------------------------------------------
-- Server version	5.6.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `key_bs`
--

DROP TABLE IF EXISTS `key_bs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `key_bs` (
  `kid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key1` varchar(100) NOT NULL,
  `value2` varchar(1000) NOT NULL,
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB AUTO_INCREMENT=131071 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_bs`
--

LOCK TABLES `key_bs` WRITE;
/*!40000 ALTER TABLE `key_bs` DISABLE KEYS */;
/*!40000 ALTER TABLE `key_bs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `key_details`
--

DROP TABLE IF EXISTS `key_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `key_details` (
  `kid` bigint(20) NOT NULL AUTO_INCREMENT,
  `key1` varchar(100) DEFAULT NULL COMMENT '关键词',
  `nid_nums` int(10) DEFAULT NULL COMMENT '资源量',
  `show_cnt` bigint(16) DEFAULT NULL COMMENT '展现量',
  `click_cnt` bigint(16) DEFAULT NULL COMMENT '分发量',
  `zhuanhua` int(10) DEFAULT NULL COMMENT '转化量',
  `gmv` float DEFAULT NULL COMMENT 'gmv',
  `demo` varchar(1000) DEFAULT NULL COMMENT '标杆资源',
  PRIMARY KEY (`kid`),
  UNIQUE KEY `key` (`key1`)
) ENGINE=InnoDB AUTO_INCREMENT=65535 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_details`
--

LOCK TABLES `key_details` WRITE;
/*!40000 ALTER TABLE `key_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `key_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_key_details`
--

DROP TABLE IF EXISTS `new_key_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `new_key_details` (
  `kid` bigint(20) NOT NULL AUTO_INCREMENT,
  `key1` varchar(100) DEFAULT NULL COMMENT '关键词',
  `nid_nums` int(10) DEFAULT NULL COMMENT '资源量',
  `show_cnt` bigint(16) DEFAULT NULL COMMENT '展现量',
  `click_cnt` bigint(16) DEFAULT NULL COMMENT '分发量',
  `zhuanhua` int(10) DEFAULT NULL COMMENT '转化量',
  `gmv` float DEFAULT NULL COMMENT 'gmv',
  `demo_click` varchar(1000) DEFAULT NULL COMMENT '标杆资源',
  `demo_zhuanhua` varchar(1000) DEFAULT NULL COMMENT '标杆资源',
  `demo_gmv` varchar(1000) DEFAULT NULL COMMENT '标杆资源',
  PRIMARY KEY (`kid`),
  UNIQUE KEY `key` (`key1`)
) ENGINE=InnoDB AUTO_INCREMENT=10238 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_key_details`
--

LOCK TABLES `new_key_details` WRITE;
/*!40000 ALTER TABLE `new_key_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `new_key_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_key_users`
--

DROP TABLE IF EXISTS `new_key_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `new_key_users` (
  `kid` bigint(20) NOT NULL AUTO_INCREMENT,
  `key1` varchar(100) DEFAULT NULL COMMENT '关键词',
  `value1` varchar(100) DEFAULT NULL COMMENT '受众类型',
  `num` int(10) DEFAULT NULL COMMENT '受众占比',
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB AUTO_INCREMENT=4096 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_key_users`
--

LOCK TABLES `new_key_users` WRITE;
/*!40000 ALTER TABLE `new_key_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `new_key_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nid_users`
--

DROP TABLE IF EXISTS `nid_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nid_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nid` varchar(30) DEFAULT '0' COMMENT '资源id',
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `url` varchar(200) DEFAULT NULL COMMENT '链接',
  `tags` varchar(200) DEFAULT NULL COMMENT '标签',
  `new_cate_v2` varchar(100) DEFAULT NULL COMMENT '一级分类',
  `new_sub_cate_v2` varchar(100) DEFAULT NULL COMMENT '二级分类',
  `users` varchar(10000) DEFAULT NULL COMMENT '受众人群',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vid` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=1300163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nid_users`
--

LOCK TABLES `nid_users` WRITE;
/*!40000 ALTER TABLE `nid_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `nid_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stopword`
--

DROP TABLE IF EXISTS `stopword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stopword` (
  `kid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key1` varchar(100) NOT NULL,
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stopword`
--

LOCK TABLES `stopword` WRITE;
/*!40000 ALTER TABLE `stopword` DISABLE KEYS */;
/*!40000 ALTER TABLE `stopword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-25 12:04:51
-- MySQL dump 10.13  Distrib 5.6.34, for Linux (x86_64)
--
-- Host: localhost    Database: yongshangyiti
-- ------------------------------------------------------
-- Server version	5.6.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `all_nid_details`
--

DROP TABLE IF EXISTS `all_nid_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_nid_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nid` varchar(30) DEFAULT '0' COMMENT '资源id',
  `context_type` int(2) DEFAULT NULL COMMENT '资源类型',
  `conv_type` int(2) DEFAULT NULL COMMENT '转化类型',
  `mthid` varchar(30) DEFAULT NULL COMMENT '作者id',
  `author` varchar(100) DEFAULT NULL COMMENT '作者名',
  `public_time` int(20) DEFAULT NULL COMMENT '资源最新发布时间',
  `first_public_time` int(20) DEFAULT NULL COMMENT '资源首次发布时间',
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `url` varchar(200) DEFAULT NULL COMMENT '落地页链接',
  `video_duration` int(11) DEFAULT NULL COMMENT '视频时长',
  `stitle` varchar(200) DEFAULT NULL COMMENT '方案标题',
  `author_brand_level` int(2) DEFAULT NULL COMMENT '作者品牌等级',
  `del_tag` int(4) DEFAULT NULL COMMENT '屏蔽标识',
  `new_cate_v2` varchar(100) DEFAULT NULL COMMENT '一级分类',
  `new_sub_cate_v2` varchar(100) DEFAULT NULL COMMENT '二级分类',
  `tags` varchar(100) DEFAULT NULL COMMENT '标签',
  `local_bus_supplier` int(2) DEFAULT NULL COMMENT '用商标识',
  `hangye` varchar(30) DEFAULT '0' COMMENT '作者行业',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vid` (`nid`),
  KEY `context_type` (`context_type`),
  KEY `conv_type` (`conv_type`),
  KEY `mthid` (`mthid`)
) ENGINE=InnoDB AUTO_INCREMENT=1752309 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_nid_details`
--

LOCK TABLES `all_nid_details` WRITE;
/*!40000 ALTER TABLE `all_nid_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_nid_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duan_all_video`
--

DROP TABLE IF EXISTS `duan_all_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duan_all_video` (
  `event_day` date DEFAULT NULL,
  `author` text,
  `vid` text,
  `title` text,
  `public_time` text,
  `url` text,
  `vtype` text,
  `show_cnt` int(11) DEFAULT NULL,
  `click_cnt` int(11) DEFAULT NULL,
  `ctr` double DEFAULT NULL,
  `play_ratio` double DEFAULT NULL,
  `play_times_ratio` double DEFAULT NULL,
  `solution_show` int(11) DEFAULT NULL,
  `h5_show` int(11) DEFAULT NULL,
  `h5_click` int(11) DEFAULT NULL,
  `zhuanhua` int(11) DEFAULT NULL,
  `zhuanhua_ratio` double DEFAULT NULL,
  `pirce` double DEFAULT NULL,
  `gmv` double DEFAULT NULL,
  `sid` text,
  `stitle` text,
  `slabel` text,
  `gz` int(11) DEFAULT NULL,
  `dz` int(11) DEFAULT NULL,
  `sc` int(11) DEFAULT NULL,
  `pl` int(11) DEFAULT NULL,
  `zf` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duan_all_video`
--

LOCK TABLES `duan_all_video` WRITE;
/*!40000 ALTER TABLE `duan_all_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `duan_all_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duan_video`
--

DROP TABLE IF EXISTS `duan_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duan_video` (
  `event_day` date DEFAULT NULL,
  `author` text,
  `vid` text,
  `show_cnt` int(11) DEFAULT NULL,
  `click_cnt` int(11) DEFAULT NULL,
  `ctr` double DEFAULT NULL,
  `play_ratio` double DEFAULT NULL,
  `solution_show` int(11) DEFAULT NULL,
  `h5_show` int(11) DEFAULT NULL,
  `h5_click` int(11) DEFAULT NULL,
  `zhuanhua` int(11) DEFAULT NULL,
  `zhuanhua_ratio` double DEFAULT NULL,
  `gz` int(11) DEFAULT NULL,
  `dz` int(11) DEFAULT NULL,
  `sc` int(11) DEFAULT NULL,
  `pl` int(11) DEFAULT NULL,
  `zf` int(11) DEFAULT NULL,
  `avg_q` double DEFAULT NULL,
  `avg_qratio` double DEFAULT NULL,
  `video_duration` double DEFAULT NULL,
  `play_all_time` double DEFAULT NULL,
  `click_user` int(11) DEFAULT NULL,
  `two_open` int(11) DEFAULT NULL,
  `play_times` int(11) DEFAULT NULL,
  `mthid` varchar(100) DEFAULT NULL,
  `public_time` varchar(100) DEFAULT NULL,
  `input_frame` int(11) DEFAULT NULL,
  `quickbuy_btn` int(11) DEFAULT NULL,
  `buy_fail` int(11) DEFAULT NULL,
  `buy_suc` int(11) DEFAULT NULL,
  `solution_click` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duan_video`
--

LOCK TABLES `duan_video` WRITE;
/*!40000 ALTER TABLE `duan_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `duan_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `good_nid_details`
--

DROP TABLE IF EXISTS `good_nid_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `good_nid_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bert_cate` varchar(200) DEFAULT NULL COMMENT 'Bert分类',
  `nid` varchar(30) DEFAULT '0' COMMENT '资源id',
  `title` varchar(500) DEFAULT NULL COMMENT '资源标题',
  `url` varchar(200) DEFAULT NULL COMMENT '落地页链接',
  `public_time` int(20) DEFAULT NULL COMMENT '资源发布时间',
  `mthid` varchar(30) DEFAULT NULL COMMENT '作者id',
  `uploader` varchar(100) DEFAULT NULL COMMENT '作者名',
  `sv_author_brand_level` int(2) DEFAULT NULL COMMENT '作者等级',
  `tags` varchar(500) DEFAULT NULL COMMENT '标签',
  `general_tag` varchar(500) DEFAULT NULL COMMENT '泛标签',
  `manual_tags` varchar(500) DEFAULT NULL COMMENT '手动标签',
  `video_type` int(2) DEFAULT NULL COMMENT '视频类型',
  `realurl` varchar(200) DEFAULT NULL COMMENT 'real链接',
  `video_duration` int(11) DEFAULT NULL COMMENT '视频时长',
  `new_cate_v2` varchar(100) DEFAULT NULL COMMENT '一级分类',
  `new_sub_cate_v2` varchar(100) DEFAULT NULL COMMENT '二级分类',
  `bjh_is_v` int(2) DEFAULT NULL COMMENT '百家号权威',
  `is_microvideo` int(2) DEFAULT NULL COMMENT '是否小视频',
  `list_show` float DEFAULT NULL COMMENT '列表页展现(5-12-all)',
  `list_click` float DEFAULT NULL COMMENT '列表页点击(3-3-all)',
  `list_dislike` float DEFAULT NULL COMMENT '列表页dislike(3-9-all)',
  `details_author_follows` float DEFAULT NULL COMMENT '落地页关注(3-28-all)',
  `details_share` float DEFAULT NULL COMMENT '落地页分享(3-16-all)',
  `details_collect` float DEFAULT NULL COMMENT '落地页收藏(3-15-all)',
  `list_click_like` float DEFAULT NULL COMMENT '列表页点赞(3-13-all)',
  `list_click_dislike` float DEFAULT NULL COMMENT '列表页点踩(3-19-all)',
  `details_like` float DEFAULT NULL COMMENT '落地页点赞(14-13-all)',
  `details_dislike` float DEFAULT NULL COMMENT '落地页点踩(14-9-all)',
  `details_good_comments` float DEFAULT NULL COMMENT '落地页正面评论(3-21-all)',
  `play_sum` float DEFAULT NULL COMMENT '落地页视频播放时长累加和(3-101-play)',
  `finish100` float DEFAULT NULL COMMENT '完成100%(3-101-100) ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vid` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=1855 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `good_nid_details`
--

LOCK TABLES `good_nid_details` WRITE;
/*!40000 ALTER TABLE `good_nid_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `good_nid_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `microv_nid_info`
--

DROP TABLE IF EXISTS `microv_nid_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `microv_nid_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_day` date DEFAULT NULL,
  `nid` varchar(40) NOT NULL COMMENT '资源id',
  `author` varchar(100) NOT NULL COMMENT '商家',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `duration` varchar(100) DEFAULT NULL COMMENT '视频时长',
  `public_time` varchar(100) DEFAULT 'NULL' COMMENT '发布时间',
  `click` int(11) DEFAULT NULL COMMENT '点击量',
  `short` int(11) DEFAULT NULL COMMENT '快滑',
  `finish_prob` int(11) DEFAULT NULL COMMENT '完播',
  `finish_rate` float DEFAULT NULL COMMENT '完成',
  `zhuanhua` int(11) DEFAULT NULL COMMENT '转化',
  `zhuanhua_show` int(11) DEFAULT '0' COMMENT '组建展现',
  `dur_join_scc` int(11) DEFAULT NULL COMMENT '时长分发',
  `like_v` int(11) DEFAULT '0' COMMENT '点赞',
  `follow` int(11) DEFAULT '0' COMMENT '关注',
  `share` int(11) DEFAULT '0' COMMENT '分享',
  `comment_view` int(11) DEFAULT '0' COMMENT '评论',
  `dislike` int(11) DEFAULT '0' COMMENT '点踩',
  `active_join_scc` int(11) DEFAULT '0' COMMENT '互动分发',
  `mthid` varchar(40) NOT NULL COMMENT '商家id',
  `convert_type` varchar(40) NOT NULL COMMENT '转化类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `microv_nid_info_unique_key` (`event_day`,`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=20787662 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `microv_nid_info`
--

LOCK TABLES `microv_nid_info` WRITE;
/*!40000 ALTER TABLE `microv_nid_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `microv_nid_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mthid_details`
--

DROP TABLE IF EXISTS `mthid_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mthid_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mthid` varchar(100) DEFAULT '0' COMMENT '商家id',
  `author` varchar(100) DEFAULT '0' COMMENT '商家名',
  `hangye` varchar(100) DEFAULT '0' COMMENT '一级行业',
  `sub_hangye` varchar(100) DEFAULT '0' COMMENT '二级行业',
  `institution` varchar(200) DEFAULT '0' COMMENT '机构名称',
  `sell` varchar(100) DEFAULT '0' COMMENT '销售体系',
  `business` varchar(100) DEFAULT '0' COMMENT '运营单位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mthid` (`mthid`)
) ENGINE=InnoDB AUTO_INCREMENT=1309879 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mthid_details`
--

LOCK TABLES `mthid_details` WRITE;
/*!40000 ALTER TABLE `mthid_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `mthid_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nid_video`
--

DROP TABLE IF EXISTS `nid_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nid_video` (
  `event_day` date DEFAULT NULL,
  `author` varchar(100) DEFAULT '0' COMMENT '商家名',
  `vid` varchar(30) DEFAULT '0' COMMENT '资源id',
  `title` varchar(500) DEFAULT '0' COMMENT '标题',
  `public_time` varchar(100) DEFAULT '0' COMMENT '发布时间',
  `vtype` varchar(20) DEFAULT '0' COMMENT '资源类型',
  `show_cnt` int(11) DEFAULT '0' COMMENT '展现量',
  `click_cnt` int(11) DEFAULT '0' COMMENT '点击量',
  `ctr` double DEFAULT '0' COMMENT 'ctr',
  `zhuanhua` int(11) DEFAULT '0' COMMENT '转化量',
  `zhuanhua_ratio` double DEFAULT '0' COMMENT '转化率',
  `pirce` double DEFAULT '0' COMMENT '单价',
  `gmv` double DEFAULT '0' COMMENT 'gmv',
  `stitle` varchar(500) DEFAULT '0' COMMENT '方案标题',
  `gz` int(11) DEFAULT '0' COMMENT '关注量',
  `dz` int(11) DEFAULT '0' COMMENT '点赞量',
  `sc` int(11) DEFAULT '0' COMMENT '收藏量',
  `pl` int(11) DEFAULT '0' COMMENT '评论量',
  `zf` int(11) DEFAULT '0' COMMENT '转发量',
  `hangye` varchar(500) DEFAULT '0' COMMENT '行业类型',
  `conv_type` varchar(500) DEFAULT '0' COMMENT '转化类型',
  `play_all_time` double DEFAULT '0' COMMENT '播放时长',
  `play_times` int(11) DEFAULT '0' COMMENT '完播次数',
  `conv_show` int(11) DEFAULT '0' COMMENT '转化展现'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nid_video`
--

LOCK TABLES `nid_video` WRITE;
/*!40000 ALTER TABLE `nid_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `nid_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solu_video`
--

DROP TABLE IF EXISTS `solu_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solu_video` (
  `event_day` date DEFAULT NULL,
  `author` text,
  `vid` text,
  `sid` text,
  `stitle` text,
  `slabel` text,
  `vtype` text,
  `show_cnt` int(11) DEFAULT NULL,
  `click_cnt` int(11) DEFAULT NULL,
  `ctr` double DEFAULT NULL,
  `zhuanhua` int(11) DEFAULT NULL,
  `zhuanhua_ratio` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solu_video`
--

LOCK TABLES `solu_video` WRITE;
/*!40000 ALTER TABLE `solu_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `solu_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vid_video_details`
--

DROP TABLE IF EXISTS `vid_video_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vid_video_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vid` varchar(100) DEFAULT '0' COMMENT '资源id',
  `vtype` varchar(500) DEFAULT '0' COMMENT '资源类型',
  `mthid` varchar(100) DEFAULT '0' COMMENT '作者id',
  `author` varchar(100) DEFAULT '0' COMMENT '商家名',
  `public_time` varchar(100) DEFAULT NULL COMMENT '资源发布时间',
  `title` varchar(500) DEFAULT '0' COMMENT '标题',
  `url` varchar(500) DEFAULT '0' COMMENT '落地页链接',
  `video_duration` int(11) DEFAULT '0' COMMENT '视频时长',
  `stitle` varchar(500) DEFAULT '0' COMMENT '表单标题',
  `sv_author_brand_level` int(4) DEFAULT '0' COMMENT '作者品牌',
  `del_tag` int(4) DEFAULT '0' COMMENT '屏蔽标识',
  `new_cate_v2` varchar(500) DEFAULT '0' COMMENT '一级分类',
  `new_sub_cate_v2` varchar(500) DEFAULT '0' COMMENT '二级分类',
  `tags` varchar(500) DEFAULT '0' COMMENT '标签',
  `conv_type` varchar(500) DEFAULT '0' COMMENT '转化类型',
  `hangye` varchar(500) DEFAULT '0' COMMENT '行业类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vid` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=1549976 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vid_video_details`
--

LOCK TABLES `vid_video_details` WRITE;
/*!40000 ALTER TABLE `vid_video_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `vid_video_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xiao_all_video`
--

DROP TABLE IF EXISTS `xiao_all_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xiao_all_video` (
  `event_day` date DEFAULT NULL,
  `author` text,
  `vid` varchar(30) DEFAULT '0' COMMENT '资源id',
  `title` varchar(500) DEFAULT '0' COMMENT '标题',
  `public_time` text,
  `url` text,
  `vtype` text,
  `show_cnt` int(11) DEFAULT NULL,
  `click_cnt` int(11) DEFAULT NULL,
  `ctr` double DEFAULT NULL,
  `play_ratio` double DEFAULT NULL,
  `play_times_ratio` double DEFAULT NULL,
  `union_marker_show` int(11) DEFAULT NULL,
  `union_marker_clk` int(11) DEFAULT NULL,
  `union_float_show` int(11) DEFAULT NULL,
  `union_float_close` int(11) DEFAULT NULL,
  `union_float_input` int(11) DEFAULT NULL,
  `union_float_receive` int(11) DEFAULT NULL,
  `zhuanhua` int(11) DEFAULT NULL,
  `zhuanhua_ratio` double DEFAULT NULL,
  `pirce` double DEFAULT NULL,
  `gmv` double DEFAULT NULL,
  `sid` text,
  `stitle` text,
  `slabel` text,
  `gz` int(11) DEFAULT NULL,
  `dz` int(11) DEFAULT NULL,
  `sc` int(11) DEFAULT NULL,
  `pl` int(11) DEFAULT NULL,
  `zf` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xiao_all_video`
--

LOCK TABLES `xiao_all_video` WRITE;
/*!40000 ALTER TABLE `xiao_all_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `xiao_all_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xiao_video`
--

DROP TABLE IF EXISTS `xiao_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xiao_video` (
  `event_day` date DEFAULT NULL,
  `author` text,
  `vid` text,
  `show_cnt` int(11) DEFAULT NULL,
  `click_cnt` int(11) DEFAULT NULL,
  `ctr` double DEFAULT NULL,
  `play_ratio` double DEFAULT NULL,
  `union_marker_show` int(11) DEFAULT NULL,
  `union_marker_clk` int(11) DEFAULT NULL,
  `union_float_show` int(11) DEFAULT NULL,
  `union_float_close` int(11) DEFAULT NULL,
  `union_float_input` int(11) DEFAULT NULL,
  `union_float_receive` int(11) DEFAULT NULL,
  `zhuanhua` int(11) DEFAULT NULL,
  `zhuanhua_ratio` double DEFAULT NULL,
  `gz` int(11) DEFAULT NULL,
  `dz` int(11) DEFAULT NULL,
  `sc` int(11) DEFAULT NULL,
  `pl` int(11) DEFAULT NULL,
  `zf` int(11) DEFAULT NULL,
  `avg_q` double DEFAULT NULL,
  `avg_qratio` double DEFAULT NULL,
  `video_duration` double DEFAULT NULL,
  `play_all_time` double DEFAULT NULL,
  `click_user` int(11) DEFAULT NULL,
  `two_open` int(11) DEFAULT NULL,
  `play_times` int(11) DEFAULT NULL,
  `mthid` varchar(100) DEFAULT NULL,
  `public_time` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xiao_video`
--

LOCK TABLES `xiao_video` WRITE;
/*!40000 ALTER TABLE `xiao_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `xiao_video` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-25 12:14:18
select event_day, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, count(distinct if(show_cnt>0, vid, null)) as show_nid_num,round(sum(click_cnt)/(sum(show_cnt + 0.1)),3)  as ctr, round(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio,sum(solution_show) as solution_show, round((sum(solution_show)*1.0)/(sum(click_cnt)*1.0), 4) as solution_ratio, sum(solution_click) as solution_click, sum(buy_fail) as h5_show, sum(buy_suc) as h5_click, sum(zhuanhua) as zhuanhua, count(distinct if(zhuanhua>0, vid, null)) as cvr_nid_num, round(sum(zhuanhua)/ (sum(solution_show)+0.1),6)  as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from duan_video where {event_day [conditions.event_days]} group by event_day order by event_day desc;

select event_day, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, count(distinct if(show_cnt>0, vid, null)) as show_nid_num,round(sum(click_cnt)/(sum(show_cnt + 0.1)),3)  as ctr, round(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio,sum(solution_show) as solution_show, round((sum(solution_show)*1.0)/(sum(click_cnt)*1.0), 4) as solution_ratio, sum(solution_click) as solution_click, sum(buy_fail) as h5_show, sum(buy_suc) as h5_click, sum(zhuanhua) as zhuanhua, count(distinct if(zhuanhua>0, vid, null)) as cvr_nid_num, round(sum(zhuanhua)/ (sum(solution_show)+0.1),6)  as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from duan_video where {event_day [conditions.event_days]} group by event_day order by event_day desc;

select concat(min(event_day), ' - ', max(event_day)) as event_day, author,count(distinct if(show_cnt>0, vid, null)) as show_vid_num, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, FORMAT(sum(click_cnt)/(sum(show_cnt) + 0.1),3) as ctr, FORMAT(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio,sum(solution_show) as solution_show, round(sum(solution_show)/ (sum(click_cnt)+0.01),6)  as solution_show_ratio, sum(solution_click) as solution_click, sum(h5_show) as h5_show, sum(h5_click) as h5_click, sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/(sum(click_cnt) + 0.1),6) as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from duan_video where {event_day [conditions.event_days]} and {author = [conditions.author]} group by author order by zhuanhua desc, show_cnt desc;

select event_day, author, vid, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, round(sum(avg_q)/ count(event_day),4) as avg_q, round(sum(avg_qratio)/ count(event_day),4) as avg_qratio,video_duration,  sum(play_all_time) as play_all_time, sum(click_user) as click_user, sum(two_open) as two_open, sum(play_times) as play_times, mthid, public_time,  FORMAT(sum(click_cnt)/(sum(show_cnt) + 0.1),3) as ctr, FORMAT(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio,sum(solution_show) as solution_show, sum(solution_click) as solution_click, sum(h5_show) as h5_show, sum(h5_click) as h5_click, sum(input_frame) as input_frame, sum(quickbuy_btn) as quickbuy_btn, sum(buy_fail) as buy_fail, sum(buy_suc) as buy_suc,  sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/(sum(click_cnt) + 0.1),6) as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc, sum(pl) as pl, sum(zf) as zf from duan_video where {event_day [conditions.event_days]} and {author = [conditions.author]}  and {vid = [conditions.vid]} group by event_day, vid order by event_day desc, zhuanhua desc, show_cnt desc;

select event_day, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, count(distinct if(show_cnt>0, vid, null)) as show_nid_num, round(sum(show_cnt) / (count(distinct if(show_cnt>0, vid, null)) * 1.0), 0) as avg_show_cnt, round(sum(click_cnt) / (count(distinct if(show_cnt>0, vid, null)) * 1.0), 0) as avg_click_cnt ,round(sum(click_cnt)/(sum(show_cnt + 0.1)),4) as ctr, round(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio, sum(union_marker_show) as union_marker_show, round((sum(union_marker_show) * 1.0)/(sum(click_cnt) * 1.0),4) as union_marker_ratio, sum(union_marker_clk) as union_marker_clk, sum(union_float_show) as union_float_show,round(sum(union_float_show)*1.0/(sum(click_cnt) + 0.01), 5) as union_float_show_ratio, sum(union_float_close) as union_float_close, sum(union_float_input) as union_float_input, sum(union_float_receive) as union_float_receive, sum(zhuanhua) as zhuanhua, count(distinct if(zhuanhua>0, vid, null)) as cvr_nid_num, round(sum(zhuanhua)/ (sum(click_cnt)+0.1),6)  as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from  xiao_video where {event_day [conditions.event_days]} group by event_day order by event_day desc;

select event_day, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, count(distinct if(show_cnt>0, vid, null)) as show_nid_num, round(sum(show_cnt) / (count(distinct if(show_cnt>0, vid, null)) * 1.0), 0) as avg_show_cnt, round(sum(click_cnt) / (count(distinct if(show_cnt>0, vid, null)) * 1.0), 0) as avg_click_cnt ,round(sum(click_cnt)/(sum(show_cnt + 0.1)),4) as ctr, round(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio, sum(union_marker_show) as union_marker_show, round((sum(union_marker_show) * 1.0)/(sum(click_cnt) * 1.0),4) as union_marker_ratio, sum(union_marker_clk) as union_marker_clk, sum(union_float_show) as union_float_show,round(sum(union_float_show)*1.0/(sum(click_cnt) + 0.01), 5) as union_float_show_ratio, sum(union_float_close) as union_float_close, sum(union_float_input) as union_float_input, sum(union_float_receive) as union_float_receive, sum(zhuanhua) as zhuanhua, count(distinct if(zhuanhua>0, vid, null)) as cvr_nid_num, round(sum(zhuanhua)/ (sum(click_cnt)+0.1),6)  as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from  xiao_video where {event_day [conditions.event_days]} group by event_day order by event_day desc;

select concat(min(event_day), ' - ', max(event_day)) as event_day, author, count(distinct if(show_cnt>0, vid, null)) as show_vid_num, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, FORMAT(sum(click_cnt)/(sum(show_cnt + 0.1)),3) as ctr, FORMAT(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio, sum(union_marker_show) as union_marker_show, sum(union_marker_clk) as union_marker_clk, sum(union_float_show) as union_float_show, round(sum(union_float_show)*1.0/(sum(click_cnt) + 0.01), 5) as union_float_show_ratio, sum(union_float_close) as union_float_close, sum(union_float_input) as union_float_input, sum(union_float_receive) as union_float_receive, sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/ (sum(click_cnt)+0.1),6) as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from  xiao_video where {event_day  [conditions.event_days]} and {author = [conditions.author]} group by author order by zhuanhua DESC, show_cnt DESC;

select event_day, author, vid, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, FORMAT(sum(click_cnt)/(sum(show_cnt + 0.1)),3) as ctr, FORMAT(sum(play_times)/(sum(click_cnt) + 0.1),3) as play_ratio, sum(union_marker_show) as union_marker_show, sum(union_marker_clk) as union_marker_clk, sum(union_float_show) as union_float_show, round(sum(union_float_show)*1.0/(sum(click_cnt) + 0.01), 5) as union_float_show_ratio, sum(union_float_close) as union_float_close, sum(union_float_input) as union_float_input, sum(union_float_receive) as union_float_receive, sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/ (sum(click_cnt)+0.1),6) as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from  xiao_video where {event_day  [conditions.event_days]} and {author = [conditions.author]} and {vid  [conditions.vid]} group by event_day, vid order by event_day desc, zhuanhua DESC, show_cnt DESC;

select event_day, count(event_day) as num_cnt, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, FORMAT(sum(click_cnt)/(sum(show_cnt + 0.1)),3) as ctr, sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/ (sum(click_cnt)+0.1),6) as zhuanhua_ratio from solu_video where {event_day [conditions.event_days]} group by event_day order by event_day desc;

select event_day, count(event_day) as num_cnt, vtype, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, round(sum(click_cnt)/(sum(show_cnt + 0.1)),3) as ctr, sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/ (sum(click_cnt)+0.1),6) as zhuanhua_ratio from solu_video where {event_day [conditions.event_days]} and  {vtype = [conditions.vtype]} group by event_day, vtype order by event_day desc, vtype desc;

select * from solu_video where {event_day [conditions.event_days]} and {vtype = [conditions.vtype]} and {stitle = [conditions.stitle]} order by event_day desc, zhuanhua desc;

select a.event_day, if(count(distinct(a.author)) = 1, a.author, "all") as author, if(count(distinct(b.conv_type)) = 1, if(b.conv_type = 1, '表单', if(b.conv_type = 2, '卡券','非用商')), "all") as conv_type, if(count(distinct(c.hangye)) = 1, c.hangye, "all") as  hangye, count(a.event_day) as num_cnt, if(count(distinct(a.vtype)) = 1, a.vtype, "all") as vtype, sum(a.show_cnt) as show_cnt ,sum(a.click_cnt) as click_cnt, FORMAT(sum(a.click_cnt)/(sum(a.show_cnt + 0.1)),3) as ctr, FORMAT(sum(a.play_times)/(sum(a.click_cnt + 0.1)),3) as play_times_ratio, FORMAT(sum(a.play_all_time)/(sum(a.click_cnt + 0.01)),2) as play_all_time_ratio, FORMAT(sum(a.play_all_time)/(sum(a.click_cnt * b.video_duration) + 0.01),3) as finish_ratio, sum(a.conv_show) as conv_show, sum(a.zhuanhua) as zhuanhua, FORMAT(sum(a.zhuanhua)/ (sum(a.click_cnt)+0.1),6) as zhuanhua_ratio_click, FORMAT(sum(a.zhuanhua)/ (sum(a.conv_show)+0.1),6) as zhuanhua_ratio, sum(a.gmv) as gmv, sum(a.gz) as gz, sum(a.dz) as dz, sum(a.sc) as sc, sum(a.pl) as pl, sum(a.zf) as zf from nid_video as a join all_nid_details as b join mthid_details as c on a.vid = b.nid and b.mthid = c.mthid where {if(b.conv_type = 1, '表单', if(b.conv_type = 2, '卡券', '非用商')) = [conditions.conv_type]} and {c.hangye = [conditions.hangye]} and {a.author = [conditions.author]} and {a.vtype = [conditions.vtype]} and {a.event_day [conditions.event_days]} group by a.event_day order by a.event_day desc;

select a.event_day, if(count(distinct(a.author)) = 1 and a.author !='NONE' or a.author != 0, a.author, "all") as author, if(count(distinct(b.conv_type)) = 1, if(b.conv_type = 1, '表单', if(b.conv_type = 2, '卡券', '非用商')), "all") as conv_type, if(count(distinct(c.hangye)) = 1, c.hangye, "all") as  hangye, sum(a.click) as click_cnt, sum(a.zhuanhua_show) as zhuanhua_show_cnt, round(sum(a.short)/(sum(a.dur_join_scc)+0.0001),3) as short, round(sum(finish_prob)/(sum(dur_join_scc)+0.0001),3) as finish_prob, round(sum(finish_rate)/(sum(dur_join_scc)+0.0001),3) as finish_rate, FORMAT(sum(a.finish_rate * b.video_duration)/(sum(a.dur_join_scc + 0.01)),2) as play_all_time, sum(zhuanhua)as zhuanhua_cnt,FORMAT(sum(zhuanhua)/(sum(click)+0.0001),6) as zhuanhua_rate, if(zhuanhua_show=0, 0, FORMAT(sum(zhuanhua)/(sum(zhuanhua_show)+0.0001),6)) as zhuanhua_rate_conv, sum(dur_join_scc)/(sum(click)+0.0001) as join_rate,sum(like_v)/(sum(click)+0.0001) as like_v, sum(follow)/(sum(click)+0.0001) as follow, sum(share)/(sum(click)+0.0001) as share, sum(comment_view)/(sum(click)+0.0001) as comment_view,sum(dislike)/(sum(click)+0.0001) as dislike from microv_nid_info as a join all_nid_details as b join mthid_details as c on a.nid = b.nid and b.mthid = c.mthid where {if(b.conv_type = 1, '表单', if(b.conv_type = 2, '卡券', '非用商')) = [conditions.conv_type]} and {c.hangye = [conditions.hangye]} and {a.author = [conditions.author]}  and {a.event_day [conditions.event_days]} group by a.event_day order by a.event_day DESC;

select STR_TO_DATE(public_time, '%Y-%m-%d') as event_day, count(distinct mthid) as mthid_num, count(vid) as num, count(if(vtype="短视频", vid, null)) as short_num, count(if(vtype!="短视频", vid, null)) as small_num from vid_video_details group by STR_TO_DATE(public_time, '%Y-%m-%d') order by STR_TO_DATE(public_time, '%Y-%m-%d') desc

select if(mthid != '', author, '-') as author, mthid,  min(public_time) as public_time_min, max(public_time) as public_time_max, count(vid) as num, count(if(del_tag >0 , vid, null)) as del_num,count(if(vtype="短视频", vid, null)) as short_num, count(if(vtype!="短视频", vid, null)) as small_num from vid_video_details where {public_time [conditions.event_days]} and { public_time = [conditions.event_day]} and {author = [conditions.author]} and {mthid = [conditions.mthid]} group by mthid

select if(mthid != '', author, '-') as author, mthid,  min(public_time) as public_time_min, max(public_time) as public_time_max, count(vid) as num, count(if(del_tag >0 , vid, null)) as del_num,count(if(vtype="短视频", vid, null)) as short_num, count(if(vtype!="短视频", vid, null)) as small_num from vid_video_details where {public_time [conditions.event_days]} and { public_time = [conditions.event_day]} and {author = [conditions.author]} and {mthid = [conditions.mthid]} group by mthid

select concat(min(event_day), ' - ', max(event_day)) as event_day, author, sum(show_cnt) as show_cnt , sum(click_cnt) as click_cnt, round(sum(click_cnt)/(sum(show_cnt + 0.1)),3) as ctr, count(distinct if(show_cnt>0, vid, null)) as show_nid_num, count(distinct if(zhuanhua>0, vid, null)) as cvr_nid_num, sum(zhuanhua) as zhuanhua, round(sum(zhuanhua)/ (sum(click_cnt)+0.1),6) as zhuanhua_ratio, sum(gmv) as gmv, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc, sum(pl) as pl, sum(zf) as zf from nid_video where {author = [conditions.author]} and {event_day [conditions.event_days]} group by author order by show_cnt desc;

select concat(min(event_day), ' - ', max(event_day)) as event_day, author,count(distinct if(show_cnt>0, vid, null)) as show_vid_num, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, FORMAT(sum(click_cnt)/(sum(show_cnt) + 0.1),3) as ctr, FORMAT(sum(play_ratio)/(count(click_cnt) + 0.1),3) as play_ratio,sum(solution_show) as solution_show, round(sum(solution_show)/ (sum(click_cnt)+0.01),6)  as solution_show_ratio, sum(h5_show) as h5_show, sum(h5_click) as h5_click, sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/(sum(click_cnt) + 0.1),6) as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from duan_video where {event_day [conditions.event_days]} and {author = [conditions.author]} group by author order by zhuanhua desc, show_cnt desc;

select concat(min(event_day), ' - ', max(event_day)) as event_day, author, stitle, sum(show_cnt) as show_cnt, sum(click_cnt) as click_cnt, round(sum(click_cnt)/ (sum(show_cnt) + 0.1),3) as ctr, sum(solution_show) as solution_show, sum(h5_show) as h5_show, sum(zhuanhua) as zhuanhua, round(sum(zhuanhua)/(sum(click_cnt) + 0.1),5) as zhuanhua_ratio  from duan_all_video where {event_day [conditions.event_days]} and {stitle = [conditions.stitle]} and {author = [conditions.author]} group by stitle order by zhuanhua desc;

select concat(min(event_day), ' - ', max(event_day)) as event_day, author, vid, title, url, sum(show_cnt) as show_cnt ,sum(click_cnt) as click_cnt, FORMAT(sum(click_cnt)/(sum(show_cnt) + 0.1),3) as ctr, FORMAT(sum(play_ratio)/(count(click_cnt) + 0.1),3) as play_ratio,sum(solution_show) as solution_show, sum(h5_show) as h5_show, sum(h5_click) as h5_click, sum(zhuanhua) as zhuanhua, FORMAT(sum(zhuanhua)/(sum(click_cnt) + 0.1),6) as zhuanhua_ratio, sum(gz) as gz, sum(dz) as dz, sum(sc) as sc from duan_all_video where {event_day [conditions.event_days]} and {author = [conditions.author]} group by vid order by zhuanhua desc, show_cnt desc;
