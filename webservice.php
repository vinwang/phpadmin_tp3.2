<?php
// error_reporting(E_ALL);
// ini_set('display_errors', 1);
// 定义应用目录
define('DS', DIRECTORY_SEPARATOR);
define('ROOT_PATH', str_replace('\\','/',dirname(__FILE__)));
define('DATA_PATH', ROOT_PATH.'/Application/Runtime/Data/');
// define('ROS_URI', 'http://'.$_SERVER['HTTP_HOST']);
define('ROS_URI', 'http://127.0.0.1:12315');
require ROOT_PATH . '/ThinkPHP/Library/Com/Nusoap.class.php';
require ROOT_PATH . '/ThinkPHP/Library/Org/Net/Jagent.class.php';

// commandToEu('AQ20200669','fnS063S5ALT6qKTaFTxD','MjY5YWRjNTBhYjNiZmQzMTg4NjA5YmMzM2Y5MmVkNGM=','vd7AzGgk8AO2Ja9I0TJ9NvhHCX7ya0uKaGEmYi+gwTPThMAmrUCQQuY51UH9J/1jphBw+w50zxeqkZx7QHJ1N6ccOiA7TcO02gMiBlvWXbgFJ63++qockNrzclNyN/Jn5w/SaoK2JdQ9tH0wkV3QmsYpMhxtfCpTHloCx4cQ8PMp5QvY6ZUPd4J1+TBAz5aD5zqlyINQp1c98ZDgJZU/EBLwvRSY59KnjTONQ1YegxmF8bI870heq23hkqdwZexerE1dFqoCI9J/qrGmvnuuHfFVJtAUXdT1g1+o7+Rm3DnUPcAlILviijxrwVqp9SPQL1ByxzkVZxG7wD07+iRLRiAs/VcUmT7brlr3imL9gdCxuLtOGFDTCarJUYe5fj2w22bdETbJBsZz2OeL1cLKEyxb3L1QePFykC2GGw1bOp0+ro14tQdrJuPZAPW6NKZr2Drrjed1UgvidRmw+B4K8A==','MDUzZWZhYjA1MmVlYjIzN2JlMWUzZGIzMDk2YTViMWM=',2,1597301846700795830,1,1,1,'v2.0');exit;

$server = new \soap_server();
$server->soap_defencoding = 'UTF-8';
$server->decode_utf8 = false;
$server->xml_encoding = 'UTF-8';

$server->configureWSDL("idcCommand", "");

$server->register(
            //方法名
            "idc_command",
            //输入参数
            array(
                "idcId"=>"xsd:string",
                "randVal"=>"xsd:string",
                "pwdHash"=>"xsd:string",
                "command"=>"xsd:string",
                "commandHash"=>"xsd:string",
                "commandType"=>"xsd:int",
                "commandSequence"=>"xsd:long",
                "encryptAlgorithm"=>"xsd:int",
                "hashAlgorithm"=>"xsd:int",
                "compressionFormat"=>"xsd:int",
                "commandVersion"=>"xsd:string",
            ),
            //输出参数
            array(
            "return"=>"xsd:string",
            ),
            //说明
            "This is idcCommand."
);


// //Use the request to (try to) invoke the service
$HTTP_RAW_POST_DATA = isset($HTTP_RAW_POST_DATA) ? $HTTP_RAW_POST_DATA : file_get_contents('php://input');

$server->service($HTTP_RAW_POST_DATA);

function idc_command($idcId,$randVal,$pwdHash,$command,$commandHash,$commandType,$commandSequence,
        $encryptAlgorithm,$hashAlgorithm,$compressionFormat,$commandVersion){

    // 保存下发参数
    $content  = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
    $content .= "<command_xml>";
    $content .= "<idcId>" . $idcId . "</idcId>";
    $content .= "<randVal>" . $randVal . "</randVal>";
    $content .= "<pwdHash>" . $pwdHash . "</pwdHash>";
    $content .= "<command>" . $command . "</command>";
    $content .= "<commandHash>" . $commandHash . "</commandHash>";
    $content .= "<commandType>" . $commandType . "</commandType>";
    $content .= "<commandSequence>" . $commandSequence . "</commandSequence>";
    $content .= "<encryptAlgorithm>" . $encryptAlgorithm . "</encryptAlgorithm>";
    $content .= "<hashAlgorithm>" . $hashAlgorithm . "</hashAlgorithm>";
    $content .= "<compressionFormat>" . $compressionFormat . "</compressionFormat>";
    $content .= "<commandVersion>" . $commandVersion . "</commandVersion>";
    $content .= "</command_xml>";
    //保存下发的原始xml参数
    $date_str = date('Ymd');
    $save_name = time();
    $save_path = DATA_PATH . "file" . DS . "command_xml" . DS . $date_str . DS;
    $source_file = $save_name . "_src.xml";
   
    file_set($source_file, $content, $save_path);

    $pdo = pdo_mysql();
    $tmp_idc_id = pdo_find("SELECT idcId FROM idc_info WHERE 1", $pdo);
    $idc_id = $tmp_idc_id['idcId'];

    $commandType = json_decode($commandType);
    $add = array(
        'ctype'    => $commandType,
        'filename' => $source_file,
        'filename_de' => $save_name . ".xml",
        'filepath' => $save_path,
        'filesize' => filesize($save_path . $source_file),
        'add_time' => $save_name,
    );
    $file_id = pdo_insert('idc_download_file', $add, $pdo);

    if($idcId == ""){
        return send_message(999, "Must supply a valid idcId.", $commandType,$file_id);
    }

    if ($idc_id != $idcId)
    {
        return send_message(999, "许可证号错误1", $commandType,$file_id);
    }

    if (strlen($randVal) > 20)
    {
        return send_message(999, "随机字符串长度超过20", $commandType,$file_id);
    }

    $sys_conf = file_get(DATA_PATH.'sys_conf.php');

    $auth_key = $sys_conf['news_auth_key'];
    $idc_pwd = $sys_conf['user_pwd'];
    $rand_str = $randVal;
    $pwd_randval = $idc_pwd . $rand_str;

    if ($hashAlgorithm == 1)
    {
        $isms_pwdhash = base64_encode(md5($pwd_randval));
    }
    else if ($hashAlgorithm == 2)
    {
        $isms_pwdhash = base64_encode(sha1($pwd_randval, true));
    }
    else
    {
        $isms_pwdhash = base64_encode($pwd_randval);
    }

    if ($isms_pwdhash != $pwdHash) {
        return send_message(1, "用户认证失败出错", $commandType,$file_id);
    } else {
        $encrypt_key = $sys_conf['encrypt_key'];
        $encrypt_iv = $sys_conf['encrypt_iv'];

        $data_str = "";
        $data = base64_decode($command);

        if($encryptAlgorithm == 1) {
            //aes
            $aes = strlen($encrypt_key) == 16 ? 'aes-128-cbc' : 'aes-256-cbc';
            $data_str = openssl_decrypt($data, $aes, $encrypt_key, true, $encrypt_iv);
        } else {
            $data_str = $data;
        }

        $hash_str = $data_str . $auth_key;

        if ($hashAlgorithm == 1)
        {
            $isms_commandhash = base64_encode(md5($hash_str));
        }
        else if ($hashAlgorithm == 2)
        {
            $isms_commandhash = base64_encode(sha1($hash_str));
        }
        else
        {
            $isms_commandhash = base64_encode($hash_str);
        }
        //commandhash 校验失败
        $decompress_str = "";
        if ($isms_commandhash != $commandHash) {
            return send_message(3, "加密文件校验失败", $commandType);
        } else {
            if ($compressionFormat == 1) {
                //ZIP
                $zipname = 'xml'.time().rand(0,9).'.zip';
                $zip_file = DATA_PATH . 'file' .DS. 'xml' . DS .$zipname;

                file_set($zipname, $data_str, DATA_PATH . 'file' .DS. 'xml' . DS);
                
                $unzip_file = DATA_PATH . 'file' .DS. 'unzip_file'. DS . $save_name . '.xml';
                $unzip_file_path = dirname($unzip_file);
                if(!is_dir($unzip_file_path)) mkdir($unzip_file_path, 0777, true);
                $gunzip_str = "gunzip -c -d $zip_file > $unzip_file";
                exec($gunzip_str, $output, $status);
                // @file_put_contents('gunzip_str_'.date('YmdHis').'.log', $unzip_file_path, FILE_APPEND);
                $decompress_str = file_get_contents($unzip_file);
                @unlink($zip_file);
            } else {
                //none
                $decompress_str = $data_str;
                file_set($save_name . '.xml', $decompress_str,$save_path);
            }

            if(!$decompress_str) {
                return send_message(4, "解压缩失败", $commandType,$file_id);
            }

            //1访问日志查询指令,2信息安全管理指令,4代码表发布指令,5活跃资源上报周期指令,86IP监控段指令下发(移动联通)
            //工信部
            $command_arrtype = array(0, 1, 2, 3, 4, 5, 6);

            if (in_array($commandType, $command_arrtype)) {
                //将收到的命令插入到命令表
                $result = insert_command_table($commandType, $decompress_str, $pdo);
                if(in_array($commandType, [2,4])){
                    //下发到eu
                    commandToEu($idcId,$randVal,$pwdHash,$command,$commandHash,$commandType,$commandSequence,$encryptAlgorithm,$hashAlgorithm,$compressionFormat,$commandVersion,$file_id);
                }
                if ($result) {

                    return $result;
                }
            } else {
                return send_message(999, "接收命令异常[type={$commandType}]", $commandType,$file_id);
            }
            $pdo = null;
            return send_message(0, "操作成功",$commandType,$file_id);
        }
    }
    return send_message(999, "接收命令异常[type={$commandType}]", $commandType,$file_id);
}

function insert_command_table($commandType, $data, $pdo = null)
{
    $tmp_idc_id = pdo_find("SELECT idcId FROM idc_info WHERE 1", $pdo);
    $idc_id = $tmp_idc_id['idcId'];

    // 当为下发信息管理指令时，加大内存，如果是下发5W条指令，防止内存溢出
    if ($commandType == 2)
    {
        ini_set('memory_limit','512M');
    }
    $command_xml = simplexml_load_string($data);

    if ($command_xml === false)
    {
        return send_message(5, "文件格式异常", $commandType);
    }

    // 访问日志查询指令
    if ($commandType == 1 && $command_xml->getName() == 'logQuery')
    {
        if ($idc_id != $command_xml->idcId)
        {
            return send_message(999, "许可证号错误", $commandType);
        }

        $sql_count = "SELECT count(*) AS count FROM idc_logquery WHERE commandid = '{$command_xml->commandId}'";
        $count_tmp = $pdo->query($sql_count);
        $count = $count_tmp->columnCount();

        if ($count > 0)
        {
            return send_message(999, "指令重复下发", $commandType);
        }

        $starttime = strtotime($command_xml->commandInfo->startTime);
        $endtime = strtotime($command_xml->commandInfo->endTime);
        $endtime = $endtime ? $endtime : $starttime + 7200;
        $src_ipv4start_tmp = $command_xml->commandInfo->srcIp->startIp;
        $src_ipv4start = sprintf("%u",ip2long($src_ipv4start_tmp));
        $src_ipv4end_tmp = $command_xml->commandInfo->srcIp->endIp;
        $src_ipv4end = sprintf("%u",ip2long($src_ipv4end_tmp));

        $dst_ipv4start_tmp = $command_xml->commandInfo->destIp->startIp;
        $dst_ipv4start = sprintf("%u",ip2long($dst_ipv4start_tmp));
        $dst_ipv4end_tmp = $command_xml->commandInfo->destIp->endIp;
        $dst_ipv4end = sprintf("%u",ip2long($dst_ipv4end_tmp));

        $src_port = property_exists($command_xml->commandInfo, 'srcPort') ? intval($command_xml->commandInfo->srcPort) : 0;
        $dst_port = property_exists($command_xml->commandInfo, 'dstPort') ? intval($command_xml->commandInfo->dstPort) : 0;

        $protocolType = intval($command_xml->commandInfo->protocolType);

        $url = base64_decode($command_xml->commandInfo->url);

        $sql = "INSERT INTO idc_logquery (commandid, idcid, houseid, starttime, endtime, src_ipv4start, src_ipv4end, dst_ipv4start, dst_ipv4end, src_port, dst_port, protocolType, url, `timestamp`) VALUES ('{$command_xml->commandId}', '{$command_xml->idcId}', '{$command_xml->commandInfo->houseId}', '{$starttime}', '{$endtime}', '{$src_ipv4start}', '{$src_ipv4end}', '{$dst_ipv4start}', '{$dst_ipv4end}', '{$src_port}', '{$dst_port}', '{$protocolType}', '{$url}', '{$command_xml->timeStamp}' )";

        $pdo->exec($sql);

        writeSysLog(130, "下发访问日志查询指令 指令ID：{$command_xml->commandId}", 'SMMS');

        $socket = new \Org\Net\Jagent();

        $socket_result = $socket->send_command_info($command_xml->commandId, $commandType, 0, ROS_URI);
    }

    // 信息安全管理指令
    if ($commandType == 2 && $command_xml->getName() == 'command')
    {
        $commandfileid = 1;
        $timestamp = $command_xml->timeStamp;

        if ($commandfileid)
        {
            $sql_command_file = [
                'commandfileid'=>$commandfileid,
                'timestamp'=>$timestamp
            ];
            pdo_insert('idc_command_fileid', $sql_command_file, $pdo);
        }
        else
        {
            return send_message(999, "指令错误", $commandType);
        }

        $i = $i_rule = $i_house = $i_ack_house = $i_ack = 1;
        $str = $rule_str = $house_str = $ack_house_str = $ack_str = '';
        $command_sql = $rule_sql = $house_sql = $ack_sql_house = $ack_sql = '';

        //$command_list = $command_xml->command;
        // if ($command_xml->command)
        // {
            // foreach ($command_xml->command as $key => $val2)
            // {
                // $houseid .= $val2 . " ";
                // $command_list[]=$val2;
            // }
        // }

        $command_sql_query = "INSERT INTO idc_command (commandfileid, commandid, type, block, reason, log, report, effecttime, expiredtime, idcid, owner, visible, operationtype, add_time) VALUES";
        $rule_sql_query = "INSERT INTO idc_command_rule (commandid, subtype, valuestart, valueend, keywordrange) VALUES ";
        $house_sql_query = "INSERT INTO idc_command_house (commandid, houseid) VALUES ";
        $ack_sql_house_query = "INSERT INTO idc_commandack (commandfileid, idcid, houseid, commandid, type, resultcode, msginfo, add_time) VALUES";
        $ack_sql_query       = "INSERT INTO idc_commandack (commandfileid, idcid, commandid, type, resultcode, msginfo, add_time) VALUES";
        $insert_num = 2000;
        // if ($command_list)
       // {
            // foreach ($command_list as $val)
            //{
                $val = $command_xml;
                $commandid = $val->commandId;

                $operationtype = $val->operationType;
                $type = $val->type;
                // operationType:0 新增, 1 删除
                if ($operationtype == 1)
                {
                    $pdo->exec("DELETE FROM idc_command WHERE commandid = '".$commandid."'");
                    $pdo->exec("DELETE FROM idc_command_house WHERE commandid = '".$commandid."'");
                    $pdo->exec("DELETE FROM idc_command_rule WHERE commandid = '".$commandid."'");
                    writeSysLog(130, "下发信息安全管理指令，删除指令ID {$commandid}", 'SMMS');// 指令ID：{$commandid}
                    $socket = new \Org\Net\Jagent();
                    $socket_result = $socket->send_command_info($commandid, $commandType, $type, ROS_URI);
                }
                else
                {
                    $count_tmp = $pdo->prepare("SELECT count(*) as count FROM idc_command WHERE commandid = '".$commandid."'");
                    // $count = $count_tmp->fetchColumn();

                    // $count_tmp = $pdo->prepare($sql_count);
                    $count_tmp->execute();
                    $tmp_count = $count_tmp->fetch();
                    $count = $tmp_count['count'];


                    if ($count > 0)
                    {
                        $pdo->exec("DELETE FROM idc_command WHERE commandid = '".$commandid."'");
                        $pdo->exec("DELETE FROM idc_command_house WHERE commandid = '".$commandid."'");
                        $pdo->exec("DELETE FROM idc_command_rule WHERE commandid = '".$commandid."'");
                    }
                    $type = $val->type;
                    $block = 0;//$val->action->block;
                    $reason = property_exists($val->action, 'reason') ? $val->action->reason : '';
                    $log = $val->action->log;
                    $report = $val->action->report;
                    $effecttime =  strtotime($val->time->effectTime);
                    $expiredtime =  strtotime($val->time->expiredTime);
                    $idcid =  $val->range->idcId;

                    if ($idc_id != $idcid)
                    {
                        return send_message(999, "许可证号错误", $commandType);
                    }

                    $owner = $val->privilege->owner;
                    $visible = $val->privilege->visible;
                    $add_time = time();

                    $command_sql .= "{$str} ('{$commandfileid}', '{$commandid}', '{$type}', '{$block}', '{$reason}', '{$log}', '{$report}', '{$effecttime}', '{$expiredtime}', '{$idcid}', '{$owner}', '{$visible}', '{$operationtype}', '{$add_time}')";
                    $str = ',';

                    if ($i++ > $insert_num)
                    {
                        $pdo->exec($command_sql_query.$command_sql);
                        $str = $command_sql = '';
                        $i = 1;
                    }
                   
                    if ($val->rule)
                    {
                        $tmpCount = count($val->rule);
                        foreach ($val->rule as $val1)
                        {
                            $subtype = $val1->subtype;
                            $valuestart = $val1->valueStart;
                            $valueend = $val1->valueEnd;
                            if ($val->rule->keywordRange)
                            {
                                $keywordrange = '';
                                foreach ($val1->keywordRange as $val2)
                                {
                                    $keywordrange .= $val2 . " ";
                                }
                            }
                            $keywordrange = rtrim($keywordrange);
                            if($tmpCount > 1){
                                $keywordrange = "0 1 2 3";
                            }

                            $rule_sql .= "{$rule_str} ('{$commandid}', '{$subtype}', '{$valuestart}', '{$valueend}', '{$keywordrange}')";
                            $rule_str = ',';

                            if ($i_rule ++ > $insert_num)
                            {
                                $pdo->exec($rule_sql_query.$rule_sql);
                                $rule_str = $rule_sql = '';
                                $i_rule = 1;
                            }
                        }
                    }
               // }

                $houseId_list =  $val->range->houseId;
                $tmp_pdo = $pdo->query("SELECT * FROM idc_houseinfo WHERE 1");
                $idc_list = $tmp_pdo->fetchAll();

                if ($houseId_list)
                {
                    foreach ($houseId_list as $val3)
                    {

                        $resultcode_str=0;
                        foreach($idc_list as $kk=>$pp){

                          if($pp['houseId']==$val3){
                                if($pp['status'] >= strtotime('-10 minute')){
                                      $resultcode_str=0;
                                }else{
                                      $resultcode_str=2;
                                }
                          }
                        }

                        $house_sql .= "{$house_str} ('{$commandid}', '{$val3}') ";
                        $house_str = ',';

                        if ($i_house ++ > $insert_num)
                        {
                            $pdo->exec($house_sql_query.$house_sql);
                            $house_str = $house_sql = '';
                            $i_house = 1;
                        }

                        $add_time = time();

                        $ack_sql_house .= "{$ack_house_str} ('{$commandfileid}', '{$idc_id}', '{$val3}', '{$commandid}', '{$type}', {$resultcode_str}, '', $add_time)";
                        $ack_house_str = ',';
                        if ($i_ack_house ++ > $insert_num)
                        {
                            $pdo->exec($ack_sql_house_query.$ack_sql_house);
                            $ack_house_str = $ack_sql_house = '';
                            $i_ack_house = 1;
                        }
                    }
                }
                else
                {
                    $resultcode_arr=array();
                    foreach($idc_list as $kk=>$pp){
                          if($pp['status'] >= strtotime('-10 minute')){
                                $resultcode_arr[]=0;
                          }else{
                                $resultcode_arr[]=2;
                          }
                    }
                    $resultcodeint=0;
                    $resultcode_str=0;
                    foreach($resultcode_arr as $kk=>$pp){
                          $resultcodeint=$resultcodeint+$pp;
                    }
                    $totalresult=count($resultcode_arr);
                    if($resultcodeint==($totalresult*2)){
                          $resultcode_str=2;
                    }else if($resultcodeint<($totalresult*2)){
                          $resultcode_str=1;
                    }else if($resultcodeint==0){
                          $resultcode_str=0;
                    }else{
                          $resultcode_str=1;
                    }

                    $add_time = time();
                    $ack_sql .= "{$ack_str} ('{$commandfileid}', '{$idc_id}', '{$commandid}', '{$type}', {$resultcode_str}, '', $add_time)";
                    $ack_str = ',';
                    if ($i_ack ++ > $insert_num)
                    {
                        $pdo->exec($ack_sql_query.$ack_sql);
                        $ack_str = $ack_sql = '';
                        $i_ack = 1;
                    }
                }
           // }

            if ($command_sql)
            {
                $pdo->exec($command_sql_query.$command_sql);
            }

            if ($rule_sql)
            {
                $pdo->exec($rule_sql_query.$rule_sql);
            }

            if ($house_sql)
            {
                $pdo->exec($house_sql_query.$house_sql);
            }

            if ($ack_sql_house)
            {
                $pdo->exec($ack_sql_house_query.$ack_sql_house);
            }

            if ($ack_sql)
            {
                $pdo->exec($ack_sql_query.$ack_sql);
            }

            writeSysLog(130, "下发信息安全管理指令，新增指令ID {$commandid}", 'SMMS');// 指令ID：{$commandid}

            $socket = new \Org\Net\Jagent();
            $socket_result = $socket->send_command_info($commandid, $commandType, $type, ROS_URI);
        }
   }

    // 违法网站列表指令
    if ($commandType == 2 && $command_xml->getName() == 'blacklist')
    {
        writeSysLog(130, "违法网站列表指令 指令ID：{$command_xml->commandId}", 'SMMS');

        // $level = decbin(intval($command_xml->level));
        $level = bindec($command_xml->level);
        $idcId = trim($command_xml->idcId);
        $commandId = trim($command_xml->commandId);
        $subtype = intval($command_xml->type);
        $operationType = intval($command_xml->operationType);
        $add_time = strtotime($command_xml->timeStamp);

        $class_id = ($subtype == 1) ? 73 : 71;
        if ($operationType == 0) {
            $add = [
                'domain' => $command_xml->contents,
                'class_id' => $class_id,
                'level' => $level,
                'state' => 1,
                'log' => 1,
                'source' => 1,
                'user' => 'SMMS',
                'create_time' => $add_time
            ];

            $result = true;
            $info = pdo_find("SELECT count(1) as count FROM idc_blacklist WHERE domain = '".$command_xml->contents."' AND class_id = ".$class_id, $pdo);
            if(!$info['count']) $result = pdo_insert('idc_blacklist', $add, $pdo);
            
            /*$add = array(
                'commandid' => $commandId,
                'idcid' => $idcId,
                'type' => $subtype,
                'contents' => $command_xml->contents,
                'level' => $level,
                'add_time' => $add_time,
            );*/
            
        } else {
            $result = $pdo->exec("DELETE FROM idc_blacklist WHERE class_id = '".$class_id."' AND domain = '".$command_xml->contents."'");
        }
        $time = time();

        $add = array(
            'commandid' => $commandId,
            'idcid' => $idcId,
            'houseid'=>'',
            'type' => 6,
            'resultCode' => 0,
            'msginfo' => '',
            'add_time' => $time,
        );
        pdo_insert('idc_commandack', $add, $pdo);
    }

    // 免过滤网站列表指令
    if ($commandType == 2 && $command_xml->getName() == 'noFilter')
    {
        writeSysLog(130, "免过滤网站列表指令 指令ID：{$command_xml->commandId}", 'SMMS');

        // $level = decbin(intval($command_xml->level));
        $level = bindec($command_xml->level);
        $subtype = intval($command_xml->type);
        $add_time = strtotime($command_xml->timeStamp);

        $class_id = ($subtype == 1) ? 83 : 81;

        // operationType:0 新增, 1 删除
        if ($command_xml->operationType == 0) {
            $add = [
                'domain' => $command_xml->contents,
                'class_id' => $class_id,
                'level' => $level,
                'state' => 1,
                'log' => 1,
                'source' => 1,
                'user' => 'SMMS',
                'create_time' => $add_time
            ];
            $result = true;
            $info = pdo_find("SELECT count(1) as count FROM idc_blacklist WHERE domain = '".$command_xml->contents."' AND class_id = ".$class_id, $pdo);
            if(!$info['count']) $result = pdo_insert('idc_blacklist', $add, $pdo);

        } else {
            $result = $pdo->exec("DELETE FROM idc_blacklist WHERE class_id = '".$class_id."' AND domain = '".$command_xml->contents."'");;
        }

        if ($result === false)
        {
            return send_message(5, "文件格式异常", $commandType);
        }

        $add_time = time();
        $add = array(
            'commandid' => $command_xml->commandId,
            'idcid' => $command_xml->idcId,
            'houseid'=>'',
            'type' => 5,
            'resultcode' => 0,
            'msginfo' => '',
            'add_time' => $add_time,
        );
        pdo_insert('idc_commandack', $add, $pdo);

        $socket = new \Org\Net\Jagent();
        $socket_result = $socket->send_command_info($command_xml->commandId, $commandType,/*2*/ $command_xml->type/*1*/, ROS_URI);
    }

    // 代码表发布指令
    if ($commandType == 4 && $command_xml->getName() == 'codeList')
    {
        //备案属性
        if ($command_xml->basx)
        {
            $basx_list = $command_xml->basx->basxXx;
            if ($basx_list)
            {
                $clear_table = "truncate idc_basx";
                $pdo->exec($clear_table);
                foreach ($basx_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_basx', $sql, $pdo);
                }
            }
        }

        //接入方式
        if ($command_xml->jrfs)
        {
            $jrfs_list = $command_xml->jrfs->jrfsXx;
            if ($jrfs_list)
            {
                $clear_table = "truncate idc_jrfs";
                $pdo->exec($clear_table);
                foreach ($jrfs_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_jrfs', $sql, $pdo);
                }
            }
        }

        //单位属性
        if ($command_xml->dwsx)
        {
            $dwsx_list = $command_xml->dwsx->dwsxXx;
            if ($dwsx_list)
            {
                $clear_table = "truncate idc_dwsx";
                $pdo->exec($clear_table);
                foreach ($dwsx_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_dwsx', $sql, $pdo);
                }
            }
        }

        //证件类型
        if ($command_xml->zjlx)
        {
            $zjlx_list = $command_xml->zjlx->zjlxXx;
            if ($zjlx_list)
            {
                $clear_table = "truncate idc_zjlx";
                $pdo->exec($clear_table);
                foreach ($zjlx_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_zjlx', $sql, $pdo);
                }
            }
        }

        //机房性质
        if ($command_xml->jfxz)
        {
            $jfxz_list = $command_xml->jfxz->jfxzXx;
            if ($jfxz_list)
            {
                $clear_table = "truncate idc_jfxz";
                $pdo->exec($clear_table);
                foreach ($jfxz_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_jfxz', $sql, $pdo);
                }
            }
        }

        //代理类型
        if ($command_xml->dllx)
        {
            $dllx_list = $command_xml->dllx->dllxXx;
            if ($dllx_list)
            {
                $clear_table = "truncate idc_dllx";
                $pdo->exec($clear_table);
                foreach ($dllx_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_dllx', $sql, $pdo);
                }
            }
        }

        //服务内容
        if ($command_xml->fwnr)
        {
            $fwnr_list = $command_xml->fwnr->fwnrXx;
            if ($fwnr_list)
            {
                $clear_table = "truncate idc_fwnr";
                $pdo->exec($clear_table);
                foreach ($fwnr_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $fl = $val->fl;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'fl'=>$fl,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_fwnr', $sql, $pdo);
                }
            }
        }

        //监测过滤规则类型
        if ($command_xml->gzlx)
        {
            $gzlx_list = $command_xml->gzlx->gzlxXx;
            if ($gzlx_list)
            {
                $clear_table = "truncate idc_gzlx";
                $pdo->exec($clear_table);
                foreach ($gzlx_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_gzlx', $sql, $pdo);
                }
            }
        }

        //违法违规情况
        if ($command_xml->wfwgqk)
        {
            $wfwgqk_list = $command_xml->wfwgqk->wfwgqkXx;
            if ($wfwgqk_list)
            {
                $clear_table = "truncate idc_wfwgqk";
                $pdo->exec($clear_table);
                foreach ($wfwgqk_list as $val)
                {
                    $id = $val->id;
                    $mc = $val->mc;
                    $bz = $val->bz;
                    $sfyx = $val->sfyx;
                    $sql = [
                        'id'=>$id,
                        'mc'=>$mc,
                        'bz'=>$bz,
                        'sfyx'=>$sfyx
                    ];
                    pdo_insert('idc_wfwgqk', $sql, $pdo);
                }
            }
        }

        $tmp_pdo = $pdo->query("SELECT * FROM idc_houseinfo WHERE 1");
        $idc_list = $tmp_pdo->fetchAll();

        $resultcode_arr=array();
        foreach($idc_list as $kk=>$pp){
              if($pp['status'] >= strtotime('-10 minute')){
                    $resultcode_arr[]=0;
              }else{
                    $resultcode_arr[]=2;
              }
        }
        $resultcodeint=0;
        $resultcode_str=0;
        foreach($resultcode_arr as $kk=>$pp){
              $resultcodeint=$resultcodeint+$pp;
        }
        $totalresult=count($resultcode_arr);
        if($resultcodeint==($totalresult*2)){
              $resultcode_str=2;
        }else if($resultcodeint<($totalresult*2)){
              $resultcode_str=1;
        }else if($resultcodeint==0){
              $resultcode_str=0;
        }else{
              $resultcode_str=1;
        }
        $commandid = $command_xml->commandId;
        $add_time = time();
        $ack_sql = [
            'idcid'=>$idc_id,
            'houseid'=>'',
            'commandid'=>$commandid,
            'type'=>4,
            'resultcode'=>$resultcode_str,
            'msginfo'=>'',
            'add_time'=>$add_time
        ];
        pdo_insert('idc_commandack', $ack_sql, $pdo);

        writeSysLog(130, "下发代码表发布指令 指令ID：{$commandid}", 'SMMS');

        $socket = new \Org\Net\Jagent();
        $socket_result = $socket->send_command_info($commandid, $commandType, 0, ROS_URI);
    }

    // 基础数据管理指令
    if ($commandType == 5 && $command_xml->getName() == 'idcInfoManage')
    {
        if ($idc_id != $command_xml->commandInfo->idcId)
        {
            return send_message(999, "许可证号错误", $commandType);
        }

        $count_tmp = $pdo->prepare("SELECT count(*) as count FROM idc_infomanage WHERE commandid = '".$command_xml->commandId."'");
        // $count = $count_tmp->fetchColumn();

        // $count_tmp = $pdo->prepare($sql_count);
        $count_tmp->execute();
        $tmp_count = $count_tmp->fetch();
        $count = $tmp_count['count'];

        if ($count > 0)
        {
            $pdo->exec("DELETE FROM idc_infomanage WHERE commandid = '".$command_xml->commandId."'");
        }

        $userid = '';
        if ($command_xml->commandInfo->id)
        {
            foreach ($command_xml->commandInfo->id as $key => $val2)
            {
                $userid .= $val2 . " ";
            }

            $userid = trim($userid);
        }

        $houseid = '';
        if ($command_xml->commandInfo->houseId)
        {
            foreach ($command_xml->commandInfo->houseId as $key => $val2)
            {
                $houseid .= $val2 . " ";
            }

            $houseid = trim($houseid);
        }
        $timeStamp = strtotime($command_xml->timestamp);

        $sql = "INSERT INTO idc_infomanage (commandid, type, querymonitordayfrom, querymonitordayto, idcid, userid, houseid, `add_time`) VALUES ('{$command_xml->commandId}', '{$command_xml->type}', '{$command_xml->commandInfo->queryMonitorDayFrom}', '{$command_xml->commandInfo->queryMonitorDayTo}', '{$command_xml->commandInfo->idcId}', '{$userid}', '{$houseid}', '{$timeStamp}' )";

        $result = $pdo->exec($sql);

        if (!$result)
        {
            return send_message(5, "文件格式异常", $commandType);
        }

        if ($command_xml->type == 1 || $command_xml->type == 2 )
        {
            $tmp_pdo = $pdo->query("SELECT * FROM idc_houseinfo WHERE 1");
            $idc_list = $tmp_pdo->fetchAll();
            $ack_type = 3;
            if ($houseid)
            {
                $houseid_array = explode(" ", $houseid);
                if (!empty($houseid_array) && $result)
                {
                    foreach ($houseid_array as $key => $val)
                    {


                        $resultcode_str=0;
                        foreach($idc_list as $kk=>$pp){

                        if($pp['houseId']==$val){
                              if($pp['status'] >= strtotime('-10 minute')){
                                    $resultcode_str=0;
                              }else{
                                    $resultcode_str=2;
                              }
                              }
                        }


                        $add_time = time();
                        $ack_sql = [
                            'idcid'=>$idc_id,
                            'houseid'=>$val,
                            'commandid'=>$command_xml->commandId,
                            'type'=>$ack_type,
                            'resultcode'=>$resultcode_str,
                            'msginfo'=>'',
                            'add_time'=>$add_time
                        ];
                        pdo_insert('idc_commandack', $ack_sql, $pdo);
                    }
                }
            }
            else
            {
                $resultcode_arr=array();
                foreach($idc_list as $kk=>$pp)
                {
                    if($pp['status'] >= strtotime('-10 minute'))
                    {
                        $resultcode_arr[]=0;
                    }
                    else
                    {
                        $resultcode_arr[]=2;
                    }
                }
                $resultcodeint=0;
                $resultcode_str=0;
                foreach ($resultcode_arr as $kk=>$pp)
                {
                    $resultcodeint=$resultcodeint+$pp;
                }
                $totalresult=count($resultcode_arr);
                if ($resultcodeint==($totalresult*2))
                {
                    $resultcode_str=2;
                }
                else if ($resultcodeint<($totalresult*2))
                {
                    $resultcode_str=1;
                }
                else if ($resultcodeint==0)
                {
                    $resultcode_str=0;
                } else
                {
                    $resultcode_str=1;
                }

                $add_time = time();
                $ack_sql = [
                    'idcid'=>$idc_id,
                    'houseid'=>'',
                    'commandid'=>$command_xml->commandId,
                    'type'=>$ack_type,
                    'resultcode'=>$resultcode_str,
                    'msginfo'=>'',
                    'add_time'=>$add_time
                ];
                pdo_insert('idc_commandack', $ack_sql, $pdo);
            }

            //基数数据监测状态
            file_set('monitorstate', $command_xml->type == 1 ? 1 : 0, DATA_PATH);
        }

        writeSysLog(130, "下发基础数据管理指令 指令ID：{$command_xml->commandId}", 'SMMS');

        $socket = new \Org\Net\Jagent();

        $socket_result = $socket->send_command_info($command_xml->commandId, $commandType, $command_xml->type, ROS_URI);
    }

    // 信息安全管理指令查询指令
    if ($commandType == 6 && $command_xml->getName() == 'commandQuery')
    {
        if ($idc_id != $command_xml->idcId)
        {
            return send_message(999, "许可证号错误", $commandType);
        }

        $commandid = $command_xml->commandId;

        $count_tmp = $pdo->prepare("SELECT count(*) as count FROM idc_commandquery WHERE commandid = '".$commandid."'");
        // $count = $count_tmp->fetchColumn();

        // $count_tmp = $pdo->prepare($sql_count);
        $count_tmp->execute();
        $tmp_count = $count_tmp->fetch();
        $count = $tmp_count['count'];
        if ($count > 0)
        {
            return send_message(999, "指令重复下发", $commandType);
        }

        $add_time = strtotime($command_xml->timeStamp);
        $sql = [
            'commandid'=>$commandid,
            'idcid'=>$idc_id,
            'add_time'=>$add_time
        ];
        pdo_insert('idc_commandquery', $sql);
        if ($command_xml->houseId)
        {
            foreach ($command_xml->houseId as $val)
            {
                $sql1 = [
                    'commandid'=>$commandid,
                    'houseid'=>$val
                ];
                pdo_insert('idc_commandquery_house', $sql1);
            }
        }

        writeSysLog(130, "下发信息安全管理指令查询指令 指令ID：{$commandid}", 'SMMS');

        $socket = new \Org\Net\Jagent();

        $socket_result = $socket->send_command_info($commandid, $commandType, 0, ROS_URI);
    }

    // 活跃资源访问量查询指令
    if ($commandType == 6 && $command_xml->getName() == 'queryView')
    {
        if ($idc_id != $command_xml->idcId)
        {
            return send_message(999, "许可证号错误", $commandType);
        }

        $commandid = $command_xml->commandId;

        $count_tmp = $pdo->prepare("SELECT count(*) as count FROM idc_queryview WHERE commandid = '".$commandid."'");
        // $count = $count_tmp->fetchColumn();

        // $count_tmp = $pdo->prepare($sql_count);
        $count_tmp->execute();
        $tmp_count = $count_tmp->fetch();
        $count = $tmp_count['count'];
        if ($count > 0)
        {
            return send_message(999, "指令重复下发", $commandType);
        }
        $add_time = strtotime($command_xml->timeStamp);
        $sql = "INSERT INTO idc_queryview (`commandid`, `idcid`, `type`, `contents`, `queryTime`, `add_time`) VALUES ".
                "('{$commandid}', '{$idc_id}', '{$command_xml->type}', '{$command_xml->content}', '{$command_xml->queryTime}', '{$add_time}')";
        $pdo->exec($sql);

        $add_time = time();
        $ack_sql = "INSERT INTO idc_commandack (idcid, houseid, commandid, type, resultcode, msginfo, add_time) " .
                   " VALUES ('{$command_xml->idcId}', '', '{$command_xml->commandId}', 7, 0, '', $add_time)";
        $pdo->exec($ack_sql);

        writeSysLog(130, "下发活跃资源访问量查询指令 指令ID：{$commandid}", 'SMMS');

        $socket = new \Org\Net\Jagent();

        $socket_result = $socket->send_command_info($commandid, $commandType, 1, ROS_URI);
    }

    // 违法管理指令执行记录指令
    if ($commandType == 6 && $command_xml->getName() == 'commandRecord')
    {
        if ($idc_id != $command_xml->idcId)
        {
            return send_message(999, "许可证号错误", $commandType);
        }

        $commandid = $command_xml->commandId;

        $count_tmp = $pdo->prepare("SELECT count(*) as count FROM idc_commandrecord WHERE commandid = '".$commandid."'");
        // $count = $count_tmp->fetchColumn();

        // $count_tmp = $pdo->prepare($sql_count);
        $count_tmp->execute();
        $tmp_count = $count_tmp->fetch();
        $count = $tmp_count['count'];
        if ($count > 0)
        {
            return send_message(999, "指令重复下发", $commandType);
        }
        $add_time = strtotime($command_xml->timeStamp);
        $sql = "INSERT INTO idc_commandrecord (`commandid`, `idcid`, `controlsId`, `add_time`) VALUES ".
                "('{$commandid}', '{$idc_id}', '{$command_xml->controlsId}', '{$add_time}')";
        $pdo->exec($sql);

        $add_time = time();
        $ack_sql = "INSERT INTO idc_commandack (idcid, houseid, commandid, type, resultcode, msginfo, add_time) " .
                   " VALUES ('{$command_xml->idcId}', '', '{$command_xml->commandId}', 8, 0, '', $add_time)";
        $pdo->exec($ack_sql);

        writeSysLog(130, "下发违法管理指令执行记录指令 指令ID：{$commandid}", 'SMMS');

        $socket = new \Org\Net\Jagent();

        $socket_result = $socket->send_command_info($commandid, $commandType, 2, ROS_URI);
    }
}

function send_message($resultcode, $msg, $commandType = '',$file_id=0)
{
    /*
         返回状态: 0 -无错误操作成功:
        1 -用户认证失败出错;
        2 -解密失败:
        3 -文件校验失败:
        4 -解压缩失败:
        5 -文件格式异常;
        6 -文件内容异常:
        999 -其他错误
    */
    if ($resultcode != 0)
    {
        $commandType_arr = array(
            0 => '下发基础数据管理指令',
            1 => '下发访问日志查询指令',
            2 => '下发信息安全管理指令',
            3 => '保留',
            4 => '下发代码表发布指令',
            5 => '下发基础数据查询指令',
            6 => '下发信息安全管理指令查询指令',
        );
        writeSysLog(130, "{$commandType_arr[$commandType]} {$msg}", 'SMMS');
    }
    if ($file_id != 0)
    {
        $pdo = pdo_mysql();
        $pdo->exec("UPDATE idc_download_file SET resultcode = '".$resultcode."', content = '".$commandType_arr[$commandType].$msg."' WHERE id = ".$file_id);
        $pdo = null;
    }
    $return = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><return><resultCode>$resultcode</resultCode><msg>$msg</msg></return>";

    return $return;
}

/**
 * 下发到eu
 * @param  [type] $idcId             [description]
 * @param  [type] $randVal           [description]
 * @param  [type] $pwdHash           [description]
 * @param  [type] $command           [description]
 * @param  [type] $commandHash       [description]
 * @param  [type] $commandType       [description]
 * @param  [type] $commandSequence   [description]
 * @param  [type] $encryptAlgorithm  [description]
 * @param  [type] $hashAlgorithm     [description]
 * @param  [type] $compressionFormat [description]
 * @param  [type] $commandVersion    [description]
 * @return [type]                    [description]
 */
function commandToEu($idcId,$randVal,$pwdHash,$command,$commandHash,$commandType,$commandSequence,
        $encryptAlgorithm,$hashAlgorithm,$compressionFormat,$commandVersion,$file_id = 0){
    $pdo = pdo_mysql();
    $query = $pdo->prepare("SELECT spotId,spotIp,wsdlUrl,passwd,encryptAlgorithm,AESKey,AESOffset,hashAlgorithm,compressionFormat,authenticationkey,com_version FROM idc_server WHERE 1");
    $query->execute();
    $euList = $query->fetchAll();

    if($euList){
        foreach($euList as $key=>$val){
            $syncLog = [];
            $syncLog['euId'] = $val['spotId'];
            $syncLog['syncType'] = 4;
            $syncLog['syncTime'] = time();
            try{
                $client = new \nusoap_client($val['wsdlUrl']);
                $client->decode_utf8 = false;
                $client->xml_encoding = 'UTF-8';
                $params = [
                    'idcId' => $idcId,
                    'randVal' => $randVal,
                    'pwdHash' => $pwdHash,
                    'command' => $command,
                    'commandHash' => $commandHash,
                    'commandType' => $commandType,
                    'commandSequence' => $commandSequence,
                    'encryptAlgorithm' => $encryptAlgorithm,
                    'hashAlgorithm' => $hashAlgorithm,
                    'compressionFormat' => $compressionFormat,
                    'commandVersion' => $commandVersion
                ];
                $return = $client->call('idc_command', $params);

                $syncLog['syncStatus'] = 1;
                $syncLog['fileId'] = $file_id ?: 0;

                $tmpMsg = $commandType == 2 ? '信息安全管理指令' : '代码表发布指令';
                $tmpMsg = $tmpMsg . ',' . htmlspecialchars($return);
                $syncLog['syncMsg'] = $tmpMsg;
            }
            catch(\SoapFault $e){
                $syncLog['syncStatus'] = 0;
                $syncLog['syncMsg'] = $e->faultstring;
            }
            pdo_insert('idc_synclogs', $syncLog);
        }

    }
}

function trimEnd($text){
    $len = strlen($text);
    $c = $text[$len-1];
    if(ord($c) <$len){
        for($i=$len-ord($c); $i<$len; $i++){
            if($text[$i] != $c){
                return $text;
            }
        }
        return substr($text, 0, $len-ord($c));
    }
    return $text;
}

/**
 * 实例化pdo
 * @return [type] [description]
 */
function pdo_mysql(){
    $config = require ROOT_PATH . '/Application/Common/Conf/config.php';
    $dns = $config['DB_TYPE'] . ':host='.$config['DB_HOST'].';dbname='.$config['DB_NAME'].';port='.$config['DB_PORT'];
    try{
        $db = new PDO($dns, $config['DB_USER'], $config['DB_PWD'], [PDO::ATTR_PERSISTENT => true, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);

        return $db;
    }
    catch(PDOException $e){
        throw new Exception($e->getMessage(), 1);
        die();
    }
}

/**
 * 查询一条数据
 * @param  string $sql [description]
 * @param  [type] $pdo [description]
 * @return [type]      [description]
 */
function pdo_find($sql = '', $pdo = null){
    $new = 0;
    if(!$sql) return false;
    if(!$pdo){
        $new = 1;
        $pdo = pdo_mysql();
    }

    $pre = $pdo->prepare($sql);
    $pre->execute();

    $row = $pre->fetch();
    unset($pre);
    if($new){
        $pdo = null;
    }
    return $row;
}

/**
 * 插入
 * @param  string $table [description]
 * @param  [type] $data  [description]
 * @param  [type] $pdo   [description]
 * @return [type]        [description]
 */
function pdo_insert($table = '', $data = null, $pdo = null){
    $new = 0;
    if(!$table || !$data) return false;
    if(!$pdo){
        $new = 1;
        $pdo = pdo_mysql();
    }

    $keys = [];
    $values = [];
    foreach($data as $key=>$val){
        $keys[] = $key;
        $values[] = $val;
    }
    $tmp_key = " (".implode(',', $keys).")";
    $tmp_value = "('".implode('\',\'', $values)."')";

    $sql = "INSERT INTO ".$table.$tmp_key." VALUES ".$tmp_value;
    $ct = $pdo->exec($sql);

    // $err = $pdo->errorinfo();
    $last_id = $pdo->lastInsertId();
    unset($tmp_pdo);
    if($new){
        $pdo = null;
    }
    
    return $last_id;
}


function writeSysLog($model, $logdes, $uname)
{
    $set = array(
        'model'      => $model,
        'logdes'     => $logdes,
        'logcmd'     => '',
        'uid'         => 1,
        'urid'        => 1,
        'uname'        => $uname,
        'ulogipv4'     => '2130706433',
        'add_time'    => time()
    );

    pdo_insert('sys_log', $set);
}

/**
 * 读取缓存
 * @access public
 * @param string $name 缓存变量名
 * @return mixed
 */
function file_get($filename) {
    if (!is_file($filename)) {
       return false;
    }
    $content    =   file_get_contents($filename);
    if( false !== $content) {
        
        $content    =   unserialize($content);
        return $content;
    }
    else {
        return false;
    }
}

/**
 * 写入文件
 * @param [type] $name   [description]
 * @param [type] $value  [description]
 * @param [type] $expire [description]
 */
function file_set($name,$value,$dir = './') {
    if(!is_dir($dir)) {
        mkdir($dir,0777,true);
    }
    $filename = $dir . $name;
    // $data   =   serialize($value);
    $data = $value;
    // $result  =   file_put_contents($filename,$data);
    if($fp = fopen($filename, 'w')) {
        flock($fp, 2);
        fwrite($fp, $data);
        fclose($fp);
        return true;
    }
    else{
        return false;
    }
}