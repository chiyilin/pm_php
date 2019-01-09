<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/11/13
 * Time: 11:51
 */

namespace app\api\controller;

use app\common\Curl;

use think\Controller;
use think\Config;
use app\common\model\UserHomework as UserHomeworkModel;
use app\common\model\Homework as HomeworkModel;
use app\common\model\UserHomeworkReplyImage;
use think\Request;

class Userhomework extends Controller
{
    /**
     *  个人中心-我的作业首页信息
     */
    public function index(Request $request)
    {
        $param = $request->post();
        $UserHomeworkModel = UserHomeworkModel::with('homework')
            ->where([
                'user_id' => $param['user_id'],
//                'homework_status' => $param['homework_status']
            ])
            ->select()
            ->toArray();
        $gorupData = array_group_by($UserHomeworkModel, 'homework_status');
        $this->result($gorupData, 200, 'success');
    }

    /**
     * 个人中心-我的作业详细信息
     */
    public function details(Request $request)
    {

        $param = $request->post();
//        halt($param);

        $userHomeWorkDetails = UserHomeworkModel::with(['image' => function ($query) {
            $query->order(['sort' => 'asc']);
        }, 'homework', 'product'])
            ->where([
                'user_id' => $param['user_id'],
                'user_homework_id' => $param['id']
            ])
            ->find()->toArray();
        $this->result($userHomeWorkDetails, 200, 'success');
    }

    /**
     * 上传作业
     */
    public function create(Request $request)
    {
        $param = $request->post();
        $res = UserHomeworkModel::where([
            'user_homework_id' => $param['id'],
            'homework_status' => 1,
        ])->update([
            'homework_reply' => $param['homework_reply'],
            'formid'=>$param['formid'],
            'update_time'=>time(),
            'homework_status' => 2,
        ]);
        return $this->result($res, 200, 'success');
    }

    /**
     * 上传作业图片
     */
    public function imageUpload()
    {
        $file = request()->file('image');
        $path = 'uploads/userHomeWorkReply';
        $info = $file->move($path);
        if ($info) {
            $url = $path . '/' . $info->getSaveName();
            $res = UserHomeworkReplyImage::create([
                'url' => $url,
                'user_homework_id' => input('param.id'),
                'sort' => input('param.sort'),
                'add_time' => time()
            ]);
            $this->result($res, 200, 'success');
        }
    }

}