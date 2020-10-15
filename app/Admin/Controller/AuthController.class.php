<?php
namespace Admin\Controller;

class AuthController extends BackendController {

    /**
     * 用户角色
     * @return [type] [description]
     */
	public function index() {
		$user_list = array();
		$user_list = M('sys_auth')->order('add_time desc')->select();

		$this->assign('user_list',$user_list);
		$this->display('index');
	}
	
	/**
	 * 添加
	 */
    public function authRule(){ 

    	$data = $this->getSubMenu();

    	$this->assign('data',$data);
    	$this->display();
    }

    /**
     * 权限菜单添加、编辑
     * @return [type]
     */
    public function authRadd(){ 
		$id = I('get.id'); 
    	if(IS_AJAX){
    		$m = M('auth_rule');
    		$data['name'] = I('post.name');
    		$data['title'] = I('post.title');
            $data['icon'] = I('post.icon', 'fa fa-circle-o');
    		$data['pid'] = I('post.pid');
    		$data['id'] = I('post.id');
    		$data['sort'] = I('post.sort');
            $data['status'] = I('post.status', 1, 'intval');
    		$data['create_time'] = time();

    		if($data['id']){
    			if($m->save($data)){
                    //缓存菜单
                    $authMenu = $this->getSubMenu();
                    F('authMenu', $authMenu);

	    			$this->ajaxResponse(0, '修改成功', ['url'=>'reload']);
	    		}
	    		$this->ajaxResponse(1, '修改失败');
    		}
    		if($m->add($data)){
                //缓存菜单
                $authMenu = $this->getSubMenu();
                F('authMenu', $authMenu);

    			$this->ajaxResponse(0, '添加成功', ['url'=>'reload']);
    		}
    		$this->ajaxResponse(1, '添加失败');
    	}

		$m = M('auth_rule');
		$field = 'id,name,title,icon,create_time,status';
    	$data = $m->field($field)->where(['pid'=>0])->select();

    	foreach ($data as $k=>$v){
    		$data[$k]['sub'] = $m->field($field)->where(['pid'=>$v['id']])->select();
    	}
    	
    	$result = [];
    	if($id){
    		$result = $m->where(['id'=>$id])->find();
    	}

    	$this->assign('result',$result);
    	$this->assign('id',$id);
    	$this->assign('data',$data);
    	$this->display();
    }

    /**
     * 重新生成菜单
     * @return [type] [description]
     */
    public function redo(){
        $authMenu = $this->getSubMenu();
        F('authMenu', $authMenu);

        $this->redirect('Auth/authRule');
    }

    /**
     * 新增、编辑角色
     */
	public function add() {  
        $admin_name = session('admin_name');

		if(IS_AJAX){ 
			$id = I('post.id');
    		$data['rules'] = I('post.rules');
            $data['uname'] = $admin_name;
    		if(empty($data['rules'])){
    			$this->ajaxResponse(1, '请分配需要的权限');
    		}
    		$m = M('sys_auth'); 
    		$data['title'] = I('post.title');
    		$data['rules'] = implode(',', $data['rules']);
    		$data['add_time'] = time();

    		if(empty($data['title'])){
    			$this->ajaxResponse(1, '角色组名称不能为空');
    		}
    		if($id){
                unset($data['id']);
    			if($m->where(['id'=>$id])->save($data)){ 
    				$this->ajaxResponse(0, '编辑成功', ['url'=>U('Auth/index')]);
	    		}
	    		$this->ajaxResponse(1, '编辑失败');
    		}
    		else{
                unset($data['id']); 
    			if($m->add($data)){
    				$this->ajaxResponse(0, '添加成功', ['url'=>U('Auth/index')]);
    			}
    		}
    	}

		$where['id'] = I('get.id');
		$result = M('sys_auth')->field('id,title,rules')->where($where)->find();
		if($result['rules']){
            $result['rules'] = explode(',', $result['rules']);
        }
		$data = $this->getSubMenu();
    	
   
    	$this->assign('result',$result); 
    	$this->assign('data',$data);
		$this->display();
	}

	/**
	 * 删除
	 */
	public function delete() {
		$id = I('get.id');  

		if ($id && $id > 2) {
			$count = M('sys_users')->where(['rid'=>$id])->count();
			if ($count > 0) {
				$this->ajaxResponse(2, '该角色下还有用户，不能进行删除！');
			}
			$result = M('sys_auth')->where(['id'=>$id])->delete();
		} else {
			$this->ajaxResponse(1, '角色无法删除');
		}

		if ($result) {
			writeAppLog(5, '删除角色：' . $name, '', M('sys_auth'));
			$this->ajaxResponse(0,'删除成功',U('Auth/index')); 
		} else {
			$this->ajaxResponse(1, '删除失败');
		}
	}

	/**
	 * 删除权限菜单
	 */
	public function delauthRule() {
		$id = I('get.id'); 
		$count = M('auth_rule')->where(['pid'=>$id])->count();

		if($count){
            $this->ajaxResponse(1, '该菜单下还有子菜单，不能进行删除！'); 
		}
		if($id){
			M('auth_rule')->where(['id'=>$id])->delete();

            //缓存菜单
            $authMenu = $this->getSubMenu();
            F('authMenu', $authMenu);

			$this->ajaxResponse(0,'删除成功',U('Auth/index')); 
		}
        else{
			$this->ajaxResponse(1,'删除失败'); 
		}
	}
}