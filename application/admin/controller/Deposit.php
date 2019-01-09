<?php


namespace app\admin\controller;

use app\common\model\UserDeposit;
use app\common\Transfer;
use app\common\model\User;


use think\Config;
use think\Request;

/**
 * Class Deposit
 * @package app\admin\controller
 */
class Deposit extends Auth
{
    /**
     * @return mixed
     */
    public function index()
    {
        $res = UserDeposit::with('user')->where([])->paginate(Config::get('admin')['paginate']);
//        dump($res->toArray());
        return $this->fetch('', ['data' => $res]);

    }

    /**
     * @return false|string
     * 提现申请操作审核
     */
    public function sure()
    {
        $info = UserDeposit::with('user')->find(input('param.id'));
        if (input('param.status') == 2) {
            //通过
            $Transfer = new Transfer();
            $res = $Transfer->transfer($info['user']['openid'], $info['money']);
            if ($res['status'] != 1) {
                $info->deposit_status = 2;
                $info->save();
            }
        } else {
            //驳回
            $info->deposit_status = 3;
            $res = ['status'=>$info->save()?2:1,'msg'=>'驳回成功'];
            User::where(['user_id'=>$info['user']['user_id']])->setInc('money',$info['money']);
        }

        return json_encode($res);
    }

    /**
     * 单删
     */
    public function del()
    {
        $result = UserDeposit::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    /**
     * 多删
     */
    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';

        $idArr = implode(',', $id);
        $result = UserDeposit::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }


}