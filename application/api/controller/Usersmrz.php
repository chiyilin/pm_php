<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/16
 * Time: 17:03
 */

namespace app\api\controller;

use think\Controller;
use app\common\model\UserSmrz as UserSmrzModel;
use app\common\model\User;

class UserSmrz extends Controller
{
    /**
     * 用户实名认证-提交服务上传图片
     */
    public function imgupload()
    {
        $sign = input('param.sign');
        $file = request()->file('image');
        $path = 'uploads/userSmrz/';
        $info = $file->move($path);
        if ($info) {
            $this->result([$sign => $path . $info->getSaveName()], 200, 'success');
        } else {
            echo $file->getError();
        }
    }

    /**
     * 验证手机号、身份证的有效性
     */
    public function check()
    {
        if (!preg_match_all("/^1[34578]\d{9}$/", input('param.smrz_mobile'))) {
            $this->result([], 400, '请填写正确格式的手机号！');
        }
        if (!validateIDCard(input('param.smrz_code'))) {
            $this->result([], 400, '请输入正确的身份证号码！');
        }
        $this->result([], 200, 'success');
    }

    /**
     * 添加一条实名认证记录
     */
    public function addsmrz()
    {
        $res = UserSmrzModel::create([
            'user_id' => input('param.user_id'),
            'smrz_name' => input('param.smrz_name'),
            'smrz_code' => input('param.smrz_code'),
            'smrz_photo' => input('param.front'),
            'smrz_photos' => input('param.side'),
            'smrz_state' => 1,
            'dizib_state' => 4,
            'smrz_type'=>input('param.smrz_type'),
            'smrz_mobile' => input('param.smrz_mobile'),
            'form_id' => input('param.form_id'),
            'smrz_addtime' => time(),
            ]);
//        User::where(['user_id' => input('param.user_id')])->update([
//             'user_mobile'=>input('param.phone'),
//        ]);
        $this->result([], 200, 'success');
    }
//
//$res = UserSmrzModel::create(['user_id' => input('param.user_id'),
//'smrz_name' => input('param.smrz_name'),
//'smrz_code' => input('param.smrz_code'),
//'smrz_photo' => $path . $info->getSaveName(),
//'smrz_state' => 1,
//'dizib_state' => 1,
//'smrz_addtime' => time(),]);
//
//$res = UserSmrzModel::where('user_id', input('param.user_id'))->update(['smrz_photos' => $path . $info->getSaveName()]);
    /**
     * 用户弟子班申请
     */
    // public function 
}