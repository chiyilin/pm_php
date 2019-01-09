<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/8/25
 * Time: 10:57
 */

namespace app\admin\controller;

use app\common\model\MemberPrice as MemberPriceModel;
use think\Config;
use app\common\model\State;
use think\Image;

class MemberPrice extends Auth
{
    /**
     * 会员充值首页
     */
    public function index()
    {
        $MemberPriceModel = MemberPriceModel::where([])->order('sort desc,add_time')->paginate($this->basicConfig['paginate'], false, ['query' => request()->param()]);
//        dump($MemberPriceModel->toArray());
        $fxs = Config::get('miniapp')['fxs'];
        return $this->fetch('', [
            'data' => $MemberPriceModel,
            'page' => $MemberPriceModel->render(),
            'fxs' => $fxs
        ]);
    }

    /**
     * 会员充值添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $param = $this->request->param()['data'];
            $MemberPrice = new MemberPriceModel($param);
            $MemberPrice->data([
                'name' => $param['name'],
                'price' => $param['price'],
                'level' => $param['level'],
                'member_introduce' => $param['member_introduce'],
//                'time'=>$param['time']*86400*30,
                'sort' => $param['sort'],
                'add_time' => time(),
            ]);
            return $msg = $MemberPrice->save() ? json_encode([200, '添加成功']) : json_encode([400, '添加失败']);
        }
        $fxs = Config::get('miniapp')['fxs'];
        return $this->fetch('', ['fxs' => $fxs]);
    }

    /**
     * 会员充值修改
     */
    public function edit()
    {
        if ($this->request->isPost()) {
            $param = $this->request->param()['data'];

            $MemberPrice = new MemberPriceModel();
            $result = $MemberPrice->save([
                'name' => $param['name'],
                'price' => $param['price'],
                'level' => $param['level'],
                'member_introduce' => $param['member_introduce'],
//                'time'=>$param['time']*86400*30,
                'sort' => $param['sort'],
            ], [
                'id' => $param['id']
            ]);
            return $msg = $result ? json_encode([200, '修改成功']) : json_encode([400, '修改失败']);
        }
        $data = MemberPriceModel::get(input('param.id'));
//        dump($data);
        $fxs = Config::get('miniapp')['fxs'];
        return $this->fetch('', [
            'data' => $data,
            'fxs' => $fxs
        ]);
    }
    /**
     * wangEditor 上传图片
     */
    public function imageUpload()
    {
        // 获取表单上传文件
        $files = request()->file('file');
        $path = 'uploads/stateImg';
        $url = [];
        foreach ($files as $file) {
            $info = $file->move($path);
            $resImageInfo = $path . '/' . $info->getSaveName();
            $image = Image::open($resImageInfo);
            $image->thumb(1080, 1080)->save($resImageInfo);
            if ($info) {
                $url[] = getHttpHost() . '/' . $resImageInfo;
            }
        }
        $result = [
            'errno' => 0,
            'data' => $url,
        ];
        echo json_encode($result);
    }
    public function editstate()
    {
        if (request()->isPost()) {
            $param = request()->post()['data'];
            $details = request()->post()['details'];
            $res = State::update([
                'title' => $param['title'],
                'content' => htmlspecialchars_decode($details),
            ], [
                'id' => $param['id']
            ]);
            return $msg = $res ? json_encode([200, '操作成功']) : json_encode([400, '操作失败']);
        }
        $data = State::find(input('param.id'));
        return $this->fetch('/memberprice/editstate', compact('data'));
    }

    /**
     * 删除会员充值
     */
    public function del()
    {
        $result = MemberPriceModel::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    /**
     * 多选删除会员充值
     */
    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';

        $idArr = implode(',', $id);
        $result = MemberPriceModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}