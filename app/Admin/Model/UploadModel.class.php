<?php
namespace Admin\Model;

use Think\Model;
/**
 * 上报文件处理
 */
class UploadModel extends Model{
	protected $tableName = 'idc_file_load_action';

    /**
     * 上报类型
     */
	public function datatype(){

        $datatype = array(
            1 => '基础数据',
            2 => '基础数据监测数据',
            3 => '访问日志查询结果',
            4 => '监测日志',
            5 => '过滤日志',
            6 => '信息安全管理指令查询结果',
            7 => 'ISMS 活动状态',
            8 => '活跃资源监测记录',
            9 => '违法违规网站监测记录',
        ); 
        
		return $datatype;
	}
    
    /**
     * 处理结果
     */
    public function resulttype(){
        $resulttype = array(
            0 => '处理完成',
            1 => '文件解密失败',
            2 => '文件校验失败',
            3 => '文件解压缩失败',
            4 => '文件格式异常',
            5 => '文件内容异常(版本错误)',
            51 => '文件内容异常--上报类型错误',
            52 => '文件内容异常--节点/子节点长度错误',
            53 => '文件内容异常--节点/子节点类型错误',
            54 => '文件内容异常--节点/子节点内容错误',
            55 => '文件内容异常--节点/子节点缺漏',
            900 => '其他异常(存在其他错误，需重新上报)',
            999 => '其他错误(处理中)',
        );
        return $resulttype;
    }
	
}