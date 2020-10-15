<?php
namespace Admin\Controller;

class SysconfController extends BackendController {

     //时间设置
    public function time()
    {
        $class_current = 2;
        $now_time = date("Y-m-d H:i:s");

        $name = 'time_server';
        $time_server = M('sys_conf')->where(array('name'=>$name))->find();
        $time_server = $time_server['value'];
        $setconf = F('isms');
        $time_edit_hand = $setconf['time_edit_hand'];
        $this->assign('now_time',$now_time);
        $this->assign('time_edit_hand',$time_edit_hand);
        $this->display();
    }

    public function setNewDate()
    {
        $date = I('post.new_date');
        $date = preg_replace('/\s{2,}/',' ',$date);

        if(preg_match('/\d{4}-\d{2}-\d{2}\s{1}\d{2}:\d{2}:\d{2}/',$date)){
            $unix_time = strtotime($date);

            $socket = new \Org\Net\Jagent();
            $result = $socket->set_time($unix_time);

            if ($result === TRUE)
            {
                writeAppLog(8, '修改系统当前时间');
                echo date("Y-m-d H:i:s");
            }
            else
            {
                echo 'frm_er';
            }
        }else{
            echo 'frm_er';
        }
    }

    //与internet时间同步
    public function setNewTimeFromInternet()
    {
        $server = I('post.server');
        if($server){

            $socket = new \Org\Net\Jagent();
            $result = $socket->set_nettime($server);

            if ($result === false)
            {
                echo json_encode(array('fail',0)); //Fail
                exit;

            }
            else
            {
                $row = array(
                    'name'  => 'time_server',
                    'value' => $server,
                );
                M('sys_conf')->save($row);

                writeAppLog(8, '与internet时间同步 服务器：'.$server);
                //success
                echo json_encode(array('success',date("Y-m-d H:i:s")));
                exit;
            }
        }

    }
    /**
    *接口参数
    *
    */
    public function xtpz(){  
        if (IS_POST){
            $data = I('post.');
            if($data['bacxUrl'] && ($data['bacxUser'] == '' || $data['bacxPwd'] == '')){
                $this->ajaxResponse(1, '备案查询用户名或密码不能为空');
            }
            if($data['isdu'] == 1 && ($data['du_surl'] == '' || $data['du_ftp_port'] == '' || $data['du_ftp_host'] == '' || $data['du_ftp_user'] == '' || $data['du_ftp_pwd'] == '' || $data['du_ftp_path'] == '')){
                $this->ajaxResponse(1, 'DU接口地址或ftp配置不能为空');
            }
            if($data['du_ftp_port'] && (!is_numeric($data['du_ftp_port']) || $data['du_ftp_port'] < 0 || $data['du_ftp_port'] > 65535)){
                $this->ajaxResponse(1, 'DU-ftp端口格式错误');
            }

            foreach ($data as $k => $value){
                if(M('sys_conf')->where(['name'=>$k])->count()){
                    M('sys_conf')->where(['name'=>$k])->save(['value'=>$value]);  
                }
                else{
                    M('sys_conf')->add(['name'=>$k, 'value'=>$value]);
                }
            }
            //存入系统表
            $info = F('isms');
            $info = $info ? $info : [];
            $info_list = array(
                'commandfileid' => $data['commandfileid'],
                'commandid' => $info['commandid'] ? $info['commandid'] : 1000000000,
                'xml_xsd_check' => $data['xml_xsd_check'],
                'timelog_save_xml' => $data['timelog_save_xml'],
                'time_edit_hand' => $data['time_edit_hand'],
                'log_save' => $data['log_save'], 
                'upload_save_days' => $data['upload_save_days'], 
                'upload_log' => $data['upload_log'], 
                'workMode' => $data['workMode'], 
                'bacxUrl' => $data['bacxUrl'], 
                'bacxUser' => $data['bacxUser'], 
                'bacxPwd' => $data['bacxPwd'], 
                'isdu' => $data['isdu'], 
                'du_surl' => $data['du_surl'],
                'du_ftp_host' => $data['du_ftp_host'],
                'du_ftp_port' => $data['du_ftp_port'],
                'du_ftp_user' => $data['du_ftp_user'],
                'du_ftp_pwd' => $data['du_ftp_pwd'],
                'du_ftp_path' => $data['du_ftp_path']
            );
            F('isms', $info_list);
            //eu同步配置
            R('Command/Api/index', ['type'=>3]);
            writeAppLog(61,  '更改接口参数配置成功');
            $this->ajaxResponse(0, '编辑成功');
        }

        $info_list = F('isms');
        if(!$info_list){
            $info_lists = M('sys_conf')->select();
            $info_list = [];
            foreach ($info_lists as $key => $value) {
                $info_list[$value['name']] = $value['value'];
            }
            $info_list = array(
                'commandfileid' => $info_list['commandfileid'],
                'commandid' => 1000000000,
                'xml_xsd_check' => $info_list['xml_xsd_check'],
                'timelog_save_xml' => $info_list['timelog_save_xml'],
                'time_edit_hand' => $info_list['time_edit_hand'],
                'log_save' => $info_list['log_save'], 
                'upload_save_days' => $info_list['upload_save_days'], 
                'upload_log' => $info_list['upload_log'], 
                'workMode' => $info_list['workMode'], 
                'bacxUrl' => $info_list['bacxUrl'], 
                'bacxUser' => $info_list['bacxUser'], 
                'bacxPwd' => $info_list['bacxPwd'], 
                'isdu' => $info_list['isdu'], 
                'du_surl' => $info_list['du_surl'],
                'du_ftp_host' => $info_list['du_ftp_host'],
                'du_ftp_port' => $info_list['du_ftp_port'],
                'du_ftp_user' => $info_list['du_ftp_user'],
                'du_ftp_pwd' => $info_list['du_ftp_pwd'],
                'du_ftp_path' => $info_list['du_ftp_path']
            );
            F('isms', $info_list);
        }

        $this->assign('info_list',$info_list);
        $this->display();
    }

    /**
     * 基础参数
     * 
     */
    public function setconf()
    { 
        if(IS_POST){
            $datas = I('post.');
            $data = array_filter($datas);

            if ($data['ftp_port'] && (!is_numeric($data['ftp_port']) || $data['ftp_port'] < 0 || $data['ftp_port'] > 65535))
            {
                $this->ajaxResponse(1,'ftp端口格式错误！');
            }

            if(M('sys_conf')->where(['name'=>['like', ['qsip%','zzip%']]])->count()){
                M('sys_conf')->where(['name'=>['like', ['qsip%','zzip%']]])->delete();
            }
            
            foreach ($data as $k => $value){
                if(M('sys_conf')->where(['name'=>$k])->count()){
                    M('sys_conf')->where(['name'=>$k])->save(['value'=>$value]);  
                }
                else{
                    M('sys_conf')->add(['name'=>$k, 'value'=>$value]);
                }
            }
            //存入系统表
            $monitorip = [];
            $monitorips = M('sys_conf')->where(['name'=>['like', ['qsip%','zzip%']]])->select();
            foreach ($monitorips as $key => $value) {
                $monitorip[$value['name']] = $value['value'];
            }
            $info = array(
                'smms_ip' => $data['smms_ip'],
                'user_pwd' => $data['user_pwd'],
                'news_auth_key' => $data['news_auth_key'],
                'encrypt_key' => $data['encrypt_key'],
                'encrypt_iv' => $data['encrypt_iv'],
                'ftp_server' => $data['ftp_server'],
                'ftp_port' => $data['ftp_port'],
                'ftp_uname' => $data['ftp_uname'],
                'ftp_pwd' => $data['ftp_pwd'],
                'ftp_folder' => $data['ftp_folder'],
                'encryptAlgorithm' => $data['encryptAlgorithm'],
                'compressionFormat' => $data['compressionFormat'],
                'hashAlgorithm' => $data['hashAlgorithm'],
                'commandVersion' => $data['commandVersion'],
            );
            $info_list = array_merge($info, $monitorip);
            F('sys_conf', $info_list);

            R('Command/Api/index', ['type'=>3]);
            writeAppLog(62,  '更改基础参数配置成功');
            $this->ajaxResponse(0,'编辑成功');
        }

        $encryptAlgorithm = array(
            0 => '无',
            1 => 'AES',
        );
        $hashAlgorithm = array(
            0 => '无',
            1 => 'MD5',
            2 => 'SHA1',
        );
        $compressionFormat = array(
            0 => '无',
            1 => 'ZIP',
        );

        $info_list = F('sys_conf');
        if(!$info_list){
            $info_lists = M('sys_conf')->select();
            $info_list = [];
            foreach ($info_lists as $key => $value) {
                $info_list[$value['name']] = $value['value'];
            }
            $monitorip = [];
            $monitorips = M('sys_conf')->where(['name'=>['like', ['qsip%','zzip%']]])->select();
            foreach ($monitorips as $key => $value) {
                $monitorip[$value['name']] = $value['value'];
            }
            $info = array(
                'smms_ip' => $info_list['smms_ip'],
                'user_pwd' => $info_list['user_pwd'],
                'news_auth_key' => $info_list['news_auth_key'],
                'encrypt_key' => $info_list['encrypt_key'],
                'encrypt_iv' => $info_list['encrypt_iv'],
                'ftp_server' => $info_list['ftp_server'],
                'ftp_port' => $info_list['ftp_port'],
                'ftp_uname' => $info_list['ftp_uname'],
                'ftp_pwd' => $info_list['ftp_pwd'],
                'ftp_folder' => $info_list['ftp_folder'],
                'encryptAlgorithm' => $info_list['encryptAlgorithm'],
                'compressionFormat' => $info_list['compressionFormat'],
                'hashAlgorithm' => $info_list['hashAlgorithm'],
                'commandVersion' => $info_list['commandVersion'],
            );
            $info_list = array_merge($info, $monitorip);
            F('sys_conf', $info_list);
        }
        
        $lists = M('sys_conf')->where(['name'=>['like', ['qsip%','zzip%']]])->select();
        $list = [];
        foreach ($lists as $key => $value) {
            if(preg_match('/\d+/',$value['name'],$arr)){
                $list[$arr[0]][substr($value['name'], 0, 4)] = $value['value'];
            }
        }
        $this->assign('list',$list);
        $this->assign('info_list',$info_list);
        $this->assign('encryptAlgorithm',$encryptAlgorithm);
        $this->assign('hashAlgorithm',$hashAlgorithm);
        $this->assign('compressionFormat',$compressionFormat);
        $this->display();
    }

    /**
    *系统日志
    *
    */
    public function log(){
        $admin_id = session('admin_id');
        $admin_rid = session('admin_rid');
        $uid = I('get.uid');
        $model = I('get.model');
        $uname = I('get.uname');
        $ulogipv4 = I('get.ulogipv4');
        $logdes = I('get.logdes');
        $add_time_start = I('get.add_time_start');
        $add_time_end = I('get.add_time_end');
        $condtion = array(
            'uid'           => $uid,
            'model'         => $model,
            'uname'         => $uname,
            'ulogipv4'      => $ulogipv4,
            'logdes'        => $logdes,
            'add_time_start'=> $add_time_start,
            'add_time_end'  => $add_time_end,
        );
        $where = '';
        $add_time_start = $add_time_end = 0;
        foreach($condtion as $key=>$value){
            if(empty($value)) continue;
            if($key == 'ulogipv4'){
                $value = sprintf("%u",ip2long($value));
            }
            if($key == 'add_time_start'){
                $add_time_start = strtotime($value);
                continue;
            }
            if($key == 'add_time_end'){
                $add_time_end = strtotime($value);
                continue;
            }

            if($key == 'logdes'){
                if($where){
                    $where .= " AND {$key} LIKE '%{$value}%'";
                }else{
                    $where = "{$key} LIKE '%{$value}%'";
                }
                continue;
            }

            if($where){
                $where .= " AND {$key} = '{$value}'";
            }else{
                $where = "{$key} = '{$value}'";
            }
        }
        if($add_time_start && $add_time_end){
            if($where){
                $where .= " AND (add_time >= '{$add_time_start}' AND add_time <= '{$add_time_end}')";
            }else{
                $where = "add_time >= '{$add_time_start}' AND add_time <= '{$add_time_end}'";
            }
        }else if($add_time_start){
            if($where){
                $where .= " AND add_time >= '{$add_time_start}'";
            }else{
                $where = "add_time >= '{$add_time_start}'";
            }
        }else if($add_time_end){
            if($where){
                $where .= " AND add_time <= '{$add_time_end}'";
            }else{
                $where = "add_time <= '{$add_time_end}'";
            }
        }
        
        //超级管理员除外
        if($admin_rid != 1){
            if($where){
                $where .= " AND uid = {$admin_id}";
            }else{
                $where = "uid = {$admin_id}";
            }
        }

        //分页
        $count = M('sys_log')->where($where)->count();
        $page = new \Org\Net\Page($count, 10);

        $pageshow['show'] = $page->show();
        $pageshow['total'] = $page->showTotal();

        $log_list = M('sys_log')->where($where)->order('add_time desc, id desc')->limit($page->firstRow.','.$page->listRows)->select();

        $result = M('sys_auth')->field('id,title')->select();
        foreach ($result as $key => $value)
        {
            $auth_arr[$value['id']] = $value['title'];
        }
        $log_model = C('LOG_CODE');

        $this->assign('log_list',$log_list);
        $this->assign('log_model',$log_model);
        $this->assign('auth_arr',$auth_arr);
        $this->assign('pageshow', $pageshow);
        $this->assign('model', $model);
        $this->display('log');
        
    }

    //ISMI接口日志
    public function synclog(){
        $where = []; 
        $euid = I('get.euid');
        $synctype = I('get.synctype');
        $syncstatus = I('get.syncstatus');
        $syncmsg = I('get.syncmsg');
        if($euid){
            $where['euId'] = $euid;
        }
        if($synctype){
            $where['syncType'] = $synctype;
        }
        if($syncstatus !== ''){
            $where['syncStatus'] = $syncstatus;
        }
        if($syncmsg){
            $where['syncMsg'] = ['like','%'.$syncmsg.'%'];
        }
        //分页读取
        $count = M('idc_synclogs')->where($where)->count();
        $page = new \Org\Net\Page($count, 10);

        $pageshow['show'] = $page->show();
        $pageshow['total'] = $page->showTotal();
        $info_list = M('idc_synclogs')->where($where)->order('id desc')->limit($page->firstRow, $page->listRows)->select();
        //查询eu设备名称
        $euName = [];
        $euNames = M('idc_server')->field('spotId,spotType')->select();
        foreach ($euNames as $key => $value) {
            $euName[$value['spotid']] = $value['spottype'];
        }
        $syncType = [
            '1' => '关键词',
            '2' => '关键词库',
            '3' => '配置信息',
            '4' => 'weservice信息安全指令同步',
            '5' => '黑白名单',
            '6' => '处置列表',
            '7' => '本地指令',
            '8' => 'EU设备信息'
        ];
        $syncStatus = ['未成功', '成功'];
        $this->assign('info_list', $info_list);
        $this->assign('syncType', $syncType);
        $this->assign('syncStatus', $syncStatus);
        $this->assign('euName', $euName);
        $this->assign('pageshow', $pageshow);
        $this->display();
    }

    //导出
    public function logexport()
    {
        $admin_id = session('admin_id');
        $admin_rid = session('admin_rid');
        $exporttype = I('get.exporttype',1);
        $uid = I('get.uid');
        $model = I('get.model');
        $uname = I('get.uname');
        $ulogipv4 = I('get.ulogipv4');
        $logdes = I('get.logdes');
        $add_time_start = I('get.add_time_start');
        $add_time_end = I('get.add_time_end');
        //搜索条件
        $condtion = array(
            'exporttype'    => $exporttype,
            'uid'           => $uid,
            'model'         => $model,
            'uname'         => $uname,
            'ulogipv4'      => $ulogipv4,
            'logdes'        => $logdes,
            'add_time_start'=> $add_time_start,
            'add_time_end'  => $add_time_end,
        );
        $where = '';
        $add_time_start = $add_time_end = 0;
        foreach($condtion as $key=>$value){
            if(empty($value)) continue;

            if($key == 'exporttype'){
                continue;
            }

            if($key == 'ulogipv4'){
                $value = sprintf("%u",ip2long($value));
            }
            if($key == 'add_time_start'){
                $add_time_start = strtotime($value);
                continue;
            }
            if($key == 'add_time_end'){
                $add_time_end = strtotime($value);
                continue;
            }

            if($key == 'logdes'){
                if($where){
                    $where .= " AND {$key} LIKE '%{$value}%'";
                }else{
                    $where = " {$key} LIKE '%{$value}%'";
                }
                continue;
            }

            if($where){
                $where .= " AND {$key} = '{$value}'";
            }else{
                $where = " {$key} = '{$value}'";
            }
        }
        if($add_time_start && $add_time_end){
            if($where){
                $where .= " AND (add_time >= '{$add_time_start}' AND add_time <= '{$add_time_end}')";
            }else{
                $where = "add_time >= '{$add_time_start}' AND add_time <= '{$add_time_end}'";
            }
        }else if($add_time_start){
            if($where){
                $where .= " AND add_time >= '{$add_time_start}'";
            }else{
                $where = "add_time >= '{$add_time_start}'";
            }
        }else if($add_time_end){
            if($where){
                $where .= " AND add_time <= '{$add_time_end}'";
            }else{
                $where = "add_time <= '{$add_time_end}'";
            }
        }
        //非网安用户看不到网安用户的操作日志
        if($admin_rid != 1){
            if($where){
                $where .= " AND uid = {$admin_id}";
            }else{
                $where = "uid = {$admin_id}";
            }
        }

        $log_list = M('sys_log')->where($where)->order('add_time desc')->select();

        $exporttype = $condtion['exporttype'];
        $log_model = C('LOG_CODE');
        $result = M('sys_auth')->field('id,title')->select();
        foreach ($result as $key => $value)
        {
            $auth_arr[$value['id']] = $value['title'];
        }
        $exportdata = '';
        $showname = '';
        if ($exporttype == 1)
        {
            foreach($log_list as $key => $value)
            {
                $exportdata .= ($key+1).','.$log_model[$value['model']].','.$value['logdes'].','.$value['uname'].','.$auth_arr[$value['urid']].','.long2ip($value['ulogipv4']).','.date('Y-m-d H:i:s',$value['add_time'])."\r\n";
            }

            $showname = "log_".date("YmdHis").".txt";
        }
        else if ($exporttype == 2)
        {
            if (!empty($log_list))
            {
                foreach($log_list as $key => $value)
                {
                    $time = date("Y-m-d_H:i:s", $value['add_time']);
                    $exportdata .= ($key+1).','.$log_model[$value['model']].','.$value['logdes'].','.$value['uname'].','.$auth_arr[$value['urid']].','.long2ip($value['ulogipv4']).','.$time."\n";
                }
            }

            $showname = "log_".date("YmdHis").".csv";
        }
        if($exportdata){
            $logdes = '导出系统操作日志记录';
            writeAppLog(125, $logdes);

            \Org\Net\Http::download('', $showname, $exportdata);
            exit;
        }
        
        $this->error('暂无数据，请稍后重试');
    }

    /**
    *备份与恢复
    *
    */
    public function backup()
    { 
        $dir = APP_CONFIG_PUB .'/backup/'; 
        
        if (!is_dir($dir)) {
            $ret = mkdir($dir, 0755, true);
            if ($ret === false) {
                // exit('-1');
                $this->ajaxResponse('-1', '创建文件夹失败');
            }
        } 

        $backup = new \Org\Net\MysqlBackup(); 

        // 备份
        if (I('get.back') == 1)
        { 
            $tables = $backup->getTables(); 
            $type = I('get.type');  
            // 压缩
            $size = C("DB_BACKUP_SIZE");
            $sql = ''; 
            $M=M(); 
            // 插入dump信息
            $sql .= $backup->_base(); 
            // 查出所有表
            // $tables = $M->query ( 'SHOW TABLES' );

            if($type == 1){ 
                $name = 'shly'.date('YmdHis').'.sql';
                $filename = $name;  
                $houseid = M('idc_houseinfo')->field('houseId')->select();
                foreach ($houseid as $key => $value) {
                    $tables1 = array(
                        array('tables_in_isms'=>'acclog_'.$value['houseid']),
                        array('tables_in_isms'=>'monitorlog_'.$value['houseid']),
                        array('tables_in_isms'=>'filterlog_'.$value['houseid']),
                    );
                }
                $tables2 = array(
                    array('tables_in_isms'=>'idc_houseinfo'),
                    array('tables_in_isms'=>'idc_gatewayinfo'),
                    array('tables_in_isms'=>'idc_frameinfo'),
                    array('tables_in_isms'=>'idc_ipseginfo'),
                    array('tables_in_isms'=>'idc_userinfo'),
                    array('tables_in_isms'=>'idc_serviceinfo'),
                    array('tables_in_isms'=>'idc_serviceinfo'),
                    array('tables_in_isms'=>'idc_domaininfo'),
                    array('tables_in_isms'=>'idc_household_inter'),
                    array('tables_in_isms'=>'idc_household_other'),
                    array('tables_in_isms'=>'idc_iptrans'),
                    array('tables_in_isms'=>'idc_ipseg'),
                    array('tables_in_isms'=>'idc_virtualserver'),
                    array('tables_in_isms'=>'idc_personinfo')
                    );
                $tables = array_merge($tables1,$tables2);
                foreach  ( $tables as $value) {
                    foreach ($value as $v) {
                        // 获取表结构
                        $sql .= $backup->_insert_table_structure ( $v );
                        // 单条记录
                        $sql .= $backup->_insert_record ( $v );
                    }
                } 

                // 如果大于分卷大小，则写入文件
                if (strlen ( $sql ) >= $size * 1024) {
                    $file = $filename; 
                        if ($backup->_write_file ( $sql, $file, $dir )) { 
                        WriteAppLog(16, '备份成功,文件名:'.$name); 
                        $this->ajaxResponse(1, '备份成功,文件名'.$name);
                    } 
                    else {
                        $this->ajaxResponse(0, '备份失败'); 
                    } 
                } 

            }else{
                $name = 'shly'.date('YmdHis').'.sql';
                $filename = $name;  
                $tables = $M->query ( 'SHOW TABLES' );
                foreach  ( $tables as $value) {
                    foreach ($value as $v) {
                
                        // 获取表结构
                        $sql .= $backup->_insert_table_structure ( $v );
                        // 单条记录
                        $sql .= $backup->_insert_record ( $v );
                    }
                }
                 // 全部导入
                // 如果大于分卷大小，则写入文件
                if (strlen ( $sql ) >= $size * 1024) {
                    $file = $filename;
                    if ($backup->_write_file ( $sql, $file, $dir )) { 
                        WriteAppLog(16, '备份成功,文件名:'.$name); 
                        $this->ajaxResponse(1, '备份成功,文件名'.$name);
                    }
                    else {
                        $this->ajaxResponse(0, '备份失败');
                    } 
                }
            } 

        }

        // 恢复
        $filename = I('get.filename', 'nofile');
        $huifu = I('get.huifu', 0, 'intval');
        if ($huifu == 1)
        {
            $upload = I('get.upload', 0, 'intval');
            $filename = str_replace('_', '.', $filename);

            // 上传恢复文件
            if ($upload == 1)
            {
                $dir = APP_CONFIG_PUB .'/backup/tmp/';
                $source_file = $dir.$filename;
            }
            else
            {
                $dir = APP_CONFIG_PUB .'/backup/';
                $source_file = $dir.$filename;
            }
            // $cmd1 = "gunzip -c {$dir}{$filename} > {$dir}isms.sql ";
            // exec($cmd1);
            // 导入sql语句

            if (is_file($source_file))
            {
                @ini_set('max_execution_time', '0');
                $recovery = $backup->recovery($source_file);
                if($recovery){
                    // unlink($source_file);

                    if ($upload == 1)
                    {
                        // unlink("{$dir}{$filename}");
                    }

                    $list = M('idc_houseinfo')->select();

                    foreach ($list as $key => $value) {
                        M()->execute("create table if not exists acclog_{$value['houseid']} like acclog_local");
                        M()->execute("create table if not exists monitorlog_{$value['houseid']} like monitorlog_local");
                        M()->execute("create table if not exists filterlog_{$value['houseid']} like filterlog_local");
                    }

                    writeAppLog(17, '恢复成功');
                    $this->ajaxResponse(1,'恢复成功！');
                }
                $this->ajaxResponse(0,'恢复失败！');
            }
            $this->ajaxResponse(0,'备份文件不存在！');
        }
        $this->assign('filename',$filename);
        $this->display();
    }
    
    /**
     * 执行恢复
     * @return [type] [description]
     */
    public function recovery()
    {
        $dir = APP_CONFIG_PUB.DS.'backup/';
        if (!is_dir($dir)) {
            $ret = mkdir($dir, 0755, true);
            if ($ret === false) {
                $this->ajaxResponse('-1', '创建文件夹失败');
            }
        }

        $get_filename = I('get.filename');
        $filename = trim($get_filename);
        $filename = str_replace('_', '.', $filename);

        // 下载
        if (I('get.download') == 1)
        {
            if (is_file($dir.DS.$filename))
            {
                Header("Content-type: application/octet-stream");
                Header("Accept-Ranges: bytes");
                Header("Accept-Length: ".filesize($dir .DS. $filename));
                Header("Content-Disposition: attachment; filename=" . $filename);
                echo file_get_contents($dir .DS. $filename);
                exit;
            }
            echo '文件不存在';
            exit;
        }

        // 删除
        if (I('get.delete') == 1)
        {

            if (is_file($dir.DS.$filename))
            {
                if (unlink($dir.DS.$filename) === true)
                {
                    writeAppLog(16, '删除备份文件'.$filename);
                    $this->ajaxResponse(0,'删除成功');
                }
            }
           $this->ajaxResponse(1,'删除失败');
        }


        if (is_dir($dir))
        {
            $g = 1024 * 1024 *1024;
            $m = 1024 * 1024;

            if ($dh = opendir($dir))
            {
                $filearr = array();

                 while (($file = readdir($dh)) !== false) {
                    $file_ext = strtolower(trim(substr(strrchr($file, '.'), 1)));

                    if ($file_ext == 'sql')
                    {
                        $tmp =array();
                        $tmp['name'] = $file;
                        $tmp['time'] = date("Y-m-d H:i:s", @filectime($dir.$file));

                        $file_size = @filesize($dir.$file);
                        if($file_size>=$g){
                            $size = round($file_size/$g,2).' G';
                        }else if($file_size>=$m){
                            $size = round($file_size/$m,2).' M';
                        }else if($file_size>=1024){
                            $size = round($file_size/1024,2).' K';
                        }else{
                            $size = $file_size.' B';
                        }

                        $tmp['size'] = $size;

                        $filearr[] = $tmp;

                    }
                }
                if (!empty($filearr))
                {
                    foreach ($filearr as $key=>$val)
                    {
                        $time[$key]  = $val['time'];
                    }

                    array_multisort($time, SORT_DESC, $filearr);

                }
                closedir($dh);
                clearstatcache();
            }
        }

        $this->assign('file_list',$filearr);
        $this->display();
    }

    /**
     * 执行上传
     */

    public function upload()
    {
        if($_FILES){
            $temp_file = $_FILES['upgradefile']['tmp_name'];
            $filename = $_FILES['upgradefile']['name'];
            $upgrade_path = APP_CONFIG_PUB.DS.'backup'.DS.'tmp';
            $target_file = $upgrade_path.DS.$filename;
            $file_ext = pathinfo($filename, PATHINFO_EXTENSION);

            if ($file_ext != 'sql')
            { 
                @unlink($temp_file);
                $this->error('上传文件错误，请上传sql格式的升级文件'); 
            }
            if ($_FILES['upgradefile']['error'] > 0)
            {
                @unlink($temp_file);
                $this->error($_FILES['upgradefile']['error']);
            }
            // 自动创建目录
            if (!is_dir($upgrade_path) && !mkdir($upgrade_path,0755,true))
            {
                @unlink($temp_file);
                $this->error('创建目录失败');
            }

            if (!move_uploaded_file($temp_file, $target_file))
            {
                @unlink($temp_file);
                $this->error('移动升级文件失败');
            }

            @unlink($temp_file);
            $filename = str_replace('.', '_', $filename);
            $url = U('Sysconf/backup', ['filename'=>$filename]);
            header("Location: ".$url);
        }
        else{
            $this->error('请选择要上传的文件');
        }
    }
}