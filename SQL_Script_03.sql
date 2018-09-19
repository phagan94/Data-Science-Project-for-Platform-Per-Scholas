USE CDW_SAPP;
-- DROP TABLE IF EXISTS `cdw_sapp_creditcard`;
-- DROP TABLE IF EXISTS `cdw_sapp_customer`;
-- DROP TABLE IF EXISTS `cdw_sapp_branch`;

DROP TABLE IF EXISTS `CDW_SAPP_D_TIME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CDW_SAPP_D_TIME` (
  `TIME_TIME_ID` varchar(8) NOT NULL,
  `TIME_DAY` int(2) zerofill NULL,
  `TIME_MONTH` int(2) zerofill NULL,
  `TIME_QUARTER` varchar(8) NOT NULL,
  `TIME_YEAR` int(4) zerofill NULL,
  PRIMARY KEY (`TIME_TIME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `CDW_SAPP_BRANCH`
--

LOCK TABLES `CDW_SAPP_D_TIME` WRITE, `CDW_SAPP_CREDITCARD` AS CC READ;
/*!40000 ALTER TABLE `CDW_SAPP_D_TIME` DISABLE KEYS */;
INSERT INTO `CDW_SAPP_D_TIME` (TIME_TIME_ID, TIME_DAY, TIME_MONTH, TIME_QUARTER, TIME_YEAR)
 SELECT DISTINCT(CONCAT(CC.YEAR, LPAD(CC.MONTH, 2, 0), LPAD(CC.DAY, 2, 0))) AS TIMEID, 
   CC.DAY, 
   CC.MONTH, 
   (concat(CC.YEAR, 
     (case 
        when CC.MONTH in (1, 2, 3) then '0331'
        when CC.MONTH in (4, 5, 6) then '0631'
        when CC.MONTH in (7, 8, 9) then '0930'
        else '1231'
      end)
    )
   ), 
   CC.YEAR
   FROM CDW_SAPP_CREDITCARD CC
   ORDER BY TIMEID
   ;
UNLOCK TABLES;

