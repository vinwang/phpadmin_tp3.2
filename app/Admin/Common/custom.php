<?php
/**
 * 验证用户非法用户名
 * @param  [type] $username [description]
 * @return [type]           [description]
 */
function checkUsernameFormat($username) {
	$guestexp = '\xA1\xA1|\xAC\xA3|^\xD3\xCE\xBF\xCD|\xB9\x43\xAB\xC8'; //|^Guest
	$len = strlen($username);
	if ($len > 18 || $len < 4 || !preg_match('/^[a-zA-Z][a-zA-Z0-9\_]{3,17}$/', $username) || preg_match("/\s+|\\\\|^c:\\con\\con|[%,\*\"\s\<\>\&]|$guestexp/is", $username)) {
		return false;
	}
	return true;
}

//写日志
function writeAppLog($model, $logdes = '', $logcmd = '', &$db = null, $userinfo = array()) {
	
    $admin_id = session('admin_id');
    $admin_rid = session('admin_rid');
	$admin_name = session('admin_name');
	if ($userinfo) {
		$uid = $userinfo['uid'];
		$urid = $userinfo['rid'];
		$uname = $userinfo['uname'];
		$ulogipv4 = sprintf("%u", ip2long($userinfo['ulogipv4']));
	} else {
		$uid = $admin_id;
		$urid = $admin_rid;
		$uname = $admin_name;
		$ulogipv4 = sprintf("%u", ip2long(getonlineip()));
	}

	$logdes = str_replace(',', '，', $logdes);
	$set = array(
		'model' => $model,
		'logdes' => $logdes,
		'logcmd' => $logcmd,
		'uid' => $uid,
		'urid' => $urid,
		'uname' => $uname,
		'ulogipv4' => $ulogipv4,
		'add_time' => time(),
	);
	if (isset($admin_name) && !empty($admin_name)) {
		return M('sys_log')->add($set);
	}
}

function is_ipv4($ip)
{
    $preg="/\A((([0-9]?[0-9])|(1[0-9]{2})|(2[0-4][0-9])|(25[0-5]))\.){3}(([0-9]?[0-9])|(1[0-9]{2})|(2[0-4][0-9])|(25[0-5]))\Z/";
    if(preg_match($preg,$ip))
    {
        return true;
    }
    return false;
}

function is_ipv6($IPv6)
{
    if (preg_match('/\A
    (?:
    (?:
    (?:[a-f0-9]{1,4}:){6}
    |
    ::(?:[a-f0-9]{1,4}:){5}
    |
    (?:[a-f0-9]{1,4})?::(?:[a-f0-9]{1,4}:){4}
    |
    (?:(?:[a-f0-9]{1,4}:){0,1}[a-f0-9]{1,4})?::(?:[a-f0-9]{1,4}:){3}
    |
    (?:(?:[a-f0-9]{1,4}:){0,2}[a-f0-9]{1,4})?::(?:[a-f0-9]{1,4}:){2}
    |
    (?:(?:[a-f0-9]{1,4}:){0,3}[a-f0-9]{1,4})?::[a-f0-9]{1,4}:
    |
    (?:(?:[a-f0-9]{1,4}:){0,4}[a-f0-9]{1,4})?::
    )
    (?:
    [a-f0-9]{1,4}:[a-f0-9]{1,4}
    |
    (?:(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.){3}
    (?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])
    )
    |
    (?:
    (?:(?:[a-f0-9]{1,4}:){0,5}[a-f0-9]{1,4})?::[a-f0-9]{1,4}
    |
    (?:(?:[a-f0-9]{1,4}:){0,6}[a-f0-9]{1,4})?::
    )
    )\Z/ix',
    $IPv6
    ))
    {
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * 域名正则
 * @param  [type]  $phone [description]
 * @return boolean        [description]
 */
function is_domain($domain) {
    if (!preg_match('/^([\w-]+\.)+((ac)|(ac\.cn)|(ad)|(ae)|(aero)|(af)|(ag)|(ah\.cn)|(ai)|(al)|(am)|(an)|(ao)|(aq)|(ar)|(arpa)|(as)|(asia)|(at)|(au)|(aw)|(ax)|(az)|(ba)|(bb)|(bd)|(be)|(bf)|(bg)|(bh)|(bi)|(biz)|(bj)|(bj\.cn)|(bm)|(bn)|(bo)|(br)|(bs)|(bt)|(bv)|(bw)|(by)|(bz)|(ca)|(cat)|(cc)|(cd)|(cf)|(cg)|(ch)|(ci)|(ck)|(cl)|(cm)|(cn)|(cn\.com)|(co)|(co\.jp)|(co\.kr)|(com)|(com\.au)|(com\.cn)|(com\.hk)|(com\.nz)|(com\.sg)|(com\.tw)|(com\.vn)|(co\.nz)|(coop)|(co\.uk)|(co\.za)|(cq\.cn)|(cr)|(cu)|(cv)|(cx)|(cy)|(cz)|(de)|(dj)|(dk)|(dm)|(do)|(dz)|(ec)|(edu)|(edu\.cn)|(edu\.hk)|(edu\.mo)|(ee)|(eg)|(er)|(es)|(et)|(eu)|(fi)|(fj)|(fj\.cn)|(fk)|(fm)|(fo)|(fr)|(ga)|(gb)|(gd)|(gd\.cn)|(ge)|(gf)|(gg)|(gh)|(gi)|(gl)|(gm)|(gn)|(gov)|(gov\.cn)|(gp)|(gq)|(gr)|(gs)|(gs\.cn)|(gt)|(gu)|(gw)|(gx\.cn)|(gy)|(gz\.cn)|(ha\.cn)|(hb\.cn)|(he\.cn)|(hi\.cn)|(hk)|(hk\.cn)|(hl\.cn)|(hm)|(hn)|(hn\.cn)|(hr)|(ht)|(hu)|(id)|(ie)|(il)|(im)|(in)|(info)|(int)|(io)|(iq)|(ir)|(is)|(it)|(je)|(jl\.cn)|(jm)|(jo)|(jobs)|(jp)|(js\.cn)|(jx\.cn)|(ke)|(kg)|(kh)|(ki)|(km)|(kn)|(kp)|(kr)|(kw)|(ky)|(kz)|(la)|(lb)|(lc)|(li)|(lk)|(ln\.cn)|(lr)|(ls)|(lt)|(lu)|(lv)|(ly)|(ma)|(mc)|(md)|(me)|(mg)|(mh)|(mil)|(mil\.cn)|(mk)|(ml)|(mm)|(mn)|(mo)|(mobi)|(mo\.cn)|(mp)|(mq)|(mr)|(ms)|(mt)|(mu)|(museum)|(mv)|(mw)|(mx)|(my)|(mz)|(na)|(name)|(nc)|(ne)|(net)|(net\.au)|(net\.cn)|(net\.ru)|(nf)|(ng)|(ni)|(nl)|(nm\.cn)|(no)|(np)|(nr)|(nu)|(nx\.cn)|(nz)|(om)|(org)|(org\.au)|(org\.cn)|(org\.ru)|(org\.uk)|(or\.kr)|(pa)|(pe)|(pf)|(pg)|(ph)|(pk)|(pl)|(pm)|(pn)|(pr)|(pro)|(ps)|(pt)|(pw)|(py)|(qa)|(qh\.cn)|(re)|(ro)|(rs)|(ru)|(rw)|(sa)|(sb)|(sc)|(sc\.cn)|(sd)|(sd\.cn)|(se)|(sg)|(sh)|(sh\.cn)|(si)|(sj)|(sk)|(sl)|(sm)|(sn)|(sn\.cn)|(so)|(sr)|(st)|(su)|(sv)|(sx\.cn)|(sy)|(sz)|(tc)|(td)|(tel)|(tf)|(tg)|(th)|(tj)|(tj\.cn)|(tk)|(tl)|(tm)|(tn)|(to)|(tp)|(tr)|(travel)|(tt)|(tv)|(tw)|(tw\.cn)|(tz)|(ua)|(ug)|(uk)|(us)|(uy)|(uz)|(va)|(vc)|(ve)|(vg)|(vi)|(vn)|(vu)|(wf)|(ws)|(xj\.cn)|(xn--55qw42g)|(xn--55qw42g\.cn)|(xn--55qw42g\.xn--fiqs8s)|(xn--55qw42g\.xn--fiqz9s)|(xn--55qx5d)|(xn--fiqs8s)|(xn--fiqz9s)|(xn--g6qw8v)|(xn--g6qw8v\.cn)|(xn--io0a7i)|(xn--lhrz14b)|(xn--lhrz14b\.cn)|(xn--lhrz14b\.xn--fiqs8s)|(xn--lhrz14b\.xn--fiqz9s)|(xn--od0alg)|(xn--zfr164b)|(xn--zfr164b\.cn)|(xn--zfr164b\.xn--fiqs8s)|(xn--zfr164b\.xn--fiqz9s)|(xz\.cn)|(ye)|(yn\.cn)|(yt)|(za)|(zj\.cn)|(zm)|(zw))$/', $domain)) {
        return false;
    }
    return true;
}

//将v6地址转换成char32
function ipv62char($ip_address)
{
    // IPv4 address
    if (strpos($ip_address, ':') === false && strpos($ip_address, '.') !== false)
    {
        $ip_address = '::' . $ip_address;
    }

    // IPv6 address
    $ipv6_char = '';
    if (strpos($ip_address, ':') !== false) {

        $network = inet_pton($ip_address);

        foreach(str_split($network) as $char)
        {
            $ipv6_char  .= str_pad(dechex(ord($char)), 2, '0', STR_PAD_LEFT);
        }

        return strtoupper($ipv6_char);
    }
    else
    {
        return false;
    }
}

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

function checkCommandid($commandid)
{
    if (!$commandid)
    {
        return false;
    }
    if (!is_numeric($commandid))
    {
        return false;
    }
    if (strlen($commandid) > 19)
    {
        return false;
    }

    return true;
}

function diy_trigger_error($msg,$flag=E_USER_ERROR,$errfile='', $errline='')
{
    if(IS_DEBUG){
        echo error_hander(1, $msg,$errfile, $errline);
    }else{
        trigger_error($msg,$flag);
    }
}

//获取文件内容
function getFileContent($filename) {
	$content = '';
	if(function_exists('file_get_contents')) {
		@$content = file_get_contents($filename);
	} else {
		if(@$fp = fopen($filename, 'r')) {
			@$content = fread($fp, filesize($filename));
			@fclose($fp);
		}
	}
	return $content;
}

// XSD对比
function xmlXsdCheck($xml_body, $filename){
    $xsdFile = APP_CONFIG_PATH.'xsd/'.$filename;
    $xsd_check = xmlCheck($xml_body, $xsdFile);
    if ($xsd_check === false)
    {
    	FW(time().'.xml', $xml_body, DATA_PATH . 'xsd_error' . DS);
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

// 处理
function xmlFormat($xml_head, $xml_body){
    $info_list = F('sys_conf');
    $info = $info_list ? $info_list : array();

    //消息认证密钥
    $user_pwd = $info['user_pwd'];
    $news_auth_key = $info['news_auth_key'];
    $encrypt_key = $info['encrypt_key'];
    $encrypt_iv = $info['encrypt_iv'];
    $encryptAlgorithm = $info['encryptAlgorithm'];
    $compressionFormat = $info['compressionFormat'];
    $hashAlgorithm = $info['hashAlgorithm'];
    $commandVersion = $info['commandVersion'];

    //压缩
    $xml_str_zip = compressionFormat($compressionFormat, $xml_body);

    $xml_str_zip_key = $xml_str_zip . $news_auth_key;

    //hash
    $xml_str_zip_key_hash = hashFormat($hashAlgorithm, $xml_str_zip_key);

    $dataHash = base64_encode($xml_str_zip_key_hash);

    //aes
    $xml_str_zip_aes = xmlAes($encryptAlgorithm, $encrypt_key, $encrypt_iv, $xml_str_zip);

    $dataUpload = $encryptAlgorithm == 1 ? $xml_str_zip_aes : base64_encode($xml_str_zip_aes);

    $xml_foot = "</dataUpload><encryptAlgorithm>" .$encryptAlgorithm. "</encryptAlgorithm><compressionFormat>" .$compressionFormat. "</compressionFormat><hashAlgorithm>" .$hashAlgorithm. "</hashAlgorithm><dataHash>" .$dataHash. "</dataHash><commandVersion>" .$commandVersion. "</commandVersion></fileLoad>";

    $file_load_xml = $xml_head.$dataUpload.$xml_foot;

    $path = DATA_PATH . 'file/xml/1/'.date('Ymd').'/';

    FW(time().'_n.xml', $xml_body, $path);

    return $file_load_xml;
}


//获取文件名后缀
function fileext($filename) {
    return strtolower(trim(substr(strrchr($filename, '.'), 1)));
}

//读txt文件转为数组
function txt2array($filepath)
{
    $data = array();
    $data_str = '';

    if (is_file($filepath))
    {
        $data_str = getFileContent($filepath);
        
        $chartset = mb_detect_encoding($data_str,array('UTF-8','GB2312','BIG5','GBK','UTF-16','UCS-2','ASCII'));
        if(!$chartset){
            $chartset = 'Unicode';
        }

        // 将非utf-8格式文件内容转为utr-8
        if (strtolower($chartset) != 'utf-8')
        {
            $data_str = mb_convert_encoding($data_str, 'UTF-8', $chartset);
        }
        $data = explode("\r\n", $data_str);
    }

    $result = array();

    if (!empty($data))
    {
        // 去除bom头
        $contents   = $data[0];
        $charset    = array();
        $charset[1] = substr($contents, 0, 1);
        $charset[2] = substr($contents, 1, 1);
        $charset[3] = substr($contents, 2, 1);

        // 判断是否有bom头
        if (ord($charset[1]) == 239 && ord($charset[2]) == 187 && ord($charset[3]) == 191) 
        {
            $data[0] = substr($contents, 3);    // 取非bom头部分
        }

        foreach ($data as $key => $value)
        {
            if (!trim($value))
            {
                continue;
            }

            $result[] = explode(',', trim($value));
        }
    }

    @unlink($filepath);

    return $result;
}

/**
 * 处理文件内容编码等
 * @param  string $file [description]
 * @return [type]       [description]
 */
function doFileContent($file = ''){
    if(!is_file($file)){
        return false;
    }
    $data_str = getFileContent($file);
    $chartset = mb_detect_encoding($data_str,array('UTF-8','GB2312','BIG5','GBK','UTF-16','UCS-2','ASCII'));
    if(!$chartset){
        $chartset = 'Unicode';
    }
    // 将非utf-8格式文件内容转为utr-8
    if (strtolower($chartset) != 'utf-8'){
        $data_str = mb_convert_encoding($data_str, 'UTF-8', $chartset);
    }
    // 去除bom头
    $charset    = array();
    $charset[1] = substr($data_str, 0, 1);
    $charset[2] = substr($data_str, 1, 1);
    $charset[3] = substr($data_str, 2, 1);

    // 判断是否有bom头
    if (ord($charset[1]) == 239 && ord($charset[2]) == 187 && ord($charset[3]) == 191){
        $data_str = substr($data_str, 3);    // 取非bom头部分
    }

    file_put_contents($file, $data_str);
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
 * ftp 连接reset
 * @param  [type] $conn_id [description]
 * @return [type]          [description]
 */
function ftp_conn_reset($conn_id)
{
    $info_list = F('sys_conf');
    $ftp_info = $info_list ? $info_list : array();
	$ftp_folder = $ftp_info['cu_ftp_path'];
	
	$ftp_folder_arr = explode('/', $ftp_folder);
	
	@ftp_chdir($conn_id, "/");
	
	foreach ($ftp_folder_arr as $key => $value)
    {
        if ($value)
        {
            if (!@ftp_chdir($conn_id, $value))
            {
				return;
            }
        }
    }
	return;
}

/**
 * 上报
 *
 * @param unknown_type $file_time    上报文件名
 * @param unknown_type $setfilename  用于上报出错时，是否重新上报
 * @param unknown_type $op_type      操作类型 delete add update
 * @param unknown_type $type         操作的数据表及相关信息
 * @param unknown_type $where        数据库更新条件
 * @param unknown_type $data         数据库更新数据
 * @return unknown
 */
function xmlReport($file_time, $setfilename = '', $op_type='', $type='', $where='', $data=array()){
    $type_array = array(
        'idcinfo' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '经营单位数据',
            'idc_file_type' => 1,
            'table'         => 'idc_info',
        ),
        'house' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '机房数据',
            'idc_file_type' => 2,
            'table'         => 'idc_houseinfo',
        ),
        'gateway' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '互联网出入口信息',
            'idc_file_type' => 2,
            'table'         => 'idc_gatewayinfo',
        ),
        'ipseg' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => 'IP地址段',
            'idc_file_type' => 2,
            'table'         => 'idc_ipseginfo',
        ),
        'frame' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '机架信息',
            'idc_file_type' => 2,
            'table'         => 'idc_frameinfo',
        ),
        'userinfo' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '用户数据',
            'idc_file_type' => 3,
            'table'         => 'idc_userinfo',
        ),
        'other' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '其他用户占用机房',
            'idc_file_type' => 3,
            'table'         => 'idc_household_other',
        ),
        'useripseg' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => 'IP地址信息',
            'idc_file_type' => 3,
            'table'         => 'idc_ipseg',
        ),
        'service' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '服务信息',
            'idc_file_type' => 3,
            'table'         => 'idc_serviceinfo',
        ),
        'domaininfo' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '域名信息',
            'idc_file_type' => 3,
            'table'         => 'idc_domaininfo',
        ),
        'inter' => array(
            'file_type'     => 1,
            'logid'         => 63,
            'logdes'        => '互联网用户占用机房',
            'idc_file_type' => 3,
            'table'         => 'idc_household_inter',
        ),
    );
    //失败
    $return = ['code' => 1, 'msg'=>''];

    if ($file_time)
    {
        $logid  = $type_array[$type]['logid'];
        $logdes = $type_array[$type]['logdes'];
        $conn_id = get_ftp_conn_id();
        $mkdir_date = date("Y-m-d");

        $file_type = $type_array[$type]['file_type'];
        $xml_file = DATA_PATH . '/file/xml/'.$file_type.'/'.date('Ymd').'/'.$file_time;

        if (!@ftp_chdir($conn_id, $file_type))
        {
            @ftp_mkdir($conn_id, $file_type);
            @ftp_chdir($conn_id, $file_type);
        }

        if (!@ftp_chdir($conn_id, $mkdir_date))
        {
            @ftp_mkdir($conn_id, $mkdir_date);
            @ftp_chdir($conn_id, $mkdir_date);
        }

        // upload the file
        $destination_file = "/{$file_type}/" . date("Y-m-d") . "/" . $file_time;

        $ret = ftp_nb_put($conn_id, $file_time, $xml_file, FTP_BINARY, FTP_AUTORESUME);

        while ($ret == FTP_MOREDATA)
        {
            // 加入其它要执行的代码
            //echo ".";
            // 继续传送...
            $ret = ftp_nb_continue($conn_id);
        }

        if ($ret != FTP_FINISHED)
        {
            $return['msg'] = '上报失败！';
            writeAppLog($logid, $logdes.'上报失败：'.$destination_file);
        }
        else
        {
        	$return['code'] = 0;
        	$return['msg'] = '上报成功';
            writeAppLog($logid, $logdes.'上报成功：'.$destination_file);

            $table = $type_array[$type]['table'];

            switch ($op_type)
            {
                case 'delete':

                    $result = M($table)->where($where)->delete();

                    if ($result === false)
                    {
                        $return['msg'] = '上报成功，本地删除失败';
                    }
                    break;
                case 'add':
                    // if ($data)
                    // {
                    //     $result = M($table)->add($data);
                    //     if ($result === false)
                    //     {
                    //         $return['msg'] = '上报成功，本地添加失败！';
                    //     }
                    // }
                    break;
                case 'update':
                    // if ($data)
                    // {
                    //     $result = M($table)->where($where)->save($data);
                    //     if ($result === false)
                    //     {
                    //         $return['msg'] = '上报成功，本地编辑失败！';
                    //     }
                    // }
                    break;
                default:
                    break;
            }
        }

        ftp_close($conn_id);

        // 用于上报出错时，重新上报
        if ($setfilename)
        {
            $idc_file_type = $type_array[$type]['idc_file_type'];
            M('idc_file_name')->add(['name'=>$file_time, 'type'=>$idc_file_type, 'id'=>'']);
        }
        return $return;
    }
}
/**
 * 验证用户密码
 * @param  [type] $password [description]
 * @return [type]           [description]
 */
function checkPwd($password) {
    $len = strlen($password);
    if ($len > 16 || $len < 6) {
        return FALSE;
    } else {
        return TRUE;
    }
}
/**
* 读取代码表
* @param  [type] $password [description]
* @return [type]           [description]
*/

function getCodedata()
{
    $code_name =  C('AREACODE');
    return $code_name;
}

// 获取代码表内容
function getCode($type)
{
	$table = 'idc_'.$type;
    $list = S($table);
    if(!$list){
    	$data = M($table)->where(['sfyx'=>1])->order('id asc')->select();
    	foreach ($data as $key => $value)
	    {
	        if ($type == 'fwnr')
	        {
	            $list[$value['id']]['mc'] = $value['mc'];
	            $list[$value['id']]['fl'] = $value['fl'];
	        }
	        else
	        {
	            $list[$value['id']] = $value['mc'];
	        }

	    }
	    S($table, $list);	
    }
    
    return $list;
}

/**
 * 验证证件类型
 * @param  integer $idType [description]
 * @param  string  $value  [description]
 * @return [type]          [description]
 */
function checkIdnumber($idType = 1, $value = ''){
	$return = true;
    /* 军官证  汉字加6位 其他 */
    switch ($idType) {
    	// 工商营业执照号码   数字
    	case 1:
    		preg_match('/[0-9a-zA-z]*/', $value) or $return = false;
    		break;
    	// 身份证  数字字母	
    	case 2:
    		preg_match('/^\d{17}[0-9a-zA-z]{1}$/', $value) or $return = false;
    		break;
    	// 组织机构代码证书  社团法人证书 数字字母下划线	
    	case 3:
    		preg_match('/^[a-zA-z0-9\_]+$/', $value) or $return = false;
    		break;
    	// 组织机构代码证书  社团法人证书 数字字母下划线	
    	case 6:
    		preg_match('/^[a-zA-z0-9\_]+$/', $value) or $return = false;
    		break;
    	// 事业法人证书   数字	
    	case 4:
    		preg_match('/^[0-9]+$/', $value) or $return = false;
    		break;
    	// 军队代号 由5位或4位数字组成	
    	case 5:
    		preg_match('/^[0-9]{4,5}$/', $value) or $return = false;
    		break;
    	// 护照 4/15+7位数,G+8位数；因公普通的是:P.+7位数；公务的是：S.+7位数 或者 S+8位数,以D开头的是外交护照.D=diplomatic
    	case 7:
    		preg_match('/^[415GPSD\.0-9]+$/', $value) or $return = false;
    		break;
    	// 台胞证   10位数字。第一位是字母。后面九位是数	
    	case 9:
    		preg_match('/^[a-zA-Z]{1}[0-9]{9}$/', $value) or $return = false;
    		break;
    	default:
    		
    		break;
    }

    return $return;
}

/**
 * 验证固话格式
 * @param  string $value [description]
 * @return [type]        [description]
 */
function checkTel($value = ''){
	if(preg_match('/^(0[0-9]{2,3}\-?)?([2-9][0-9]{6,8})+$/', $value)){
		return true;
	}
	return false;
}

/**
 * 验证手机号格式
 * @param  string $value [description]
 * @return [type]        [description]
 */
function checkMobile($value = ''){
	if(preg_match('/(?:0)?13[0-9]{9}|15[0|1|2|3|5|6|7|8|9]\d{8}|147[0-9]{8}|17[0-9]{9}|18[0-9]{9}|19[0-9]{9}/', $value)){
		return true;
	}
	return false;
}

/**
 * 验证邮箱格式
 * @param  string $vlaue [description]
 * @return [type]        [description]
 */
function checkEmail($value = ''){
	if(preg_match('/^[a-z0-9]([a-z0-9]*[-_\.]?[a-z0-9]+)*@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/', $value)){
		return true;
	}
	return false;
}

/**
 * 验证用户名长度等
 * @param  [type] $username [description]
 * @return [type]           [description]
 */
function checkUsername($username) {
    $guestexp = '\xA1\xA1|\xAC\xA3|^\xD3\xCE\xBF\xCD|\xB9\x43\xAB\xC8'; //|^Guest
    $len = strlen($username);

    if ($len > 18 || $len < 4 || !preg_match('/^[a-zA-Z][a-zA-Z0-9\_]{3,17}$/', $username) || preg_match("/\s+|\\\\|^c:\\con\\con|[%,\*\"\s\<\>\&]|$guestexp/is", $username)) {
        return FALSE;
    } else {
        return TRUE;
    }
}
/**
 * 判断邮箱
 * @param  [type]  $email [description]
 * @return boolean        [description]
 */
function isEmail($email) {
    $res = preg_match('/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/', $email);
    return $res;
}

/**
 * 电话正则
 * @param  [type]  $phone [description]
 * @return boolean        [description]
 */
function isPhone($phone) {
    if (!preg_match('/^(0[0-9]{2,3}\-?)?([2-9][0-9]{6,7})+$/', $phone) && !preg_match('/(?:0)?13[0-9]{9}|15[0|1|2|3|5|6|7|8|9]\d{8}|147[0-9]{8}|18[0|5|6|7|8|9]\d{8}/', $phone)) {
        return false;
    }
    return true;
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

    M('sys_log')->add($set);
}

/**
 * [addFtp description]
 * @param string $user     [description]
 * @param string $pwd      [description]
 * @param string $vhostdir [description]
 */
function addFtp($user = '', $pwd = '', $vhostdir = ''){
    if(!$user) return false;

    if(!$pwd) $pwd = $user;

    if(!$vhostdir) $vhostdir = C('euftp_path');

    exec('sudo bash /root/lnmp/addftp.sh '.$user.' '.$pwd.' '.$vhostdir . ' 2>&1', $output, $return);
    exec('sudo chown www:www -R '.$vhostdir);
    // exec('sudo bash /root/lnmp/addftp.sh', $output, $return);
    // exec('sudo /usr/local/pureftpd/bin/pure-pw list 2>&1', $output, $return);

    if($return == 0){
        return true;    
    }
    
    return false;
}