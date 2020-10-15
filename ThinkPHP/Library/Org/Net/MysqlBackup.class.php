<?php
namespace Org\Net;

class MysqlBackup{
    private $ds = "\r\n"; //换行符
    private $sqlEnd = ";"; //没调sql语句的结尾符

    public function __construct(){
        $this->dbhost = C('DB_HOST');
        $this->dbuser = C('DB_USER');
        $this->dbpw = C('DB_PWD');
        $this->dbname = C('DB_NAME');      
    }
	/**
     * getTables 获取数据库表列表
     * @return array $tables      返回结果数组    
     */
    public function getTables() {
        $M = M();
        $res = $M->query ( "SHOW TABLES;" );
        $tables = array ();
        foreach ( $res as $row ) {
            
            foreach ($row as $v){
                $tables[]=$v;
            }
        }
        return $tables;
    }
    
     /**
     * 插入数据库备份基础信息
     *
     * @return string
     */
    public function _base() {
        $res = M()->query('select VERSION()');
        $value = '';
        $value .= '-- MySQL database dump' . $this->ds; 
        $value .= '--' . $this->ds;
        $value .= '-- 主机: ' . $this->host . $this->ds;
        $value .= '-- 生成日期: ' . date ( 'Y' ) . ' 年  ' . date ( 'm' ) . ' 月 ' . date ( 'd' ) . ' 日 ' . date ( 'H:i' ) . $this->ds;
        $value .= '-- MySQL版本: ' . $res . $this->ds;
        $value .= '-- PHP 版本: ' . phpversion () . $this->ds;
        $value .= $this->ds;
        $value .= '--' . $this->ds;
        $value .= '-- 数据库: `' . C("DB_NAME") . '`'. $this->ds;
        $value .= '--' . $this->ds ;
        $value .= '-- -------------------------------------------------------';
        $value .= $this->ds . $this->ds;

        return $value;
    }

    /**
     * 插入语句构造
     *
     * @param string $table                     
     * @return string
     */
    public function _insert_record($table) {
        // sql字段逗号分割
        $M=M();
        $res = $M->query ( 'select * FROM `' . $table . '`' );    
        // 循环每个子段下面的内容
        foreach ($res as $val){
            $comma = 0;
            $insert .= "INSERT INTO `" . $table . "` VALUES(";
            foreach ($val as $v){
                $insert.=$comma == 0 ? "" : ",";
                $insert.= ( "'" .  addslashes ( $v ) . "'");
                $comma++;
            }
            $insert .= ");" . $this->ds;
            
        } 
        return $insert;
    }

    /**
     * 插入表结构
     *
     * @param unknown_type $table            
     * @return string
     */
    public function _insert_table_structure($table) {
        $sql = '';
        $sql .= "--" . $this->ds;
        $sql .= "-- 表的结构" . $table .$this->ds."--" .$this->ds;
        $M = M();
        // 如果存在则删除表
        $sql .= "DROP TABLE IF EXISTS `" . $table . '`' . $this->sqlEnd . $this->ds;
        // 获取详细表信息
        $res = $M->query ( 'SHOW CREATE TABLE `' . $table . '`' );
        $sql .= $res [0]["create table"];
        $sql .= $this->sqlEnd . $this->ds;
        // 加上
        $sql .= $this->ds;
        $sql .= "--" . $this->ds;
        $sql .= "-- 转存表中的数据 " . $table . $this->ds;
        $sql .= "--" . $this->ds;
        $sql .= $this->ds;
        return $sql;
    }

    /**
     * 写入文件
     *
     * @param string $sql            
     * @param string $filename            
     * @param string $dir            
     * @return boolean
     */
    public function _write_file($sql, $filename, $dir) {
          // $dir = C("DB_BACKUP");

        // 创建目录
        if (! is_dir ( $dir )) {
            mkdir ( $dir, 0777, true );
        }
        $re = true;
        $msg = '';
        /*if (! @$fp = gzopen ( $dir . $filename, "w9" )) {
            $re = false;
            $msg .= "打开文件失败！";
        }

        if (! @gzwrite ( $fp, $sql )) {
            $re = false;
            $msg .= "写入文件失败，请文件是否可写";
        }
        if (! @gzclose ( $fp )) {
            $re = false;
            $msg .= "关闭文件失败！";
        }*/
        $fp = @fopen($dir . $filename, 'w+');
        if(@fwrite($fp, $sql) === false){
            $re = false;
            $msg .= '写入文件失败，请文件是否可写';
        }
        @fclose($fp);

        return $re;
    }

    /**
     * 数据恢复
     * @param  string $filename [description]
     * @return [type]           [description]
     */
    public function recovery($filename = ''){
        if(is_file($filename) === false){
            return false;
        }
        $handle = @fopen($filename, "r");
        $tmp_sql = '';
        if ($handle) {
            while (!feof($handle)) {
                $buffer = fgets($handle);
                if (trim($buffer) != ''){
                    $tmp_sql .= $buffer;
                    if (substr(rtrim($buffer),-1) == ';'){
                        if (preg_match('/(CREATE|ALTER|DROP)\s+(VIEW|TABLE|DATABASE|SCHEMA)\s+/i', ltrim($tmp_sql))){
                            //标准的SQL语句，将被执行
                        }else if (preg_match('/(INSERT)\s+(INTO)\s+/i', ltrim($tmp_sql)) && substr(rtrim($buffer),-2) == ');'){
                            //标准的SQL语句，将被执行
                        }else if (preg_match('/(SET)\s+SQL_MODE=/i', ltrim($tmp_sql))){
                            //SET SQL_MODE 设置，将被执行
                        }else{
                            //不能组成标准的SQL语句，继续向下一行取内容，直到组成合法的SQL为止
                            continue;
                        }
                        if (!empty($tmp_sql)){
                            M()->execute($tmp_sql);
                            unset($tmp_sql);
                        }
                    }
                }
            }
            @fclose($handle);
            return true;
        }
        return false;
    }
}