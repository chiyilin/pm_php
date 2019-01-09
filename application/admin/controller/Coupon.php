<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/3
 * Time: 15:36
 */

namespace app\admin\controller;

use app\common\model\Coupon as CouponModel;
use think\Request;

class Coupon extends Auth
{
    public function index(Request $request)
    {
        $where = $search = [];
        $param = $request->param();
        if (!empty($param['user_id'])) {
            $where['user_id'] = input('param.user_id');
            $search['user_id'] = input('param.user_id');
        }
        $data = CouponModel::where($where)->with('user')->paginate($this->basicConfig['paginate'], false, ['query' => $param]);
        return $this->fetch(null, [
            'data' => $data,
            'page' => $data->render(),
            'search' => $search,
        ]);
    }

    /**
     * 删除
     */
    public function del()
    {
        $result = CouponModel::destroy(input('param.id'));
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
        $result = CouponModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}