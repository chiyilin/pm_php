<?php

namespace app\admin\controller;

use app\common\model\Config as ConfigModel;
use app\common\model\CouponSetting;
use app\common\model\KdSetting;
use think\Request;
use app\common\model\Setting;


class Config extends Auth
{
    /**
     * 微信小程序、微信支付设置
     */
    public function index()
    {
        $config = ConfigModel::limit(1)->find();
        return $this->fetch('', compact('config'));
    }

    public function change(Request $request)
    {
        $data = $request->post()['data'];
        $data['show_money'] = !empty($data['show_money']) ? 1 : 2;
//        return json_encode([400,$data['show_money']]);
        $result = ConfigModel::where(['id' => 1])->update($data);
        return $msg = $result ? json_encode([200, '保存成功']) : json_encode([400, '保存失败']);
    }

    /**
     * 其他系统设置
     */
    public function Setting()
    {
        $config = Setting::limit(1)->find()->toArray();
        return $this->fetch('', compact('config'));
    }

    public function changeSetting(Request $request)
    {
        $data = $request->post()['data'];
        $updateData = [
            'default_lines' => $data['default_lines'],
            'lines_default_proportion' => $data['lines_default_proportion'],
            'lines_bad_proportion' => $data['lines_bad_proportion'],
            'server_rate' => $data['server_rate'],
            'save_day' => $data['save_day'],
            'postage_proportion' => $data['postage_proportion'],
        ];
        $result = Setting::where(['id' => 1])->update($updateData);
        return $msg = $result ? json_encode([200, '保存成功']) : json_encode([400, '保存失败']);
    }

    /**
     * 快递100参数设置
     */
    public function kdSetting()
    {
        $data = KdSetting::limit(1)->find();
        return $this->fetch(null, compact('data'));
    }

    public function changeKdSetting(Request $request)
    {
        $data = $request->post()['data'];
        $updateData = [
            'key' => $data['key'],
            'secret' => $data['secret'],
            'customer' => $data['customer'],
        ];
        $result = KdSetting::where(['kd_setting_id' => 1])->update($updateData);
        return $msg = $result ? json_encode([200, '保存成功']) : json_encode([400, '保存失败']);
    }

    /**
     * 系统优惠券设置
     */

    public function couponSetting()
    {
        $data = CouponSetting::order(['add_time' => 'desc'])->paginate();
//        halt($data->toArray());
        return $this->fetch(null, [
            'data' => $data,
            'page' => $data->render(),
        ]);
    }

    public function couponAdd(Request $request)
    {
        if ($request->isPost()) {
            $param = $request->param()['data'];
            $result = CouponSetting::create([
                'need_money' => $param['need_money'],
                'get_this_money' => $param['get_this_money'],
                'money' => $param['money'],
                'useful_life' => $param['useful_life'],
                'status' => !empty($param['status']) ? 1 : 2,
                'add_time' => time(),
            ]);
            return $result ? json_encode([200, '添加成功！']) : json_encode([400, '添加失败！']);
        }
        return $this->fetch(null);
    }

    public function couponEdit(Request $request)
    {
        if ($request->isPost()) {
            $param = $request->param()['data'];
            $result = CouponSetting::where([
                'coupon_setting_id' => $param['coupon_setting_id']
            ])->update([
                'need_money' => $param['need_money'],
                'get_this_money' => $param['get_this_money'],
                'money' => $param['money'],
                'useful_life' => $param['useful_life'],
                'status' => !empty($param['status']) ? 1 : 2,
                'add_time' => time(),
            ]);
            return $result ? json_encode([200, '保存成功！']) : json_encode([400, '保存失败！']);
        }
        $config = CouponSetting::find($request->param()['id']);
        return $this->fetch(null, compact('config'));
    }

    public function couponEditStatus()
    {
        $param = input('param.');
        $BannerModel = new CouponSetting();
        $result = $BannerModel->save(
            [
                'status' => $param['value']
            ], [
                'coupon_setting_id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    public function couponDel()
    {
        $id = input('param.id');
        $result = CouponSetting::destroy($id);
        return $msg = $result ? '删除成功' : '删除失败';
    }


    public function couponDelAll()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';
        $idArr = implode(',', $id);
        $result = CouponSetting::where('coupon_setting_id', 'in', $idArr)->delete();
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}