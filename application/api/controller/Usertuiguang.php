<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/26
 * Time: 11:26
 */

namespace app\api\controller;

use think\Controller;
use app\common\model\Jflist as JflistModel;
use app\common\model\User;
use app\common\model\UserAddress;
use app\common\model\UserBill;
use app\common\model\Jfproduct;


class Usertuiguang extends Controller
{
    /**
     * 积分商品兑换
     */
    public function index(){
        $user=User::where('user_id',input('param.user_id'))->limit(1)->find();
        $res=User::where('user_id',input('param.user_id'))->update([
                'jianjifen'=>$user['jianjifen']+input('param.needjifen'),
            ]);
        $addrInfo=UserAddress::find(input('param.address_id'))->toArray();
        $resu=JflistModel::create([
                'jflist_number'=>order_number().input('param.user_id'),
                'user_id'=>input('param.user_id'),
                'jfproduct_id'=>input('param.jfproduct_id'),
                'num'=>input('param.num'),
                'addrInfo'=>json_encode($addrInfo),
                'money'=>input('param.needjifen'),
                'addtime'=>time(),
            ]);
        UserBill::create([
            'user_id'=>input('param.user_id'),
            'jfproduct_id'=>input('param.jfproduct_id'),
            'bill_money'=>input('param.needjifen'),
            'bill_type'=>4,
            'bill_add_time'=>time(),
        ]);
        $data=[
            'res'=>$res,
            'resu'=>$resu
        ];
        $Jfproductinfo=Jfproduct::find(input('param.jfproduct_id'));
        $userInfo = User::find(input('param.user_id'));
        $data = [
            'openid' => $userInfo['openid'],
            'template_id' => 'IpMhCucTWlInZ3yrrlGAaFwAPZ_VEp2bBUAV8IHJdiQ',
            'form_id' => input('param.formid'),
            'keywordArr' => [
                'keyword1' => ['value' => $resu['jflist_number']],
                'keyword2' => ['value' => $Jfproductinfo['jfproduct_name']],
                'keyword3' => ['value' => input('param.needjifen')],
                'keyword4' => ['value' => '备注！'],
            ]
        ];
        action('api/Templatesend/send', $data);
        $this->result($data,200,'success');
    }
}