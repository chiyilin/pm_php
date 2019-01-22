<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/22
 * Time: 9:43
 */

namespace app\admin\controller;

use app\common\model\UserLinesRecord as UserLinesRecordModel;
use think\Config;
use think\Request;

class userlinesrecord extends Auth
{
    public function index(Request $request)
    {
        $param = $request->param();
        $where = $search = [];
        if (!empty($param['start'])) {
            $where['record_add_time'] = ['>=', strtotime($param['start'])];
            $search['start'] = $param['start'];
        }
        if (!empty($param['end'])) {
            $where['record_add_time'] = ['<=', strtotime($param['end'])];
            $search['end'] = $param['end'];
        }
        if (!empty($param['end']) && !empty($param['start'])) {
            $where['record_add_time'] = ['between', [strtotime($param['start']), strtotime($param['end'])]];
            $search['end'] = $param['end'];
            $search['start'] = $param['start'];
        }
        if (!empty($param['user_id'])) {
            $where['user_id'] = $param['user_id'];
            $search['user_id'] = $param['user_id'];
        }
        if (!empty($param['type'])) {
            $where['type'] = $param['type'];
            $search['type'] = $param['type'];
        }
        if (!empty($param['lines_record_id'])) {
            $where['lines_record_id'] = $param['lines_record_id'];
            $search['lines_record_id'] = $param['lines_record_id'];
        }
        $config = Config::get('admin');
        $data = UserLinesRecordModel::with(['user'])->where($where)->order(['record_add_time' => 'desc'])->paginate($config['paginate'], false, ['query' => $param]);
        $type = Config::get('status')['user_lines_redord_type'];
        return $this->fetch(null, compact('data', 'type', 'search'));
    }

    public function del()
    {
        $result = UserLinesRecordModel::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return json_encode([400, '请选中后操作！']);

        $idArr = implode(',', $id);
        $result = UserLinesRecordModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}