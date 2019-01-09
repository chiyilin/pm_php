<?php


namespace app\admin\controller;

use app\common\model\UserCollection as UserCollectionModel;
use think\Config;

class Usercollection extends Auth
{

    public function index()
    {
        $config = Config::get('admin');
        $where = $search = [];
        if (input('param.product_id')) {
            $where['product_id'] = input('param.product_id');
            $search['product_id'] = input('param.product_id');
        }
        if (input('param.user_id')) {
            $where['user_id'] = input('param.user_id');
            $search['user_id'] = input('param.user_id');
        }
        $UserCollectionModel = UserCollectionModel::with('product,user')->where($where)->order('user_id,collection_time')->paginate($this->basicConfig['paginate'], false, ['query' => input('param.')]);
        for ($i = 0; $i < count($UserCollectionModel); $i++) {
            $UserCollectionModel[$i]['collection_time'] = date('Y-m-d H:i:s', $UserCollectionModel[$i]['collection_time']);
        }
        return $this->fetch('', [
            'data' => $UserCollectionModel,
            'page' => $UserCollectionModel->render(),
            'search' => $search,
        ]);
    }

    /**
     * 删除
     */
    public function del()
    {
        $result = UserCollectionModel::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    /**
     * 多选删除
     */
    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';

        $idArr = implode(',', $id);
        $result = UserCollectionModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}