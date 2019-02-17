use ansible;
GO
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
-- Table structure for table `fact_data`
--

DROP TABLE IF EXISTS [fact_data];
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fact_data (
  [host_id] int NOT NULL,
  [fact_id] int NOT NULL,
  [value] varchar(max),
  PRIMARY KEY ([host_id],[fact_id])
) ;

CREATE INDEX [fact_id] ON fact_data ([fact_id]);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facts`
--

DROP TABLE IF EXISTS [facts];
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE facts (
  [id] int NOT NULL IDENTITY,
  [fact] varchar(255) DEFAULT NULL,
  PRIMARY KEY ([id]),
  CONSTRAINT [fact] UNIQUE  ([fact])
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS [hosts];
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE hosts (
  [id] int NOT NULL IDENTITY,
  [host] varchar(255) DEFAULT NULL,
  [last_seen] datetime2(0) DEFAULT NULL,
  PRIMARY KEY ([id]),
  CONSTRAINT [fqdn] UNIQUE  ([host])
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playbook_log`
--

DROP TABLE IF EXISTS [playbook_log];
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE playbook_log (
  [id] int NOT NULL IDENTITY,
  [host_pattern] varchar(255) DEFAULT NULL,
  [start] datetime2(0) DEFAULT NULL,
  [end] datetime2(0) DEFAULT NULL,
  [running] smallint NOT NULL DEFAULT '0',
  PRIMARY KEY ([id])
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_log`
--

DROP TABLE IF EXISTS [task_log];
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE task_log (
  [id] int NOT NULL IDENTITY,
  [playbook_id] int NOT NULL,
  [name] varchar(255) DEFAULT NULL,
  [start] datetime2(0) DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [fk_playbook] FOREIGN KEY ([playbook_id]) REFERENCES playbook_log ([id]) ON DELETE CASCADE
) ;

--
-- Table structure for table `runner_log`
--

DROP TABLE IF EXISTS [runner_log];
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE runner_log (
  [id] int NOT NULL IDENTITY,
  [host_id] int NOT NULL,
  [task_id] int NOT NULL,
  [delegate_host] varchar(255) DEFAULT NULL,
  [module] varchar(max),
  [changed] smallint DEFAULT NULL,
  [start] datetime2(0) DEFAULT NULL,
  [extra_info] varchar(max),
  [ok] smallint NOT NULL DEFAULT '1',
  [unreachable] smallint DEFAULT '0',
  [skipped] smallint DEFAULT '0',
  [fail_msg] varchar(max),
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [fk_task] FOREIGN KEY ([task_id]) REFERENCES task_log ([id]) ON DELETE CASCADE
) ;

CREATE INDEX [host_id] ON runner_log ([host_id]);
CREATE INDEX [fk_task] ON runner_log ([task_id]);
/*!40101 SET character_set_client = @saved_cs_client */;


CREATE INDEX [fk_playbook] ON task_log ([playbook_id]);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
GO
