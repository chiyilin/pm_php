<?php
/**
 * 竞拍额度充值记录
 */

namespace app\admin\controller;

use app\common\model\UserRecharge as UserRechargeModel;
use think\Config;

class Userrecharge extends Auth
{
    /**
     * 用户充值首页
     */
    public function index()
    {
        $where = $search = [];
        if (input('param.user_id')) {
            $where['user_id'] = input('param.user_id');
            $search['user_id'] = input('param.user_id');
        }
        if (input('param.user_recharge_id')) {
            $where['user_recharge_id'] = input('param.user_recharge_id');
            $search['user_recharge_id'] = input('param.user_recharge_id');
        }
        if (input('param.order_number')) {
            $where['order_number'] = ['like', '%' . input('param.order_number') . '%'];
            $search['order_number'] = input('param.order_number');
        }
        if (input('param.transaction_id')) {
            $where['transaction_id'] = ['like', '%' . input('param.transaction_id') . '%'];
            $search['transaction_id'] = input('param.transaction_id');
        }
        if (input('param.is_pay')) {
            $where['is_pay'] = input('param.is_pay');
            $search['is_pay'] = input('param.is_pay');
        }
        $UserRecord = UserRechargeModel::with('user')->where($where)->order('add_time desc')->paginate($this->basicConfig['paginate']);
        $status = Config::get('status');
        return $this->fetch('', [
            'data' => $UserRecord,
            'page' => $UserRecord->render(),
            'search' => $search,
            'status' => $status,
        ]);
    }

    public function del()
    {
        $result = UserRecharge::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';

        $idArr = implode(',', $id);
        $result = UserRecharge::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}