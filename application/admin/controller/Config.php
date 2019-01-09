<?php

namespace app\admin\controller;

use app\common\model\Config as ConfigModel;
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
}