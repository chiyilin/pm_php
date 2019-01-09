<?php

namespace app\api\controller;

use app\common\model\User;
use app\common\model\UserMessage;
use app\common\model\ProdListComment;
use app\common\model\UserBill;


use think\Controller;
use think\Request;

class Message extends Controller
{
    /**
     * 消息中心
     */
    public function index(Request $request)
    {
        $param = $request->post();
        $systemMessage = UserMessage::where(['user_id' => $param['user_id'], 'message_status' => 1])->order('message_add_time desc')->select()->toArray();
        $commentMessage = ProdListComment::with('product')->where(['list_comment_fid' => $param['user_id'], 'is_read' => 1])->order('list_comment_add_time desc')->select()->toArray();
//        halt($commentMessage);
        $this->result(compact('systemMessage', 'commentMessage'), 200, 'success');
    }

    /**
     * 拆红包页面
     */
    public function redPacket()
    {
        $UserMessage = UserMessage::find(input('param.id'));
        $this->result($UserMessage, 200, 'success');
    }

    /**
     * 点击拆红包
     */
    public function redPacketdo()
    {

        $UserMessage = UserMessage::find(input('param.id'));
        $UserMessage->message_status = 2;
        $res = $UserMessage->save();
        if ($UserMessage->message_type == 2) {
            //现金红包
            $result = User::where(['user_id' => input('param.user_id')])->setInc('money', $UserMessage->money);
            $ext = '元';
        } elseif ($UserMessage->message_type == 3) {
            //积分红包
            $result = User::where(['user_id' => input('param.user_id')])->setInc('addjifen', $UserMessage->money);
            $ext = '积分';
        }
        $userInfo = User::find(input('param.user_id'));
        $data = [
            'openid' => $userInfo['openid'],
            'template_id' => 'Q7PBMOex3o2Yc7TPSTWKBwfmPjq1gp5JJKG9UITsq_c',
            'form_id' => input('param.formid'),
            'keywordArr' => [
                'keyword1' => ['value' => date('Y-m-d H:i')],
                'keyword2' => ['value' => '+' . $UserMessage->money . $ext],
                'keyword3' => ['value' => '邀请奖励'],
                'keyword4' => ['value' => '备注！'],
            ]
        ];
        action('api/Templatesend/send', $data);
        UserBill::create([
            'user_id' => input('param.user_id'),
            'bill_money' => $UserMessage->money,
            'bill_type' => $UserMessage->message_type == 2 ? 1 : 2,
            'bill_add_time' => time(),
        ]);
        $this->result($result, 200, 'success');
    }

    /**
     * 我的团队
     */
    public function myteam(Request $request)
    {
        $param = $request->post();
        $userInfo = User::find($param['user_id'])->toArray();
        $userInfo['fid_chain'] = array_slice(unserialize($userInfo['fid_chain']), -2);
        $fidUserInfo = User::where('user_id', $userInfo['user_fid'])->find()->toArray();
//        $fidUserInfo = User::where('user_id','in',$userInfo['fid_chain'])->order('user_add_time')->select()->toArray();
        $myTeam = User::where('user_fid', $userInfo['user_id'])->select()->toArray();
        foreach ($myTeam as $key => $value) {
            $myTeam[$key]['user_add_time'] = date('Y-m-d H:i', $value['user_add_time']);
        }
        $this->result(compact('fidUserInfo', 'myTeam'), 200, 'success');
    }
}