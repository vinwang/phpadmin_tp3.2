<?php
namespace Admin\Controller;

class UploadController extends BackendController {
    /**
     * 上报文件处理列表
     */
    public function index()
    {
        $datatype = I('get.datatype');
        $resulttype = I('get.resulttype');

        $where = [];

        // 上报类型
        if ($datatype)
        {
            $where['datatype'] = $datatype;
        }
        // 处理结果
        if ($resulttype !== '')
        {
            $where['resulttype'] = $resulttype;
        }
        //分页
        $count = M('idc_file_load_action as a')->join('left join idc_file_name as b on a.filename = b.name')->where($where)->count();
        $page = new \Org\Net\Page($count, 10);
        $pageshow['show'] = $page->show();
        $pageshow['total'] = $page->showTotal();
        
        $infolist = M('idc_file_load_action as a')->join('left join idc_file_name as b on a.filename = b.name')->where($where)->order('filename desc')->limit($page->firstRow,$page->listRows)->select();

        $info_list = array();
        foreach ($infolist as $key => $value)
        {
            $info_list[$key]['filename'] = $value['filename'];
            $info_list[$key]['datatype'] = $value['datatype'];
            $info_list[$key]['resulttype'] = $value['resulttype'];
            $info_list[$key]['content'] = $value['content'];
            $info_list[$key]['loadtype'] = $value['loadtype'];
            $info_list[$key]['timestamp'] = $value['timestamp'];
        }

        $datatype = D('Upload')->datatype();
        $resulttype = D('Upload')->resulttype();
        $this->assign('info_list',$info_list);
        $this->assign('datatype',$datatype);
        $this->assign('resulttype',$resulttype);
        $this->assign('pageshow',$pageshow);
        $this->display('index');
    }

    /**
     * 重新上报
     */
    public function uploadreport()
    {
        $id = I('get.id');
        $id    = isset($id) ? intval($id) : 0;

        $info  = M('idc_file_load_action')->where(['filename' => $id])->find();
        $type = $info['datatype'];
        $file_time = strstr($info['timestamp'], ' ', TRUE);
        $file_time_url = str_replace("-","",$file_time);
        $name = $id.'.xml';
        $file  = DATA_PATH . 'file/xml/'.$type.'/'.$file_time_url .'/'.$name;
        if (!is_file($file)) {
            $this->ajaxResponse('0','重新上报失败');
        }
        $destination_file = "/" . $type . "/" . date("Y-m-d") . "/" . $name;
        $conn_id = get_ftp_conn_id();
        $mkdir_date = date("Y-m-d");
        if (!@ftp_chdir($conn_id, $type)) {
            @ftp_mkdir($conn_id, $type);
            @ftp_chdir($conn_id, $type);
        }
        if (!@ftp_chdir($conn_id, $mkdir_date)) {
            @ftp_mkdir($conn_id, $mkdir_date);
            @ftp_chdir($conn_id, $mkdir_date);
        }
        $ret = ftp_nb_put($conn_id, $name, $file, FTP_BINARY, FTP_AUTORESUME);
        while ($ret == FTP_MOREDATA) {
            $ret = ftp_nb_continue($conn_id);
        }

        $set = array(
            'model' => 130,
            'logdes' => "重新上报：" . $destination_file,
            'logcmd' => '',
            'uid' => 1,
            'urid' => 1,
            'uname' => 'ISMS',
            'ulogipv4' => '2130706433',
            'add_time' => time()
        );

        M('sys_log')->add($set);
        $sql = ['loadtype'=>1];
        M('idc_file_load_action')->where(['filename' => $id])->save($sql);
        $this->ajaxResponse('1','重新上报成功');
    }

    /**
     * xml文件展示
     */
    public function show()
    {
        $id = I('get.id','0','intval');
        $src = I('get.src','0','intval');
        $type = I('get.type');
        $table = 'idc_file_load_action';
        $info  = M($table)->where(['filename' => $id])->find();
        $file_time = strstr($info['timestamp'], ' ', TRUE);
        $file_time_url = str_replace("-","",$file_time);
        if($src){
            $file  = DATA_PATH . 'file/xml/'.$type.'/'.$file_time_url .'/'.$id.'.xml';
        }else{
            $file  = DATA_PATH . 'file/xml/'.$type.'/'.$file_time_url .'/'.$id.'_n.xml';
        }
        
        if (!$id || !$info || !is_file($file))
        {
            header("Content-type: text/html; charset=utf-8");
            exit('文件不存在');
        }

        ob_clean();

        header('Content-Type: text/xml');
        echo file_get_contents($file);
    }
}