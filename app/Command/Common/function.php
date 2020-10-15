<?php
//将char32地址转换成v6
function char2ipv6($ipv6_char){
    if (strlen($ipv6_char) == 32)
    {
        $ipv6_tmp = inet_ntop(inet_pton(substr(chunk_split($ipv6_char, 4, ':'), 0, -1)));
        return strtoupper($ipv6_tmp);
    }
    else
    {
        return false;
    }
}

// XSD对比
function xmlXsdCheck($xml_body, $filename){
    $xsdFile = APP_CONFIG_PATH.'xsd/'.$filename;
    $xsd_check = xmlCheck($xml_body, $xsdFile);
    if ($xsd_check === false)
    {
    	FW(time().'.xml', $xml_body,  DATA_PATH . 'xsd_error' . DS);
        return $xml_body;
    }
    return true;
}

//判断指定xml文件是否符合指定xsd文件格式
function xmlCheck($xmlFile, $xsdFile){
    libxml_use_internal_errors(true);
    $xml = new DOMDocument('1.0', 'utf8');
    if (@is_file($xmlFile)) { //加载xml文件
        $xml->load($xmlFile);
    } else { //加载xml字符串
        $xml->loadXML($xmlFile);
    }

    if (!$xml->schemaValidate($xsdFile)) {
        libxml_display_errors(); //抛出错误调试的时候用
        return false;
    } else {
        return true;
    }
}

//抛出xml错误
function libxml_display_errors(){
    $errors = libxml_get_errors();
    $time = time();
    foreach ($errors as $error) {
        echo libxml_display_error($error);

        F($time, libxml_display_error($error), DATA_PATH . 'xsd_error' . DS);
    }
    libxml_clear_errors();
}

//抛出xml错误
function libxml_display_error($error){
    $return = "<br/>\n";
    switch ($error->level) {
        case LIBXML_ERR_WARNING:
            $return .= "<b>Warning $error->code</b>: ";
            break;
        case LIBXML_ERR_ERROR:
            $return .= "<b>Error $error->code</b>: ";
            break;
        case LIBXML_ERR_FATAL:
            $return .= "<b>Fatal Error $error->code</b>: ";
            break;
    }
    $return .= trim($error->message);
    if ($error->file) {
        $return .= " in <b>$error->file</b>";
    }
    $return .= " on line <b>$error->line</b>\n";
    return $return;
}



/**
 * ftp 连接
 * @return [type] [description]
 */
function get_ftp_conn_id($ftp_server = '', $ftp_port = '', $ftp_user_name = '', $ftp_user_pass = '', $ftp_folder = '')
{
    $info_list = F('sys_conf');
    $ftp_info = $info_list ? $info_list : array();

    $ftp_server = $ftp_server ?: $ftp_info['ftp_server'];
    $ftp_user_name = $ftp_user_name ?: $ftp_info['ftp_uname'];
    $ftp_user_pass = $ftp_user_pass ?: $ftp_info['ftp_pwd'];
    $ftp_folder = $ftp_folder ?: $ftp_info['ftp_folder'];
    $ftp_port = $ftp_port ?: $ftp_info['ftp_port'];
    // set up basic connection
    $conn_id = ftp_connect($ftp_server, $ftp_port);

    // login with username and password
    $login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);

    // check connection
    if(!$conn_id){
        return 1;
    }
    if(!$login_result){
        return 2;
    }

    ftp_pasv($conn_id, true);
    $ftp_folder_arr = explode('/', $ftp_folder);

    foreach ($ftp_folder_arr as $key => $value)
    {
        if ($value)
        {
            if (!@ftp_chdir($conn_id, $value))
            {
                @ftp_mkdir($conn_id, $value);
                @ftp_chdir($conn_id, $value);
            }
        }
    }

    return $conn_id;
}


/**
 * ftp 连接
 * @return [type] [description]
 */
function get_ftp_conn_id_url()
{
    $info_list = F('sys_conf');
    $ftp_info = $info_list ? $info_list : array();

    $ftp_server = $ftp_info['ftp_url_server'];
    $ftp_user_name = $ftp_info['ftp_uname'];
    $ftp_user_pass = $ftp_info['ftp_pwd'];
    $ftp_folder = $ftp_info['ftp_folder'];
    // set up basic connection
    $conn_id = ftp_connect($ftp_server, $ftp_info['ftp_port']);

    // login with username and password
    $login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);

    // check connection
    if ((!$conn_id) || (!$login_result)) {
        $msg = "FTP connection has failed! Attempted to connect to $ftp_server for user $ftp_user_name";
        if(IS_AJAX){
            ajaxResponse(1, $msg);
        }
        else{
            E($msg);
        }
    }
    ftp_pasv($conn_id, true);
    $ftp_folder_arr = explode('/', $ftp_folder);

    foreach ($ftp_folder_arr as $key => $value)
    {
        if ($value)
        {
            if (!@ftp_chdir($conn_id, $value))
            {
                @ftp_mkdir($conn_id, $value);
                @ftp_chdir($conn_id, $value);
            }
        }
    }

    return $conn_id;
}