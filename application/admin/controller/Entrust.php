<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/20
 * Time: 11:08
 */

namespace app\admin\controller;

use app\common\model\Entrust as EntrustModel;
use app\common\model\EntrustImage;
use think\Config;
use think\Request;

class Entrust extends Auth
{
    public function index(Request $request)
    {
        $where=$search=[];
        $get=$request->get();
        if(!empty($get['entrust_name'])){
            $search['entrust_name']=$where['entrust_name']=$get['entrust_name'];
        }
        if(!empty($get['entrust_phone'])){
            $search['entrust_phone']=$where['entrust_phone']=$get['entrust_phone'];
        }
        if(!empty($get['entrust_type'])){
            $search['entrust_type']=$where['entrust_type']=$get['entrust_type'];
        }
        $config = Config::get('admin');
        $data = EntrustModel::where($where)->order('add_time desc')->paginate($config['paginate'], false, ['query' => input('param.')]);
        return $this->fetch(null, ['data' => $data, 'config' => $config]);
    }

    public function details()
    {
        $data = EntrustModel::with(['image' => function ($query) {
            $query->order(['sort' => 'asc']);
        }])->where(['entrust_id' => input('param.id')])->find();
        return $this->fetch(null, ['data' => $data]);
    }

    public function del()
    {
        $id = input('param.id');
        $result = EntrustModel::destroy($id);
        return $msg = $result ? '删除成功' : '删除失败';
    }

    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';
        $idArr = implode(',', $id);
        $result = EntrustModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}