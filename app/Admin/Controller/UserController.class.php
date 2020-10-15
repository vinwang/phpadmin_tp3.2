<?php
namespace Admin\Controller; 

class UserController extends BackendController{
    
    public function index(){ 
        $admin_id = session('admin_id');
        // 角色
        $result = M('sys_auth')->field('id,title')->select(); 
        $auth_arr = array();
        foreach ($result as $key => $value)
        {
            $auth_arr[$value['id']] = $value['title'];
        }
        //取得user列表
        /*if($admin['rid'] == 1){
            $where = '';
        }else{
            $where = ' uid ='.$admin['uid'];
        }*/
        $where = [];
        $user_list = array();
        $user_list = M('sys_users u')
                    ->join('sys_auth a ON u.rid = a.id')
                    ->field('u.*, a.title, a.rules')
                    ->where($where)->order('u.add_time asc')->select();
  
		$this->assign('user_list',$user_list);   
		$this->assign('admin_id',$admin_id);  
        $this->display();
    }

    /**
     * 用户更新
     * @return [type]
     */
    public function update(){
        $uid  = I('uid');

        if (IS_AJAX){ 
            $username  = I('post.username');
            $password  = I('post.password');
            $password2 = I('post.password2'); 
            $groupid   = I('post.group_id');
            $privilege = I('post.privilege');
            $bindipv4  = I('post.bindipv4');
            $bindipv6  = I('post.bindipv6');
            $department  = I('post.department');
            $post  = I('post.post');
            $name  = I('post.name');
            $email  = I('post.email');
            $phone  = I('post.phone');

            if(!empty($password)){
                if (!checkPwd($password)){
                    $this->ajaxResponse(1, '密码格式错误！');
                }

                if ($password != $password2){
                    $this->ajaxResponse(1, '两次输入的密码不相同！');
                }
                
                $changepwd = true;
            }
            if ($email && !isEmail($email)){
                $this->ajaxResponse(1, '电子邮箱格式有错误！');
            }

            if ($phone && !isPhone($phone)){
                $this->ajaxResponse(1, '联系电话格式有错误！');
            }
            $bindipv4_str = '';
            $bindipv6_str = '';
            $bindmac_str = '';

            if ($bindipv4){
                $bindipv4_array = explode("\r\n", $bindipv4);
                if (!empty($bindipv4_array)){
                    foreach ($bindipv4_array as $key => $tmp){
                        if (!is_ipv4($tmp)){
                            $this->ajaxResponse(1, '允许登录的IPv4地址有错误！');
                        }
                    }
                }
                $bindipv4_str = serialize($bindipv4_array);
            }

            if ($bindipv6){
                $bindipv6_array = explode("\r\n", $bindipv6);
                if (!empty($bindipv6_array)){
                    foreach ($bindipv6_array as $key => $tmp){
                        if (!is_ipv6($tmp)){
                            $this->ajaxResponse(1, '允许登录的IPv6地址有错误！');
                        }
                    }
                }
                $bindipv6_str = serialize($bindipv6_array);
            }

            $setarray = array(
                //'uname'      => $username,
                'allowips'   => $bindipv4_str,
                'allowipv6'  => $bindipv6_str,
                'name'    => $name, 
                'email'    => $email,
                'department' => $department,
                'post'    => $post, 
                'phone'    => $phone
            );

            if ($changepwd){
                $setarray['upwd'] = md5('appbeian_'.md5($password));
            }
            if($uid != 1 && $groupid){
                $setarray['rid'] = $groupid;
            }

            $rs = M('sys_users')->where(['uid'=>$uid])->save($setarray);  

            $result = [];
            if ($rs !== false){
                $m = M('auth_group_access');      
                $group_access = $m->where(['uid'=>$uid])->find(); 
                $result['group_id'] = $groupid ?: $group_access['group_id'];  

               if($group_access['group_id'] == $result['group_id']){
                    writeAppLog(4,'修改用户：' . $username,'',M('sys_users'));
                    $this->ajaxResponse(0, '操作成功', ['url'=>U('User/index')]); 

               }
               elseif($m->where(array('uid'=>$uid))->save($result)){
                    writeAppLog(4,'修改用户：' . $username,'',M('sys_users'));
                    $this->ajaxResponse(0, '操作成功', ['url'=>U('User/index')]); 

               }
                else{
                    $result['uid'] = $uid;
                    $m->add($result);

                    writeAppLog(4, '修改用户：' . $username,'', M('sys_users'));
                    $this->ajaxResponse(0, '操作成功', ['url'=>U('User/index')]); 
                } 
            }
            else{
                $this->ajaxResponse(1, '用户编辑失败！'); 
            }
        } 

        if (!$uid){
            $this->error('参数错误');exit;
        } 
       
        $m = M('sys_users');
        $result = $m->where(array('uid'=>$uid))->find();

        //获取当前所属组 
        $auth = new \Think\Auth;
        $group = $auth->getGroups($result['uid']);
        $result['group_id'] = $group[0]['group_id'];
        
        //获取所有组
        $m = M('sys_auth');
        $group = $m->order('id DESC')->select();

        $this->assign('group',$group);
        $this->assign('result',$result); 
        $this->assign('uid',$uid);
        $this->assign('admin',$admin);
        $this->display('update');
    }


    /**
     * 添加
     */
    public function add(){   
        if (IS_AJAX){ 
            $username  = I('post.username');
            $password  = I('post.password');
            $password2 = I('post.password2'); 
            $privilege = I('post.privilege');
            $bindipv4  = I('post.bindipv4');
            $bindipv6  = I('post.bindipv6');
            $name  = I('post.name');
            $department  = I('post.department');
            $post  = I('post.post');
            $email  = I('post.email');
            $phone  = I('post.tel');
            $group_id  = I('post.group_id');  

            // 判断用户名是否合法
            if (!checkUsername($username)){
                $this->ajaxResponse(1, '用户名格式错误！'); 
            }
            
            if (!$group_id){
                $this->ajaxResponse(1, '用户组为必选项！'); 
            }

            
            // 判断密码是否合法
            if (!checkPwd($password)){
                $this->ajaxResponse(1, '密码格式错误！');
                
            } 
            if ($email && !isEmail($email)) {
                $this->ajaxResponse(1, '电子邮箱格式有错误！');
                
            } 
            if ($phone && !isPhone($phone)){
                $this->ajaxResponse(1, '联系电话格式有错误！');
                
            }
            //检查用户是否已经存在
            $count = M('sys_users')->where(['uname'=>$username])->count();

            if ($count > 0){
                $this->ajaxResponse(1, '用户已经存在！'); 
            }

            if ($bindipv4){
                $bindipv4_array = explode("\r\n", $bindipv4);
                if (!empty($bindipv4_array)){
                    foreach ($bindipv4_array as $key => $tmp){
                        if (!is_ipv4($tmp)){
                            $this->ajaxResponse(1, '允许登录的IPv4地址有错误！'); 
                        }
                    }
                }
                $bindipv4_str = serialize($bindipv4_array);
            }

            if ($bindipv6){
                $bindipv6_array = explode("\r\n", $bindipv6);
                if (!empty($bindipv6_array)){
                    foreach ($bindipv6_array as $key => $tmp){
                        if (!is_ipv6($tmp)){
                            $this->ajaxResponse(1, '允许登录的IPv6地址有错误！'); 
                        }
                    }
                }
                $bindipv6_str = serialize($bindipv6_array);
            } 

            $row_value = array(
                'uname'      => $username,
                'upwd'       => md5('appbeian_'.md5($password)),
                'allowips'   => $bindipv4_str,
                'allowipv6'  => $bindipv6_str,
                'rprivilege' => $privilege_str,
                'add_time'    => time(),
                'name'    => $name,
                'department' => $department,
                'post'    => $post,
                'email'    => $email,
                'phone'    => $phone
            ); 

            if ($group_id)
            {
                $row_value['rid'] = $group_id;
            }
            // if(!M()->autoCheckToken($_POST)){
            //     $this->ajaxResponse('-1', '请不要重复提交');
            // }

            $result['uid'] = M('sys_users')->add($row_value);  
            $result['group_id'] = $group_id;

            if ($result['uid']){

                $m = M('auth_group_access');
                if($m->add($result)){
                    writeAppLog(3, '添加用户：' . $username,'', M('sys_users'));
                    $this->ajaxResponse(0, '操作成功', ['url'=>U('User/index')]); 
                }
                else{
                    $this->ajaxResponse(1, '分配用户组失败'); 
                } 
            }
            else{
                $this->ajaxResponse(1, '用户添加失败！'); 
            }
        }
        //取得当前登录用户组
        $rid = session('admin_rid');

        $m = M('sys_auth');
        $data = $m->field('id,title')->select();

        $this->assign('data',$data); 
        $this->display('add');
    }

    /**
     * 删除
     * @return [type]
     */
    public function delete(){   
        $uid = I('uid');        //用户ID 

        if($uid == 1){
            $this->ajaxResponse('0', '不允许删除超级管理员');   //不允许删除超级管理员
        }
        $m = M('auth_group_access');        
        $m->where('uid='.$uid)->delete();   //删除权限表里面给的权限t;
        $m = M('sys_users');
        $result = $m->where('uid='.$uid)->delete();
        if ($result){
            $this->ajaxResponse('0', '删除成功！','reload');
        }else {
           $this->ajaxResponse('1', '删除失败！');
        } 
        
    }

    /**
     * 修改个人资料
     * @return [type]
     */
    public function userinfo()
    {
        $admin_name = session('admin_name');
        if ($_REQUEST['doLoginSubmit'])
        {
            $password  = I('post.password');
            $password2 = I('post.password2');
            $name      = I('post.name');
            $department  = I('post.department');
            $post     = I('post.post');
            $email     = I('post.email');
            $phone     = I('post.phone');

            if ($password && $password2)
            {
                if ($password != $password2)
                {
                    $this->ajaxResponse('-1', '两次输入的密码不相同！');
                }
                
                if (!checkPwd($password))
                {
                    $this->ajaxResponse('-2', '密码格式错误');
                }

                $changepwd = true;
           
            }
            
            if ($email && !isEmail($email))
            {
                $this->ajaxResponse('-3', '电子邮箱格式有错误！');

            }
            if ($phone && !isPhone($phone))
            {
                $this->ajaxResponse('-4', '联系电话格式有错误！');
            }
            
            $set = array(
                'name' => $name,
                'department' => $department,
                'post' => $post,
                'email' => $email,
                'phone' => $phone,                
            );
            if ($changepwd === true)
            {
                $set['upwd'] = md5('appbeian_'.md5($password));
            }
            
            $return = M('sys_users')->where(['uid'=>$admin['uid']])->save($set);
            if ($return)
            {
                writeAppLog(4, '修改用户：' . $admin['uname'],'',M('sys_users'));
                $this->ajaxResponse('1', '操作成功');
            }
            $this->ajaxResponse('0', '修改失败，请重新填写');
        }
        $info_arr = M('sys_users')->where(['uid'=>$admin['uid']])->find();
        $this->assign('admin_name',$admin_name);
        $this->assign('info_arr',$info_arr);
        $this->display('userinfo');
    }
}