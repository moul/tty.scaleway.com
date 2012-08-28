
CREATE DATABASE `ssh_accounts`;
USE `ssh_accounts`;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `uid` int(5) unsigned NOT NULL,
  `login` varchar(20) NOT NULL,
  `pass` varchar(30) NOT NULL,
  `blade_ip` varchar(15) NOT NULL,
  `port` int(5) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE USER ssh IDENTIFIED BY 'sraL89qr43pz';
GRANT SELECT ON ssh_accounts.t_user TO 'ssh'@'%';

INSERT t_user VALUES(2000, 's1', ENCRYPT('p'), 'localhost', 1000);
INSERT t_user VALUES(2001, 's2', ENCRYPT('p'), 'localhost', 1001);
