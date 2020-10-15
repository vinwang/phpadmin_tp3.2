<?php
namespace Admin\Controller;

class IndexController extends BackendController {

    public function index(){

        $sysconfig = F('sys_conf');

        $this->assign('version',$this->version);
        $this->assign('serial',$this->serial);
        $this->assign('product_name',$this->product_name);
        $this->assign('product_model',$this->product_model);
        $this->display();
    }
}